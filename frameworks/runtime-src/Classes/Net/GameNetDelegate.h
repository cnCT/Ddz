//
//  TestSocket.h
//  
//
//  Created by CT on 9/18/15.
//
//

#ifndef ____TestSocket__
#define ____TestSocket__

#include <stdio.h>
#include "cocos2d.h"
#include "CCSocket.h"
#include "CCNetDelegate.h"
#include "GlobalDef.h"
#include "CCLuaValue.h"
#include <map>

USING_NS_CC;

class GameNetDelegate : public CCNetDelegate
{
    
public:
    GameNetDelegate();
    virtual ~GameNetDelegate();
    
    static GameNetDelegate* getInstance();
    
    virtual void onMessageReceived(const char *data, unsigned short size) override;
    virtual void onConnected() override;
    virtual void onConnectTimeout() override;
    virtual void onDisconnected() override;
    virtual void onExceptionCaught(CCSocketStatus eStatus) override;
    
    void connectByIpPort(const char *ip, unsigned short port);
    bool sendDataLua(unsigned short wMainCmdID,unsigned short wSubCmdID,unsigned char * data,unsigned short size);
    void registerScriptHandler(std::string event, LUA_FUNCTION funcID);
    void unregisterScriptHandler(std::string event);
    static std::string toStrIP(unsigned int dwIP);
    
    void dispatchEvent(std::string event);
public:
    // 用于存储lua回调 handler
    std::map<std::string, LUA_FUNCTION> m_callBacks;
};

#endif /* defined(____TestSocket__) */
