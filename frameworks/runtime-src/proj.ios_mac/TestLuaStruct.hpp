//
//  TestLuaStruct.hpp
//  HelloLua
//
//  Created by CT on 9/25/15.
//
//

#ifndef TestLuaStruct_hpp
#define TestLuaStruct_hpp

#include <stdio.h>
#include <iostream>

class TestLuaStruct {
    
    
public:
    static void testToLua();
    static void testFromLua(const char *data, long size);
};

#endif /* TestLuaStruct_hpp */
