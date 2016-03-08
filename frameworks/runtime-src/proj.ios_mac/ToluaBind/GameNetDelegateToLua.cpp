/*
** Lua binding: GameNetDelegate
** Generated automatically by tolua++-1.0.92 on Tue Sep 29 13:48:16 2015.
*/

/****************************************************************************
 Copyright (c) 2011 cocos2d-x.org

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
/*extern "C" {
#include "tolua_fix.h"
}*/

#include <map>
#include <string>
#include "cocos2d.h"
#include "CCLuaEngine.h"
#include "SimpleAudioEngine.h"
#include "cocos-ext.h"
#include "toluabind.h"

using namespace cocos2d;
using namespace cocos2d::extension;
using namespace CocosDenshion;

/* Exported function */
TOLUA_API int  tolua_GameNetDelegate_open (lua_State* tolua_S);


/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 
 tolua_usertype(tolua_S,"CCNetDelegate");
 tolua_usertype(tolua_S,"GameNetDelegate");
 tolua_usertype(tolua_S,"CGameTools");
}

/* method: getInstance of class  GameNetDelegate */
#ifndef TOLUA_DISABLE_tolua_GameNetDelegate_GameNetDelegate_getInstance00
static int tolua_GameNetDelegate_GameNetDelegate_getInstance00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"GameNetDelegate",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   GameNetDelegate* tolua_ret = (GameNetDelegate*)  GameNetDelegate::getInstance();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"GameNetDelegate");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getInstance'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: connectByIpPort of class  GameNetDelegate */
#ifndef TOLUA_DISABLE_tolua_GameNetDelegate_GameNetDelegate_connectByIpPort00
static int tolua_GameNetDelegate_GameNetDelegate_connectByIpPort00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"GameNetDelegate",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  GameNetDelegate* self = (GameNetDelegate*)  tolua_tousertype(tolua_S,1,0);
  const char* ip = ((const char*)  tolua_tostring(tolua_S,2,0));
  unsigned short port = ((unsigned short)  tolua_tonumber(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'connectByIpPort'", NULL);
#endif
  {
   self->connectByIpPort(ip,port);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'connectByIpPort'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: sendDataLua of class  GameNetDelegate */
#ifndef TOLUA_DISABLE_tolua_GameNetDelegate_GameNetDelegate_sendDataLua00
static int tolua_GameNetDelegate_GameNetDelegate_sendDataLua00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"GameNetDelegate",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isstring(tolua_S,4,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,5,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,6,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  GameNetDelegate* self = (GameNetDelegate*)  tolua_tousertype(tolua_S,1,0);
  unsigned short wMainCmdID = ((unsigned short)  tolua_tonumber(tolua_S,2,0));
  unsigned short wSubCmdID = ((unsigned short)  tolua_tonumber(tolua_S,3,0));
  unsigned char* data = ((unsigned char*)  tolua_tostring(tolua_S,4,0));
  unsigned short size = ((unsigned short)  tolua_tonumber(tolua_S,5,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'sendDataLua'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->sendDataLua(wMainCmdID,wSubCmdID,data,size);
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'sendDataLua'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: registerScriptHandler of class  GameNetDelegate */
#ifndef TOLUA_DISABLE_tolua_GameNetDelegate_GameNetDelegate_registerScriptHandler00
static int tolua_GameNetDelegate_GameNetDelegate_registerScriptHandler00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"GameNetDelegate",0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
     (tolua_isvaluenil(tolua_S,3,&tolua_err) || !toluafix_isfunction(tolua_S,3,"LUA_FUNCTION",0,&tolua_err)) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  GameNetDelegate* self = (GameNetDelegate*)  tolua_tousertype(tolua_S,1,0);
  std::string event = ((std::string)  tolua_tocppstring(tolua_S,2,0));
  LUA_FUNCTION funcID = (  toluafix_ref_function(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'registerScriptHandler'", NULL);
#endif
  {
   self->registerScriptHandler(event,funcID);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'registerScriptHandler'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: unregisterScriptHandler of class  GameNetDelegate */
#ifndef TOLUA_DISABLE_tolua_GameNetDelegate_GameNetDelegate_unregisterScriptHandler00
static int tolua_GameNetDelegate_GameNetDelegate_unregisterScriptHandler00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"GameNetDelegate",0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  GameNetDelegate* self = (GameNetDelegate*)  tolua_tousertype(tolua_S,1,0);
  std::string event = ((std::string)  tolua_tocppstring(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'unregisterScriptHandler'", NULL);
#endif
  {
   self->unregisterScriptHandler(event);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'unregisterScriptHandler'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: toStrIP of class  GameNetDelegate */
#ifndef TOLUA_DISABLE_tolua_GameNetDelegate_GameNetDelegate_toStrIP00
static int tolua_GameNetDelegate_GameNetDelegate_toStrIP00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"GameNetDelegate",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  unsigned int dwIP = ((unsigned int)  tolua_tonumber(tolua_S,2,0));
  {
   std::string tolua_ret = (std::string)  GameNetDelegate::toStrIP(dwIP);
   tolua_pushcppstring(tolua_S,(const char*)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'toStrIP'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: close of class  GameNetDelegate */
#ifndef TOLUA_DISABLE_tolua_GameNetDelegate_GameNetDelegate_close00
static int tolua_GameNetDelegate_GameNetDelegate_close00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"GameNetDelegate",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  GameNetDelegate* self = (GameNetDelegate*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'close'", NULL);
#endif
  {
   self->close();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'close'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: md5 of class  CGameTools */
#ifndef TOLUA_DISABLE_tolua_GameNetDelegate_CGameTools_md500
static int tolua_GameNetDelegate_CGameTools_md500(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CGameTools",0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  std::string str = ((std::string)  tolua_tocppstring(tolua_S,2,0));
  {
   std::string tolua_ret = (std::string)  CGameTools::md5(str);
   tolua_pushcppstring(tolua_S,(const char*)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'md5'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: utf2gb of class  CGameTools */
#ifndef TOLUA_DISABLE_tolua_GameNetDelegate_CGameTools_utf2gb00
static int tolua_GameNetDelegate_CGameTools_utf2gb00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CGameTools",0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  std::string str = ((std::string)  tolua_tocppstring(tolua_S,2,0));
  {
   std::string tolua_ret = (std::string)  CGameTools::utf2gb(str);
   tolua_pushcppstring(tolua_S,(const char*)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'utf2gb'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: gb2utf of class  CGameTools */
#ifndef TOLUA_DISABLE_tolua_GameNetDelegate_CGameTools_gb2utf00
static int tolua_GameNetDelegate_CGameTools_gb2utf00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CGameTools",0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  std::string str = ((std::string)  tolua_tocppstring(tolua_S,2,0));
  {
   std::string tolua_ret = (std::string)  CGameTools::gb2utf(str);
   tolua_pushcppstring(tolua_S,(const char*)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'gb2utf'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_GameNetDelegate_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  tolua_cclass(tolua_S,"GameNetDelegate","GameNetDelegate","CCNetDelegate",NULL);
  tolua_beginmodule(tolua_S,"GameNetDelegate");
   tolua_function(tolua_S,"getInstance",tolua_GameNetDelegate_GameNetDelegate_getInstance00);
   tolua_function(tolua_S,"connectByIpPort",tolua_GameNetDelegate_GameNetDelegate_connectByIpPort00);
   tolua_function(tolua_S,"sendDataLua",tolua_GameNetDelegate_GameNetDelegate_sendDataLua00);
   tolua_function(tolua_S,"registerScriptHandler",tolua_GameNetDelegate_GameNetDelegate_registerScriptHandler00);
   tolua_function(tolua_S,"unregisterScriptHandler",tolua_GameNetDelegate_GameNetDelegate_unregisterScriptHandler00);
   tolua_function(tolua_S,"toStrIP",tolua_GameNetDelegate_GameNetDelegate_toStrIP00);
   tolua_function(tolua_S,"close",tolua_GameNetDelegate_GameNetDelegate_close00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CGameTools","CGameTools","",NULL);
  tolua_beginmodule(tolua_S,"CGameTools");
   tolua_function(tolua_S,"md5",tolua_GameNetDelegate_CGameTools_md500);
   tolua_function(tolua_S,"utf2gb",tolua_GameNetDelegate_CGameTools_utf2gb00);
   tolua_function(tolua_S,"gb2utf",tolua_GameNetDelegate_CGameTools_gb2utf00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_GameNetDelegate (lua_State* tolua_S) {
 return tolua_GameNetDelegate_open(tolua_S);
};
#endif

