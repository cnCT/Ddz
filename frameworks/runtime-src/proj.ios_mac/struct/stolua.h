//
//  structlua.h
//  cocos2d_lua_bindings
//
//  Created by CT on 9/24/15.
//
//

#ifndef structlua_h
#define structlua_h

#ifdef __cplusplus
extern "C" {
#endif
#include "tolua++.h"

TOLUA_API int luaopen_stolua (lua_State *L);

#ifdef __cplusplus
}
#endif
#endif /* structlua_h */
