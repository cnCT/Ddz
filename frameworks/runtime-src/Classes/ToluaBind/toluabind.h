//
//  xx.h
//  HelloLua
//
//  Created by CT on 9/28/15.
//
//

#ifndef xx_h
#define xx_h
#include "tolua_fix.h"
#include "GameNetDelegate.h"
#include "GlobalDef.h"
#include "GameTools.h"

/* Exported function */
//TOLUA_API int  tolua_GlobDefTolua_open (lua_State* tolua_S);

/* Exported function */
TOLUA_API int  tolua_GameNetDelegate_open (lua_State* tolua_S);

#endif /* xx_h */
