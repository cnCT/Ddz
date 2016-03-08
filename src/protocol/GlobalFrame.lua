--//////////////////////////////////////
--/////////////////VARS/////////////////
--//////////////////////////////////////
cc.exports.GS_FREE = 0
cc.exports.GS_PLAYING = 100
cc.exports.IPC_MAIN_SOCKET = 1
cc.exports.IPC_SUB_SOCKET_SEND = 1
cc.exports.IPC_SUB_SOCKET_RECV = 2
cc.exports.IPC_MAIN_CONFIG = 2
cc.exports.IPC_SUB_SERVER_INFO = 1
cc.exports.IPC_SUB_COLUMN_INFO = 2
cc.exports.IPC_MAIN_USER = 3
cc.exports.IPC_SUB_USER_COME = 1
cc.exports.IPC_SUB_USER_STATUS = 2
cc.exports.IPC_SUB_USER_SCORE = 3
cc.exports.IPC_SUB_GAME_START = 4
cc.exports.IPC_SUB_GAME_FINISH = 5
cc.exports.IPC_SUB_UPDATE_FACE = 6
cc.exports.IPC_SUB_MEMBERORDER = 7
cc.exports.IPC_MAIN_CONCTROL = 4
cc.exports.IPC_SUB_START_FINISH = 1
cc.exports.IPC_SUB_CLOSE_FRAME = 2
cc.exports.IPC_SUB_JOIN_IN_GAME = 3
cc.exports.MDM_GF_GAME = 100
cc.exports.MDM_GF_FRAME = 101
cc.exports.MDM_GF_PRESENT = 102
cc.exports.MDM_GF_BANK = 103
cc.exports.SUB_GF_INFO = 1
cc.exports.SUB_GF_USER_READY = 2
cc.exports.SUB_GF_LOOKON_CONTROL = 3
cc.exports.SUB_GF_KICK_TABLE_USER = 4
cc.exports.SUB_GF_OPTION = 100
cc.exports.SUB_GF_SCENE = 101
cc.exports.SUB_GF_USER_CHAT = 200
cc.exports.SUB_GF_MESSAGE = 300
cc.exports.SUB_GF_GIFT = 400
cc.exports.SUB_GF_BANK_STORAGE = 450
cc.exports.SUB_GF_BANK_GET = 451
cc.exports.SUB_GF_CHANGE_PASSWORD = 452
cc.exports.SUB_GF_TRANSFER = 453
cc.exports.SUB_GF_FLOWER_ATTRIBUTE = 500
cc.exports.SUB_GF_FLOWER = 501
cc.exports.SUB_GF_EXCHANGE_CHARM = 502
cc.exports.SUB_GF_PROPERTY = 550
cc.exports.SUB_GF_PROPERTY_RESULT = 551
cc.exports.SUB_GF_RESIDUAL_PROPERTY = 552
cc.exports.SUB_GF_PROP_ATTRIBUTE = 553
cc.exports.SUB_GF_PROP_BUGLE = 554
cc.exports.SMT_INFO = 0x0001
cc.exports.SMT_EJECT = 0x0002
cc.exports.SMT_GLOBAL = 0x0004
cc.exports.SMT_CLOSE_GAME = 0x1000
cc.exports.LOCATION_GAME_ROOM = 1
cc.exports.LOCATION_PLAZA_ROOM = 2
--//////////////////////////////////////
--///////////////STRUCT/////////////////
--//////////////////////////////////////
Protocol.IPC_SocketPackage = {
	{"CMD_Command", "Command"},
	{"BYTE", "cbBuffer", SOCKET_PACKET},
}
Protocol.IPC_GF_ServerInfo = {
	{"DWORD", "dwUserID"},
	{"WORD", "wTableID"},
	{"WORD", "wChairID"},
	{"WORD", "wKindID"},
	{"WORD", "wServerID"},
	{"WORD", "wGameGenre"},
	{"WORD", "wChairCount"},
	{"BYTE", "cbHideUserInfo"},
	{"DWORD", "dwVideoAddr"},
	{"TCHAR", "szKindName", KIND_LEN},
	{"TCHAR", "szServerName", SERVER_LEN},
}
Protocol.IPC_UserStatus = {
	{"DWORD", "dwUserID"},
	{"WORD", "wNetDelay"},
	{"BYTE", "cbUserStatus"},
}
Protocol.IPC_UserScore = {
	{"LONG", "lLoveliness"},
	{"DWORD", "dwUserID"},
	{"tagUserScore", "UserScore"},
}
Protocol.IPC_MemberOrder = {
	{"BYTE", "cbMember"},
	{"DWORD", "dwUserID"},
}
Protocol.IPC_UpdateFace = {
	{"DWORD", "dwCustomFace"},
}
Protocol.IPC_JoinInGame = {
	{"WORD", "wTableID"},
	{"WORD", "wChairID"},
}
Protocol.CMD_GF_Info = {
	{"BYTE", "bAllowLookon"},
}
Protocol.CMD_GF_Option = {
	{"BYTE", "bGameStatus"},
	{"BYTE", "bAllowLookon"},
}
Protocol.CMD_GF_LookonControl = {
	{"DWORD", "dwUserID"},
	{"BYTE", "bAllowLookon"},
}
Protocol.CMD_GF_KickTableUser = {
	{"DWORD", "dwUserID"},
}
Protocol.CMD_GF_UserChat = {
	{"WORD", "wChatLength"},
	{"COLORREF", "crFontColor"},
	{"DWORD", "dwSendUserID"},
	{"DWORD", "dwTargetUserID"},
}
Protocol.CMD_GF_Message = {
	{"WORD", "wMessageType"},
	{"WORD", "wMessageLength"},
	{"TCHAR", "szContent", 1024},
}
Protocol.tagShareMemory = {
	{"WORD", "wDataSize"},
	{"HWND", "hWndGameFrame"},
	{"HWND", "hWndGamePlaza"},
	{"HWND", "hWndGameServer"},
}
Protocol.CMD_GF_Gift = {
	{"BYTE", "cbSendLocation"},
	{"DWORD", "dwSendUserID"},
	{"DWORD", "dwRcvUserID"},
	{"WORD", "wGiftID"},
	{"WORD", "wFlowerCount"},
}
Protocol.CMD_GF_Property = {
	{"BYTE", "cbSendLocation"},
	{"int", "nPropertyID"},
	{"DWORD", "dwPachurseCount"},
	{"DWORD", "dwOnceCount"},
	{"DWORD", "dwSourceUserID"},
	{"DWORD", "dwTargetUserID"},
	{"TCHAR", "szRcvUserName", 32},
}
Protocol.CMD_GF_BugleProperty = {
	{"BYTE", "cbSendLocation"},
	{"TCHAR", "szUserName", 32},
	{"COLORREF", "crText"},
	{"TCHAR", "szContext", BUGLE_MAX_CHAR},
}
Protocol.CMD_GF_ExchangeCharm = {
	{"BYTE", "cbSendLocation"},
	{"LONG", "lLoveliness"},
	{"DWORD", "lGoldValue"},
}
Protocol.CMD_GF_GiftNotify = {
	{"BYTE", "cbSendLocation"},
	{"DWORD", "dwSendUserID"},
	{"DWORD", "dwRcvUserID"},
	{"WORD", "wGiftID"},
	{"WORD", "wFlowerCount"},
}
Protocol.CMD_GF_BankStorage = {
	{"LONG", "lStorageValue"},
	{"TCHAR", "szPassword", PASS_LEN},
	{"BYTE", "cbGameAction"},
}
Protocol.CMD_GF_BankGet = {
	{"LONG", "lGetValue"},
	{"TCHAR", "szPassword", PASS_LEN},
	{"BYTE", "cbGameAction"},
}
Protocol.CMD_GF_ChangePassword = {
	{"TCHAR", "szOriginPassword", PASS_LEN},
	{"TCHAR", "szNewPassword", PASS_LEN},
}
Protocol.CMD_GF_Transfer = {
	{"LONGLONG", "lInputCount"},
	{"DWORD", "dwUserID"},
	{"TCHAR", "szNickname", NAME_LEN},
}
Protocol.CMD_GF_ResidualProperty = {
}
