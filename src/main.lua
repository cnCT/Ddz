
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "cocos.init"
require "common.Const"
require "protocol.init"
local lib = require "struct"

local function getSize( str )
	-- body
	local len = require("struct").size(str)
	return len%4==0 and len or len+4-len%4
end

local function main()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end

local function testLua( ... )
	-- body
	local str = lib.pack("<!4icc", 10010, 'x', 'y')
	print(lib.size("!4icc"))
	print(string.len(str))
	test_lua(str)
end

cc.exports.struct_test_d = function( a )
	-- body
	print(string.len(a))
	print("OKOKOKOKO")
	-- local NetTools = require("net.NetTools")
	-- dump(NetTools:unpackSelf(a, "CMD_GR_OrderInfo"), "H", 5)
end