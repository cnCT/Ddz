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

local NetTools = {}
local lib = require "struct"
local preFix = "!"..Const.align

local switch = {
	BYTE = "B",
	WORD = "H",
	DWORD = "I",
	LONG = "l",
	WCHAR = "H",
	CHAR = "B",
	TCHAR = "c",
	UCHAR = "B",
	bool = "B",
}

function NetTools:init( ... )
	-- body
	self.formatCache = {}
	return self
end

function NetTools:structSize( str )
	-- body
	local align = Const.align
	local len = require("struct").size(str)
	print("Real len is ", len)
	return (len<4 or len%align==0) and len or len+align-len%align
end

function NetTools:getFormatStr( structID, noPrefix )
	-- body
	local id = structID or "tagGameServer"
	print("structID is ", structID)
	local struct = Protocol[structID]
	local str = noPrefix and "" or preFix
	if self.formatCache[id] then
		str = self.formatCache[id]
	else
		for k,v in pairs(struct) do
			local c_type, var, len = unpack(v)
			if len then
				if Protocol[c_type] then
					local format = self:getFormatStr(c_type, true)
					str = string.format("%s%s",str,string.rep(format, len))
				elseif c_type == "TCHAR" then
					str = string.format("%s%s",str,switch[c_type] .. len)
				else
					str = string.format("%s%s",str,string.rep(switch[c_type],len))
				end
			else
				if Protocol[c_type] then
					print("Sub struct is ", c_type)
					local format = self:getFormatStr(c_type, true)
					str = string.format("%s%s",str,format)
				else
					str = string.format("%s%s",str,switch[c_type])
				end
			end
		end
		self.formatCache[id] = str		
	end
	print("Format str is ", str)
	return string.gsub(str, " ", "")
end

function NetTools:unpackArray( len, data, structID )
	-- body
	local struct = Protocol[structID]
	local str = self:getFormatStr(structID)
	local size = self:structSize(str)
	local array = {}
	for i=1,len do
		local tmp = string.sub(data, 0, size)
		data = string.sub(data, size+1)
		table.insert(array, self:unpack(data, structID))
	end
	return array, data
end

function NetTools:unpack( data, structID )
	-- body
	-- local struct = Protocol[structID]
	-- local str = self:getFormatStr(structID)
	-- local t = {}
	-- for i,v in ipairs({lib.unpack(str, data)}) do
	-- 	if struct[i] then
	-- 		t[struct[i][2]] = v
	-- 	end
	-- end
	-- return t	
	return self:unpackSelf( data, structID )
end

function NetTools:unpackSelf( data, structID )
	-- body
	local str = self:getFormatStr(structID)
	local t = {}
	local c = 1
	local unpackedData = {lib.unpack(str, data)}
	local function unpackSelf( structID, tt )
		-- body
		-- print("Start unpack ", c)
		local struct = Protocol[structID]
		for _,v in ipairs(struct) do
			local c_type, var, len = unpack(v)
			-- print(c_type, var, len)
			if len and c_type ~= "TCHAR" then
				-- print("Array ", c_type, var, len)
				tt[var] = {}
				for i=1,len do
					if Protocol[c_type] then
						local subData = {}
						table.insert(tt[var], subData)
						unpackSelf(c_type, subData)
					else
						table.insert(tt[var], unpackedData[c])
						c = c+1
					end
				end
			else
				if Protocol[c_type] then
					tt[var] = {}
					unpackSelf(c_type, tt[var])
				else
					tt[var] = unpackedData[c]
					c = c+1
				end
			end	
		end
	end
	unpackSelf(structID, t)
	return t
end

function NetTools:pack( t, structID )
	-- body
	local struct = Protocol[structID]
	local str = self:getFormatStr(structID)
	local data = {}
	dump(t)
	dump(struct)
	for i,v in ipairs(struct) do
		local c_type, var, len = unpack(v)
		print(c_type, var, len)
		if len then
			if c_type == "TCHAR" then
				data[i] = t[var] .. string.rep(" ", len-string.len(t[var]))
			end
		else
			data[i] = t[var]
		end
	end
	dump(data, str)
	return lib.pack(str, unpack(data)), self:structSize(str)
end

return NetTools:init()