-- The elements in the format string are as follows:

-- " " (empty space) ignored.
-- "!n" flag to set the current alignment requirement to n (necessarily a power of 2); an absent n means the machine's native alignment.
-- ">" flag to set mode to big endian.
-- "<" flag to set mode to little endian.
-- "x" a padding zero byte with no corresponding Lua value.
-- "b" a signed char.
-- "B" an unsigned char.
-- "h" a signed short (native size).
-- "H" an unsigned short (native size).
-- "l" a signed long (native size).
-- "L" an unsigned long (native size).
-- "T" a size_t (native size).
-- "in" a signed integer with n bytes. An absent n means the native size of an int.
-- "In" like "in" but unsigned.
-- "f" a float (native size).
-- "d" a double (native size).
-- "s" a zero-terminated string.
-- "cn" a sequence of exactly n chars corresponding to a single Lua string. An absent n means 1. When packing, the given string must have at least n characters (extra characters are discarded).
-- "c0" this is like "cn", except that the n is given by other means: When packing, n is the length of the given string; when unpacking, n is the value of the previous unpacked value (which must be a number). In that case, this previous value is not returned.

-- //登陆成功
-- struct CMD_GP_LogonSuccess
-- {
-- 	WORD								wFaceID;						//头像索引
-- 	BYTE								cbGender;						//用户性别
-- 	BYTE								cbMember;						//会员等级
-- 	DWORD								dwUserID;						//用户 I D
-- 	DWORD								dwGameID;						//游戏 I D
-- 	DWORD								dwExperience;					//用户经验
	
	
-- 	//扩展信息
-- 	DWORD								dwCustomFaceVer;				//头像版本
-- };

-- //游戏房间列表结构
-- struct tagGameServer
-- {
-- 	WORD								wSortID;							//排序号码
-- 	WORD								wKindID;							//名称号码
-- 	WORD								wServerID;							//房间号码
-- 	WORD								wStationID;							//站点号码
-- 	WORD								wServerPort;						//房间端口
-- 	DWORD								dwServerAddr;						//房间地址
-- 	DWORD								dwOnLineCount;						//在线人数
-- 	TCHAR								szServerName[SERVER_LEN];			//房间名称
-- };

-- using BYTE = unsigned char;
-- using WORD = unsigned short;
-- using DWORD = unsigned int;
-- using LONG = long;
-- using WCHAR = unsigned wchar_t;
-- using CHAR = unsigned char;
-- using TCHAR = unsigned char;
-- using LPCTSTR = const char *;
-- using UCHAR = unsigned char;
-- using LPTSTR = char *;
-- using COLORREF = char;

local switch = {
	BYTE = "B",
	WORD = "H",
	DWORD = "I",
	LONG = "l",
	WCHAR = "H",
	CHAR = "B",
	TCHAR = "B",
	UCHAR = "B",
}
local CMD_GP_LogonSuccess = {
	{"WORD", "wFaceID"},						-- 头像索引
	{"BYTE", "cbGender"},						-- 用户性别
	{"BYTE", "cbMember"},						-- 会员等级
	{"DWORD", "dwUserID"},						-- 用户 I D
	{"DWORD", "dwGameID"},						-- 游戏 I D
	{"DWORD", "dwExperience"},					-- 用户经验
	
	
	-- 扩展信息
	{"DWORD", "dwCustomFaceVer"},				-- 头像版本
}

-- //游戏房间列表结构
local tagGameServer = 
{
	{"WORD", "wSortID"},							-- 排序号码
	{"WORD", "wKindID"},							-- 名称号码
	{"WORD", "wServerID"},							-- 房间号码
	{"WORD", "wStationID"},							-- 站点号码
	{"WORD", "wServerPort"},						-- 房间端口
	{"DWORD", "dwServerAddr"},						-- 房间地址
	{"DWORD", "dwOnLineCount"},						-- 在线人数
	{"TCHAR", "szServerName", SERVER_LEN},			-- 房间名称
}

local function getFormatStr( struct )
	-- body
	local str = "!4"
	for k,v in pairs(struct) do
		if v[3] then
			str = string.format("%s%s",str,"c"..v[3])
		else
			str = string.format("%s%s",str,switch[v[1]])
		end
	end
	print(str)
	return str
end
-- print(unpack({get()}))
-- set(unpack({get()}))

return getFormatStr(tagGameServer)