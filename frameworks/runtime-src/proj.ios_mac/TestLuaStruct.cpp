//
//  TestLuaStruct.cpp
//  HelloLua
//
//  Created by CT on 9/25/15.
//
//

#include "TestLuaStruct.hpp"
#include "CCLuaEngine.h"
#include "CCLuaStack.h"
#include "cocos2d.h"
#include "lua.h"
#include "lualib.h"
#include "CMD_Game.h"
USING_NS_CC;

struct test {
    int a;
    char b;
    char c;
};

void TestLuaStruct::testToLua()
{
    auto luaStack = LuaEngine::getInstance()->getLuaStack();
    auto L = luaStack->getLuaState();
    
    char buff[4096];
    auto t = (CMD_GR_OrderInfo *)buff;
    t->wOrderCount = 2;
    t->OrderItem[0].lScore = 10;
    memset(t->OrderItem[0].wOrderDescribe, 0, 16*sizeof(t->OrderItem[0].wOrderDescribe[0]));
    t->OrderItem[1].lScore = 11;
    memset(t->OrderItem[1].wOrderDescribe, 0, 16*sizeof(t->OrderItem[0].wOrderDescribe[0]));
    lua_getglobal(L, "struct_test_d");
    lua_pushlstring(L, buff, sizeof(CMD_GR_OrderInfo));
    lua_call(L, 1, 0);
    lua_pop(L, 2);
}

void TestLuaStruct::testFromLua(const char *data, long size)
{
    test *t = (test *)data;
    CCLOG("Data is %d %c %c,Size is %ld", t->a, t->b, t->c, size);
    
}