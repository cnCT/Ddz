//
//  TestSocket.cpp
//  
//
//  Created by CT on 9/18/15.
//
//

#include "GameNetDelegate.h"
#include "cocos2d.h"
#include "GlobalDef.h"
#include "CMD_Plaza.h"
#include "GlobalField.h"
#include "CMD_Game.h"
#include <cstdio>
#include <map>
#include "Encrypt.h"
#include "CCLuaEngine.h"
#include <cstdlib>
#include <arpa/inet.h>
USING_NS_CC;

GameNetDelegate::GameNetDelegate()
{
    
}

GameNetDelegate::~GameNetDelegate()
{
    
}

GameNetDelegate* GameNetDelegate::getInstance()
{
    static GameNetDelegate netDelegate;
    return &netDelegate;
}

void GameNetDelegate::onMessageReceived(const char *data, unsigned short size)
{
//    CCLOG("onMessageReceived, size is %d %d", size, size - sizeof(CMD_Head));
    CMD_Command Command = ((CMD_Head *)data)->CommandInfo;
    
    auto stack = LuaEngine::getInstance()->getLuaStack();
    stack->pushInt(Command.wMainCmdID);
    stack->pushInt(Command.wSubCmdID);
    stack->pushString(data + sizeof(CMD_Head), size - sizeof(CMD_Head));
    auto it = m_callBacks.find("onReceived");
    stack->executeFunctionByHandler(it->second, 3);
    stack->clean();
}
//
//void GameNetDelegate::onMessageReceived(const TRecvData &td)
//{
//    if (count == 0)
//        switch (td.m_wSubCmdID) {
//            case SUB_GP_LOGON_SUCCESS:
//                assert(td.m_size != sizeof(CMD_GP_LogonSuccess));
//                CMD_GP_LogonSuccess * pLogonSuccess=(CMD_GP_LogonSuccess *)td.m_data;
//                m_userID = pLogonSuccess->dwUserID;
//                auto gameID = pLogonSuccess->dwGameID;
//                CCLOG("GameId is %d", gameID);
//                
//                close();
//                CCInetAddress oAddres;
//                oAddres.setIp("192.168.0.188");
//                oAddres.setPort(22222);
//                setInetAddress(oAddres);
//                connect();
//                break;
//        }
//    else
//        switch (td.m_wSubCmdID) {
//            case SUB_GR_LOGON_SUCCESS:
//                CCLOG("Goto room!!!");
//                break;
//        }
//}

std::map<int, std::function<bool(const char *data, long len)>> Func;

std::string getMD5(std::string str)
{
    char szMD5Result[33] = {0};
    CMD5Encrypt::EncryptData((char *)str.c_str(), szMD5Result);
    return szMD5Result;
}

void GameNetDelegate::onConnected()
{
    CCLOG("onConnected");
    
//    char usr[] = "test55";
//    char pas[] = "ewq123";
//    std::string password(pas);
//    //获取信息
//    BYTE cbBuffer[4096];
//    memset(cbBuffer, 0, 4096);
//    //登录数据包
//    struct CMD_GP_LogonByAccounts * pLogonByAccounts=(struct CMD_GP_LogonByAccounts *)cbBuffer;
//    pLogonByAccounts->dwPlazaVersion=131073;
//    strcpy((char *)pLogonByAccounts->szPassWord,getMD5(password).c_str());
//    strcpy((char *)pLogonByAccounts->szAccounts,usr);
//    
//    //机器序列号
//    BYTE * p = cbBuffer+sizeof(CMD_GP_LogonByAccounts);
//    tagDataDescribe DataDescribe;
//    DataDescribe.wDataDescribe = DTP_COMPUTER_ID;
//    DataDescribe.wDataSize = sizeof(tagClientSerial);
//    memcpy(p, &DataDescribe, sizeof(tagDataDescribe));
//    p += sizeof(struct tagDataDescribe);
//    
//    tagClientSerial ClientSerial;
//    memset(&ClientSerial, 0, sizeof(tagClientSerial));
//    memcpy(p, &ClientSerial, sizeof(tagClientSerial));
//    
//    //发送数据包
//    sendPacket(MDM_GP_LOGON, SUB_GP_LOGON_ACCOUNTS, cbBuffer, sizeof(CMD_GP_LogonByAccounts)+sizeof(tagClientSerial)+sizeof(tagDataDescribe));
    
    dispatchEvent("onConnected");
}

bool GameNetDelegate::sendDataLua(WORD wMainCmdID,WORD wSubCmdID,unsigned char * data,WORD size)
{
    if (wMainCmdID == 101 && wSubCmdID == 1)
    {
        CCLOG("xxx");
    }
    //发送数据包
    sendPacket(wMainCmdID, wSubCmdID, (void*)data, size);
    return true;
}

void GameNetDelegate::onConnectTimeout()
{
    CCLOG("onConnectTimeout");
    dispatchEvent("onConnectTimeout");
}

void GameNetDelegate::onDisconnected()
{
    CCLOG("onDisconnected");
    dispatchEvent("onDisconnected");
}

void GameNetDelegate::onExceptionCaught(CCSocketStatus eStatus)
{
    CCLOG("onExceptionCaught %d", (int)eStatus);
    dispatchEvent("onError");
}

void GameNetDelegate::dispatchEvent(std::string event)
{
    auto stack = LuaEngine::getInstance()->getLuaStack();
    stack->pushString(event.c_str());
    auto it = m_callBacks.find("netStatus");
    stack->executeFunctionByHandler(it->second, 1);
    stack->clean();
}

void GameNetDelegate::registerScriptHandler(std::string event, LUA_FUNCTION funcID)
{
    unregisterScriptHandler(event);
    m_callBacks[event] = funcID;
}

void GameNetDelegate::unregisterScriptHandler(std::string event)
{
    auto it = m_callBacks.find(event);
    if (it!=m_callBacks.end()) {
        LuaEngine::getInstance()->removeScriptHandler(it->second);
        m_callBacks.erase(it);
    }
}

void GameNetDelegate::connectByIpPort(const char *ip, unsigned short port)
{
    CCInetAddress oAddres;
    oAddres.setIp(ip);
    oAddres.setPort(port);
    setInetAddress(oAddres);
    connect();
}

std::string GameNetDelegate::toStrIP(DWORD dwIP)
{
    in_addr addr;
    addr.s_addr = dwIP;
    return inet_ntoa(addr);
}