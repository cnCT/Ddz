/****************************************************************************
Copyright (c) 2014 Lijunlin - Jason lee

Created by Lijunlin - Jason lee on 2014

jason.lee.c@foxmail.com
http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/
#include "CCNetDelegate.h"
#include "GlobalDef.h"

NS_CC_BEGIN

CCNetDelegate::CCNetDelegate()
: m_fSoTimeout(SOCKET_SOTIMEOUT)
, m_eStatus(eSocketIoClosed)
, m_fConnectingDuration(0.0f)
, m_bRunSchedule(false)
,m_wRecvSize(0)
,m_cbSendRound(0)
,m_cbRecvRound(0)
,m_dwSendXorKey(0)
,m_dwRecvXorKey(0)
,m_dwSendTickCount(0)
,m_dwRecvTickCount(0)
,m_dwSendPacketCount(0)
,m_dwRecvPacketCount(0)
{
	
}

CCNetDelegate::~CCNetDelegate()
{
	m_oSocket.ccClose();

	while(!m_lSendBuffers.empty())
	{
		CC_SAFE_DELETE_ARRAY(m_lSendBuffers.front().pBuffer);
		m_lSendBuffers.pop_front();
	}
}

void CCNetDelegate::setInetAddress(const CCInetAddress& oInetAddress)
{
	m_oInetAddress = oInetAddress;
}

const CCInetAddress& CCNetDelegate::getInetAddress() const
{
	return m_oInetAddress;
}

void CCNetDelegate::setSoTimeout(float fSoTimeout)
{
	m_fSoTimeout = fSoTimeout;
}

float CCNetDelegate::getSoTimeout() const
{
	return m_fSoTimeout;
}

void CCNetDelegate::send(char* pBuffer, unsigned int uLen)
{
	if( !pBuffer || uLen == 0 || !isConnected() )
		return;
	
#if USING_PACKAGE_HEAD_LENGTH
	CCBuffer* pBuf = new CCBuffer(pBuffer, uLen);
	pBuf->autorelease();
	send(pBuf);
#else
	char* pTemp = new char[uLen];
	memcpy(pTemp, pBuffer, uLen);

	_SENDBUFFER tBuf;
	tBuf.pBuffer = pTemp;
	tBuf.nLength = (int)uLen;
	tBuf.nOffset = 0;

	m_lSendBuffers.push_back(tBuf);
#endif
}

void CCNetDelegate::send(CCBuffer* pBuffer)
{
	if( pBuffer->empty() || !isConnected() )
		return;

#if USING_PACKAGE_HEAD_LENGTH
	unsigned int u_len = pBuffer->length();
	pBuffer->moveRight(sizeof(unsigned int));
	pBuffer->moveWriterIndexToFront();
	pBuffer->writeUInt(u_len);
#endif

	pBuffer->moveReaderIndexToFront();
	char* pData = pBuffer->readWholeData();
	int nLength = (int)pBuffer->length();
	pBuffer->moveReaderIndexToFront();

	_SENDBUFFER tBuf;
	tBuf.pBuffer = pData;
	tBuf.nLength = nLength;
	tBuf.nOffset = 0;

	m_lSendBuffers.push_back(tBuf);
}

bool CCNetDelegate::isConnected()
{
	return m_eStatus == eSocketConnected;
}

bool CCNetDelegate::connect()
{
	if( m_eStatus != eSocketConnected && m_eStatus != eSocketConnecting )
	{
        m_wRecvSize = 0;
        m_cbSendRound = 0;
        m_cbRecvRound = 0;
        m_dwSendTickCount = 0;
        m_dwRecvTickCount = 0;
        m_dwSendPacketCount = 0;
        m_dwRecvPacketCount = 0;
        
		m_oSocket.setInetAddress(m_oInetAddress);
		if( m_oSocket.ccConnect() )
		{
			registerScheduler();
			m_eStatus = eSocketConnecting;
			return true;
		}
		else
		{
			m_oSocket.ccClose();
			m_eStatus = eSocketConnectFailed;
			onExceptionCaught(eSocketConnectFailed);
		}
	}
	return false;
}

void CCNetDelegate::disconnect()
{
	if( m_eStatus == eSocketConnected )
	{
		unregisterScheduler();
		m_oSocket.ccDisconnect();
		m_eStatus = eSocketDisconnected;
		onDisconnected();
	}
}

void CCNetDelegate::close()
{
	if( m_eStatus == eSocketConnected )
	{
        m_wRecvSize = 0;
		unregisterScheduler();
		m_oSocket.ccClose();
		m_eStatus = eSocketIoClosed;
		onDisconnected();
	}
}

void CCNetDelegate::runSchedule(float dt)
{
	switch( m_eStatus )
	{
	case eSocketConnecting:
		{
			switch( m_oSocket.ccIsConnected() )
			{
			case eSocketConnected:
				{
					m_eStatus = eSocketConnected;
					onConnected();
				}
				break;
			case eSocketConnectFailed:
				{
					unregisterScheduler();
                    m_oSocket.ccClose();
					m_eStatus = eSocketConnectFailed;
					onExceptionCaught(eSocketConnectFailed);
				}
				break;
			case eSocketConnecting:
				{
					if( m_fConnectingDuration > m_fSoTimeout )
					{
						unregisterScheduler();
						m_oSocket.ccDisconnect();
						m_eStatus = eSocketDisconnected;
						onConnectTimeout();
						m_fConnectingDuration = 0.0f;
					}
					else
					{
						m_fConnectingDuration += dt;
					}
				}
				break;
			default:
				break;
			}
		}
		break;
	case eSocketConnected:
		{
#if HANDLE_ON_SINGLE_FRAME
			while( m_oSocket.ccIsReadable() )
#else
			if( m_oSocket.ccIsReadable() )
#endif
			{
				if( this->runReadByte() ) return;
			}

#if HANDLE_ON_SINGLE_FRAME
			while( m_oSocket.ccIsWritable() && !m_lSendBuffers.empty() )
#else
			if( m_oSocket.ccIsWritable() && !m_lSendBuffers.empty() )
#endif
			{
				if( this->runWrite() ) return;
			}
		}
		break;
	default:
		break;
	}	
}

bool CCNetDelegate::runRead()
{
	int nRet = m_oSocket.ccRead(m_pReadBuffer, sizeof(m_pReadBuffer));
	if( nRet == eSocketIoError || nRet == eSocketIoClosed )
	{
		unregisterScheduler();
		m_oSocket.ccClose();
		m_eStatus = eSocketIoClosed;
		onDisconnected();
		return true;
	}
	else
	{
#if 1
		CCLOG("CCSOCKET READ %d", nRet);
#endif
		m_oReadBuffer.writeData(m_pReadBuffer, (unsigned int)nRet);
#if USING_PACKAGE_HEAD_LENGTH
        
        m_oReadBuffer.moveReaderIndexToFront();
        int n_head_len = m_oReadBuffer.readInt();
        if( n_head_len <= 0 )
        {
            CCLOGERROR("invalidate head length");
            m_oReadBuffer.moveLeft(sizeof(int));
        }

        int n_content_len = (int)m_oReadBuffer.length();
        if( n_content_len - (int)(sizeof(int)) >= n_head_len )
        {
            m_oReadBuffer.moveLeft(sizeof(unsigned int));
            CCBuffer* pData = m_oReadBuffer.readData(n_head_len);
            m_oReadBuffer.moveLeft(n_head_len);
            m_oReadBuffer.moveReaderIndexToFront();
            m_oReadBuffer.moveWriterIndexToBack();

            onMessageReceived(*pData);
        }
        else
        {
            break;
        }
#else
		CCBuffer* pData = (CCBuffer*) m_oReadBuffer.copy();
		pData->autorelease();
		m_oReadBuffer.clear();
		
		onMessageReceived(*pData);
#endif
	}
	return false;
}

bool CCNetDelegate::runReadByte()
{
    int nRet = m_oSocket.ccRead(m_pReadBuffer + m_wRecvSize, sizeof(m_pReadBuffer) - m_wRecvSize);
    if( nRet == eSocketIoError || nRet == eSocketIoClosed )
    {
        unregisterScheduler();
        m_oSocket.ccClose();
        m_eStatus = eSocketIoClosed;
        onDisconnected();
        return true;
    }
    else
    {
#if 1
        CCLOG("CCSOCKET READ %d", nRet);
#endif
        m_wRecvSize += nRet;
        BYTE cbDataBuffer[SOCKET_BUFFER+sizeof(CMD_Head)];
        WORD wPacketSize = 0;
        CMD_Head * pHead = (CMD_Head *)m_pReadBuffer;
        while( m_wRecvSize >= sizeof(CMD_Head) )
        {
            //效验参数
            wPacketSize = pHead->CmdInfo.wPacketSize;
            //            ASSERT(pHead->CmdInfo.cbVersion == SOCKET_VER);
            //            ASSERT(wPacketSize <= (SOCKET_BUFFER + sizeof(CMD_Head)));
            if (pHead->CmdInfo.cbVersion != SOCKET_VER) throw std::string("数据包版本错误");
            if (wPacketSize > (SOCKET_BUFFER + sizeof(CMD_Head))) throw std::string("数据包太大");
            if (m_wRecvSize < wPacketSize) return 1;
            
            //拷贝数据
            m_dwRecvPacketCount++;
            
            memcpy(cbDataBuffer, m_pReadBuffer, wPacketSize);
            m_wRecvSize -= wPacketSize;
            memcpy(m_pReadBuffer, m_pReadBuffer + wPacketSize, m_wRecvSize);
            
            //解密数据
            WORD wRealySize=CrevasseBuffer(cbDataBuffer,wPacketSize);
            
            //解释数据
            WORD wDataSize = wRealySize - sizeof(CMD_Head);
            void * pDataBuffer = cbDataBuffer + sizeof(CMD_Head);
            CMD_Command Command = ((CMD_Head *)cbDataBuffer)->CommandInfo;
            
            //内核命令
            if (Command.wMainCmdID == MDM_KN_COMMAND)
            {
                switch (Command.wSubCmdID)
                {
                    case SUB_KN_DETECT_SOCKET:	//网络检测
                    {
                        //发送数据
                        sendPacket(MDM_KN_COMMAND, SUB_KN_DETECT_SOCKET, pDataBuffer, wDataSize);
                        break;
                    }
                }
                continue;
            }
            
            //处理数据
            //            bool bSuccess = m_pITCPSocketSink->OnEventTCPSocketRead(GetSocketID(), Command, pDataBuffer, wDataSize);
            //            if (bSuccess == false) throw std::string("网络数据包处理失败");
            
            onMessageReceived((const char *)cbDataBuffer, wRealySize);
        }
    }
    return false;
}

bool CCNetDelegate::runWrite()
{
	_SENDBUFFER& tBuffer = m_lSendBuffers.front();

	int nRet = m_oSocket.ccWrite(tBuffer.pBuffer + tBuffer.nOffset, tBuffer.nLength - tBuffer.nOffset);
#if 1
	CCLOG("CCSOCKET WRITE %d", nRet);
#endif
	if( nRet == eSocketIoError )
	{
		unregisterScheduler();
		m_oSocket.ccClose();
		m_eStatus = eSocketIoClosed;
		onDisconnected();
		return true;
	}
	else if( nRet == tBuffer.nLength - tBuffer.nOffset )
	{
		CC_SAFE_DELETE_ARRAY(tBuffer.pBuffer);
		m_lSendBuffers.pop_front();
	}
	else
	{
		tBuffer.nOffset += nRet;
	}
	return false;
}

void CCNetDelegate::registerScheduler()
{
	if( m_bRunSchedule )
		return;

	CCDirector::sharedDirector()->getScheduler()->scheduleSelector(
		schedule_selector(CCNetDelegate::runSchedule), 
		this, 
		0.0f, 
		false
	);
	m_bRunSchedule = true;
}

void CCNetDelegate::unregisterScheduler()
{
	if( !m_bRunSchedule )
		return;

	CCDirector::sharedDirector()->getScheduler()->unscheduleSelector(
		schedule_selector(CCNetDelegate::runSchedule),
		this
	);
	m_bRunSchedule = false;
}

void CCNetDelegate::onMessageReceived(CCBuffer& oBuffer)
{
    
}

void CCNetDelegate::sendPacket(WORD wMainCmdID,WORD wSubCmdID,void* data,WORD size)
{
    //构造数据
    BYTE cbDataBuffer[4096];
    CMD_Head * pHead=(CMD_Head *)cbDataBuffer;
    pHead->CommandInfo.wMainCmdID=wMainCmdID;
    pHead->CommandInfo.wSubCmdID=wSubCmdID;
    if (size>0 && data != NULL)
    {
        memcpy(pHead+1,data,size);
    }
    
    //加密数据
    WORD wSendSize=EncryptBuffer(cbDataBuffer,sizeof(CMD_Head)+size,sizeof(cbDataBuffer));
    
    CCLOG("Send Main:%d sub:%d ,size is %d",wMainCmdID, wSubCmdID, size);
    //发送数据
    send((char *)cbDataBuffer, (unsigned int)wSendSize);
}
//解密数据
WORD CCNetDelegate::CrevasseBuffer(BYTE* pcbDataBuffer,WORD wDataSize)
{
    //调整长度
    WORD wSnapCount=0;
    if ((wDataSize%sizeof(DWORD))!=0)
    {
        wSnapCount=sizeof(DWORD)-wDataSize%sizeof(DWORD);
        memset(pcbDataBuffer+wDataSize,0,wSnapCount);
    }
    
    //解密数据
    DWORD dwXorKey=m_dwRecvXorKey;
    DWORD * pdwXor=(DWORD *)(pcbDataBuffer+4);
    WORD  * pwSeed=(WORD *)(pcbDataBuffer+4);
    WORD wEncrypCount=(wDataSize+wSnapCount-4)/4;
    for (WORD i=0;i<wEncrypCount;i++)
    {
        if ((i==(wEncrypCount-1))&&(wSnapCount>0))
        {
            BYTE * pcbKey=((BYTE *)&m_dwRecvXorKey)+sizeof(DWORD)-wSnapCount;
            memcpy(pcbDataBuffer+wDataSize,pcbKey,wSnapCount);
        }
        dwXorKey=SeedRandMap(*pwSeed++);
        dwXorKey|=((DWORD)SeedRandMap(*pwSeed++))<<16;
        dwXorKey^=g_dwPacketKey;
        *pdwXor++^=m_dwRecvXorKey;
        m_dwRecvXorKey=dwXorKey;
    }
    
    //效验码与字节映射
    struct CMD_Head * pHead=(struct CMD_Head *)pcbDataBuffer;
    BYTE cbCheckCode=pHead->CmdInfo.cbCheckCode;
    for (int i=4;i<wDataSize;i++)
    {
        pcbDataBuffer[i]=MapRecvByte(pcbDataBuffer[i]);
        cbCheckCode+=pcbDataBuffer[i];
    }
    //	if (cbCheckCode!=0) throw TEXT("数据包效验码错误");
    
    return wDataSize;
}

//加密数据
WORD CCNetDelegate::EncryptBuffer(BYTE* pcbDataBuffer,WORD wDataSize,WORD wBufferSize)
{
    //调整长度
    WORD wEncryptSize=wDataSize-4,wSnapCount=0;
    if ((wEncryptSize%sizeof(DWORD))!=0)
    {
        wSnapCount=sizeof(DWORD)-wEncryptSize%sizeof(DWORD);
        memset(pcbDataBuffer+4+wEncryptSize,0,wSnapCount);
        
    }
    
    //效验码与字节映射
    BYTE cbCheckCode=0;
    for (WORD i=4;i<wDataSize;i++)
    {
        cbCheckCode+=pcbDataBuffer[i];
        pcbDataBuffer[i]=MapSendByte(pcbDataBuffer[i]);
    }
    
    //填写信息头
    struct CMD_Head * pHead=(struct CMD_Head *)pcbDataBuffer;
    pHead->CmdInfo.cbCheckCode=~cbCheckCode+1;
    pHead->CmdInfo.wPacketSize=wDataSize;
    pHead->CmdInfo.cbVersion=0x66;
    
    //创建密钥
    DWORD dwXorKey=m_dwSendXorKey;
    if (m_dwSendPacketCount==0)
    {
        //生成第一次随机种子
        dwXorKey = rand();
        
        //随机映射种子
        dwXorKey=SeedRandMap((WORD)dwXorKey);
        dwXorKey|=((DWORD)SeedRandMap((WORD)(dwXorKey>>16)))<<16;
        dwXorKey^=g_dwPacketKey;
        m_dwSendXorKey=dwXorKey;
        m_dwRecvXorKey=dwXorKey;
    }
    
    //加密数据
    WORD * pwSeed=(WORD *)(pcbDataBuffer+4);
    DWORD * pdwXor=(DWORD *)(pcbDataBuffer+4);
    WORD wEncrypCount=(wEncryptSize+wSnapCount)/sizeof(DWORD);
    for (int i=0;i<wEncrypCount;i++)
    {
        *pdwXor++^=dwXorKey;
        dwXorKey=SeedRandMap(*pwSeed++);
        dwXorKey|=((DWORD)SeedRandMap(*pwSeed++))<<16;
        dwXorKey^=g_dwPacketKey;
    }
    
    //插入密钥
    if (m_dwSendPacketCount==0)
    {
        memmove(pcbDataBuffer+sizeof(struct CMD_Head)+sizeof(DWORD),pcbDataBuffer+sizeof(struct CMD_Head),wDataSize);
        *((DWORD *)(pcbDataBuffer+sizeof(struct CMD_Head)))=m_dwSendXorKey;
        pHead->CmdInfo.wPacketSize+=sizeof(DWORD);
        wDataSize+=sizeof(DWORD);
    }
    
    //设置变量
    m_dwSendPacketCount++;
    m_dwSendXorKey=dwXorKey;
    
    return wDataSize;
}
//字节映射
WORD CCNetDelegate::SeedRandMap(WORD wSeed)
{
    DWORD dwHold=wSeed;
    return (WORD)((dwHold=dwHold*241103L+2533101L)>>16);
}
//发送映射 
BYTE CCNetDelegate::MapSendByte(BYTE cbData)
{
    BYTE cbMap=g_SendByteMap[(BYTE)(cbData+m_cbSendRound)];
    m_cbSendRound+=3;
    return cbMap;
}
//接收映射 
BYTE CCNetDelegate::MapRecvByte(BYTE cbData)
{
    BYTE cbMap=g_RecvByteMap[cbData]-m_cbRecvRound;
    m_cbRecvRound+=3;
    return cbMap;
}
NS_CC_END