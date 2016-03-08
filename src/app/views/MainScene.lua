
local MainScene = class("MainScene", cc.load("mvc").ViewBase)
local NetTools = require("net.NetTools")
local net = GameNetDelegate:getInstance()

local m_cbCardData = 
{
	{0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D},	-- //方块 A - K
	{0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1A,0x1B,0x1C,0x1D},	-- //梅花 A - K
	{0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D},	-- //红桃 A - K
	{0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D},	-- //黑桃 A - K
	{0x4E,0x4F},
};

local poke = {
	"方块",
	"梅花",
	"红桃",
	"黑桃",
	"王"
}

function MainScene:onCreate()
    -- add background image
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)

    local imageView = ccui.ImageView:create()
    imageView:loadTexture("HelloWorld.png")
    imageView:setPosition(cc.p(display.width / 2.0, display.height / 4.0))
    self:addChild(imageView)
    imageView:setTouchEnabled(true)
    imageView:addTouchEventListener(function( sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            print("Touch me!!!")
            if self.status == "onConnected" then
				local t = {
					dwPlazaVersion = 131073,
					szAccounts = "test55",
					szPassWord = CGameTools:md5("ewq123"),
				}
				local data,size = NetTools:pack(t, "CMD_GP_LogonByAccounts")
				net:sendDataLua(1, 1, data, size)
			elseif self.status == "onDisconnected" then
				net:connectByIpPort(Const.serverIP, Const.serverPort)
			else
				print(self.status)
			end
        end
    end)

    local imageView = ccui.ImageView:create()
    imageView:loadTexture("HelloWorld.png")
    imageView:setPosition(cc.p(display.width, display.height / 4.0))
    self:addChild(imageView)
    imageView:setTouchEnabled(true)
    imageView:addTouchEventListener(function( sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            print("Touch me!!!")
            if self.status == "onConnected" then
				local t = {
					dwPlazaVersion = 131073,
					dwUserID = self._usrID,
					szPassWord = CGameTools:md5("ewq123"),
					dwProcessVersion = 3435973836,
				}
				local data,size = NetTools:pack(t, "CMD_GR_LogonByUserID")
				net:sendDataLua(MDM_GR_LOGON, SUB_GR_LOGON_USERID, data, size)
			elseif self.status == "onDisconnected" then
				self:initGPProtocol()
				net:connectByIpPort(self._gameIp, self._gamePort)
			else
				print(self.status)
			end
        end
    end)

    imageView = imageView:clone()
    imageView:setPosition(cc.p(0, display.height / 4.0))
    self:addChild(imageView)
    imageView:setTouchEnabled(true)
    imageView:addTouchEventListener(function( sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            print("Touch me!!!")
            if self.status == "onConnected" then
				local t = {
					bLandScore = 1,
				}

				local data,size = NetTools:pack(t, "CMD_C_LandScore")
				net:sendDataLua(MDM_GF_GAME, SUB_C_LAND_SCORE, data, size)
			elseif self.status == "onDisconnected" then
				
			else
				print(self.status)
			end
        end
    end)

 --    //登录数据包
	-- struct CMD_GR_LogonByUserID * pLogonByAccounts=(struct CMD_GR_LogonByUserID *)cbBuffer;
	-- pLogonByAccounts->dwUserID = m_tMyData.dwUserID;
	-- pLogonByAccounts->dwPlazaVersion=0xffffffee;
 --    pLogonByAccounts->wChannelID=CHANNELID;
 --    pLogonByAccounts->wKindVer=KIND_VER;
	-- strcpy(pLogonByAccounts->szPassWord,CGameTools::md5(m_strMyPwd).c_str());
    
    
	-- //发送数据包
 --    m_pClientSocket->sendPacket(MDM_GR_LOGON, SUB_GR_LOGON_USERID, cbBuffer, sizeof(CMD_GR_LogonByUserID)+sizeof(tagClientSerial)+sizeof(tagDataDescribe));


    self:initNet()
end

function MainScene:initGPProtocol( ... )
	-- body
	net:registerScriptHandler("onReceived", function( main, sub, data )
		print(main, sub, "Rec size is ", string.len(data))

		if main == MDM_GR_LOGON then
			if sub == SUB_GR_LOGON_SUCCESS then
				print("SUB_GP_LOGON_SUCCESS")
				local t = NetTools:unpack(data, "CMD_GR_LogonSuccess")
				dump(t, "LogonSuccess")
			elseif sub == SUB_GR_LOGON_FINISH then
				print("SUB_GP_LOGON_FINISH")
				local t = {
					bLimitWin=0,
	                bLimitFlee=0,
	                wWinRate=1,
	                wFleeRate=2,
	                lMaxScore=3,
	                lLessScore=4,
	                bLimitScore=0,
	                bPassword=1,
	                bCheckSameIP=0,
	                szPassword=CGameTools:md5("ewq123"),
				}
				local data,size = NetTools:pack(t, "CMD_GR_UserRule")
				net:sendDataLua(MDM_GR_USER, SUB_GR_USER_RULE, data, size)

			end
		elseif main == MDM_GR_USER then
			if sub == SUB_GR_USER_COME then
				-- dump(NetTools:unpack(data, "tagUserInfoHead"), "tagUserInfoHead")

				-- local t = {
				-- 	bAllowLookon = 0,
				-- }

				-- local data,size = NetTools:pack(t, "CMD_GF_Info")
				-- net:sendDataLua(MDM_GF_FRAME, SUB_GF_INFO, data, size)

				local t = {
					wTableID = 4,
					wChairID = 2,
					cbPassLen = 1,
					szTablePass = "",
				}
				local data,size = NetTools:pack(t, "CMD_GR_UserSitReq")
				net:sendDataLua(MDM_GR_USER, SUB_GR_USER_SIT_REQ, data, 6)
			elseif sub == SUB_GR_USER_STATUS then
				-- dump(NetTools:unpack(data, "tagUserInfoHead"), "tagUserInfoHead")

				local t = {
					bAllowLookon = 0,
				}

				local data,size = NetTools:pack(t, "CMD_GF_Info")
				net:sendDataLua(MDM_GF_FRAME, SUB_GF_INFO, data, size)
			end
		elseif main == MDM_GR_STATUS then
			if sub == SUB_GR_TABLE_STATUS then
				net:sendDataLua(MDM_GF_FRAME, SUB_GF_USER_READY, "", 0)
			end
		elseif main == MDM_GF_GAME then
			if sub == SUB_S_SEND_CARD then
				local allCard = NetTools:unpackSelf(data, "CMD_S_SendAllCard")
				dump(allCard, "CMD_S_SendAllCard")

				local myCard = {}
				local cardCount = 17
				local myCharIndex = 3
				for i=1,cardCount do
					local card = allCard.bCardData[(myCharIndex-1)*cardCount+i]
					local x = math.modf(card/0x10)
					print(poke[x+1], card-0x10*x)
					table.insert(myCard, card)
				end
			end
		end

	end)
end

function MainScene:initNet( ... )
	-- body
	self.status = nil
	net:registerScriptHandler("onReceived", function( main, sub, data )
		-- body
		print(main, sub, "Rec size is ", string.len(data))

		if main == 1 then
			if sub == SUB_GP_LOGON_SUCCESS then
				print("SUB_GP_LOGON_SUCCESS")
				local t = NetTools:unpack(data, "CMD_GP_LogonSuccess")
				dump(t, "LogonSuccess")
				self._usrID = t.dwUserID
			elseif sub == SUB_GP_LOGON_FINISH then
				print("SUB_GP_LOGON_FINISH")
				net:close()
			end
		elseif main == 2 then
			if sub == SUB_GP_LIST_TYPE then
				print("SUB_GP_LIST_TYPE")
			elseif sub == SUB_GP_LIST_KIND then
				print("SUB_GP_LIST_KIND")
			elseif sub == SUB_GP_LIST_STATION then
				print("SUB_GP_LIST_STATION")
			elseif sub == SUB_GP_LIST_SERVER then
				local t = NetTools:unpack(data, "tagGameServer")
				dump(t, "tagGameServer")
				print(t.wKindID, CGameTools:gb2utf(t.szServerName), GameNetDelegate:toStrIP(t.dwServerAddr), t.wServerPort)
				self._gameIp = GameNetDelegate:toStrIP(t.dwServerAddr)
				self._gamePort = t.wServerPort
			elseif sub == SUB_GP_LIST_FINISH then
				print("SUB_GP_LIST_FINISH")
			end
		end
	end)

	net:registerScriptHandler("netStatus", function( event )
		-- body
		print("Net status is ", event)
		self.status = event
	end)

	net:connectByIpPort(Const.serverIP, Const.serverPort)
end

return MainScene
