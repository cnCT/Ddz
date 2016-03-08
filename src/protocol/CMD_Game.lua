--//////////////////////////////////////
--/////////////////VARS/////////////////
--//////////////////////////////////////
cc.exports.MDM_GR_LOGON = 10001
cc.exports.SUB_GR_LOGON_ACCOUNTS = 1
cc.exports.SUB_GR_LOGON_USERID = 2
cc.exports.SUB_GR_LOGON_SUCCESS = 100
cc.exports.SUB_GR_LOGON_ERROR = 101
cc.exports.SUB_GR_LOGON_FINISH = 102
cc.exports.MDM_GR_USER = 10002
cc.exports.SUB_GR_USER_SIT_REQ = 1
cc.exports.SUB_GR_USER_LOOKON_REQ = 2
cc.exports.SUB_GR_USER_STANDUP_REQ = 3
cc.exports.SUB_GR_USER_LEFT_GAME_REQ = 4
cc.exports.SUB_GR_USER_COME = 100
cc.exports.SUB_GR_USER_STATUS = 101
cc.exports.SUB_GR_USER_SCORE = 102
cc.exports.SUB_GR_SIT_FAILED = 103
cc.exports.SUB_GR_USER_RIGHT = 104
cc.exports.SUB_GR_MEMBER_ORDER = 105
cc.exports.SUB_GR_USER_CHAT = 200
cc.exports.SUB_GR_USER_WISPER = 201
cc.exports.SUB_GR_USER_RULE = 202
cc.exports.SUB_GR_USER_INVITE = 300
cc.exports.SUB_GR_USER_INVITE_REQ = 301
cc.exports.MDM_GR_INFO = 10003
cc.exports.SUB_GR_SERVER_INFO = 100
cc.exports.SUB_GR_ORDER_INFO = 101
cc.exports.SUB_GR_MEMBER_INFO = 102
cc.exports.SUB_GR_COLUMN_INFO = 103
cc.exports.SUB_GR_CONFIG_FINISH = 104
cc.exports.MDM_GR_STATUS = 10004
cc.exports.SUB_GR_TABLE_INFO = 100
cc.exports.SUB_GR_TABLE_STATUS = 101
cc.exports.MDM_GR_MANAGER = 10005
cc.exports.SUB_GR_SEND_WARNING = 1
cc.exports.SUB_GR_SEND_MESSAGE = 2
cc.exports.SUB_GR_LOOK_USER_IP = 3
cc.exports.SUB_GR_KILL_USER = 4
cc.exports.SUB_GR_LIMIT_ACCOUNS = 5
cc.exports.SUB_GR_SET_USER_RIGHT = 6
cc.exports.SUB_GR_OPTION_SERVER = 7
cc.exports.OSF_ROOM_CHAT = 1
cc.exports.OSF_GAME_CHAT = 2
cc.exports.OSF_ROOM_WISPER = 3
cc.exports.OSF_ENTER_GAME = 4
cc.exports.OSF_ENTER_ROOM = 5
cc.exports.OSF_SHALL_CLOSE = 6
cc.exports.MDM_GR_SYSTEM = 10010
cc.exports.SUB_GR_MESSAGE = 100
cc.exports.SMT_INFO = 0x0001
cc.exports.SMT_EJECT = 0x0002
cc.exports.SMT_GLOBAL = 0x0004
cc.exports.SMT_CLOSE_ROOM = 0x1000
cc.exports.SMT_INTERMIT_LINE = 0x4000
cc.exports.MDM_GR_SERVER_INFO = 10011
cc.exports.SUB_GR_ONLINE_COUNT_INFO = 100
--//////////////////////////////////////
--///////////////STRUCT/////////////////
--//////////////////////////////////////
Protocol.CMD_GR_LogonByAccounts = {
	{"DWORD", "dwPlazaVersion"},
	{"DWORD", "dwProcessVersion"},
	{"TCHAR", "szAccounts", NAME_LEN},
	{"TCHAR", "szPassWord", PASS_LEN},
}
Protocol.CMD_GR_LogonByUserID = {
	{"DWORD", "dwPlazaVersion"},
	{"DWORD", "dwProcessVersion"},
	{"DWORD", "dwUserID"},
	{"TCHAR", "szPassWord", PASS_LEN},
}
Protocol.CMD_GR_LogonSuccess = {
	{"DWORD", "dwUserID"},
}
Protocol.CMD_GR_LogonError = {
	{"LONG", "lErrorCode"},
	{"TCHAR", "szErrorDescribe", 128},
}
Protocol.CMD_GR_MemberOrder = {
	{"DWORD", "dwUserID"},
	{"BYTE", "cbMemberOrder"},
}
Protocol.CMD_GR_UserRight = {
	{"DWORD", "dwUserID"},
	{"DWORD", "dwUserRight"},
}
Protocol.CMD_GR_UserStatus = {
	{"DWORD", "dwUserID"},
	{"WORD", "wTableID"},
	{"WORD", "wChairID"},
	{"BYTE", "cbUserStatus"},
}
Protocol.CMD_GR_UserScore = {
	{"LONG", "lLoveliness"},
	{"DWORD", "dwUserID"},
	{"tagUserScore", "UserScore"},
}
Protocol.CMD_GR_UserSitReq = {
	{"WORD", "wTableID"},
	{"WORD", "wChairID"},
	{"BYTE", "cbPassLen"},
	{"TCHAR", "szTablePass", PASS_LEN},
}
Protocol.CMD_GR_UserInviteReq = {
	{"WORD", "wTableID"},
	{"DWORD", "dwUserID"},
}
Protocol.CMD_GR_SitFailed = {
	{"TCHAR", "szFailedDescribe", 256},
}
Protocol.CMD_GR_UserChat = {
	{"WORD", "wChatLength"},
	{"COLORREF", "crFontColor"},
	{"DWORD", "dwSendUserID"},
	{"DWORD", "dwTargetUserID"},
	{"TCHAR", "szChatMessage", MAX_CHAT_LEN},
}
Protocol.CMD_GR_Wisper = {
	{"WORD", "wChatLength"},
	{"COLORREF", "crFontColor"},
	{"DWORD", "dwSendUserID"},
	{"DWORD", "dwTargetUserID"},
	{"TCHAR", "szChatMessage", MAX_CHAT_LEN},
}
Protocol.CMD_GR_UserRule = {
	{"bool", "bPassword"},
	{"bool", "bLimitWin"},
	{"bool", "bLimitFlee"},
	{"bool", "bLimitScore"},
	{"bool", "bCheckSameIP"},
	{"WORD", "wWinRate"},
	{"WORD", "wFleeRate"},
	{"LONG", "lMaxScore"},
	{"LONG", "lLessScore"},
	{"TCHAR", "szPassword", PASS_LEN},
}
Protocol.CMD_GR_UserInvite = {
	{"WORD", "wTableID"},
	{"DWORD", "dwUserID"},
}
Protocol.CMD_GR_ServerInfo = {
	{"WORD", "wKindID"},
	{"WORD", "wTableCount"},
	{"WORD", "wChairCount"},
	{"DWORD", "dwVideoAddr"},
	{"WORD", "wGameGenre"},
	{"BYTE", "cbHideUserInfo"},
}
Protocol.CMD_GR_ScoreInfo = {
	{"WORD", "wDescribeCount"},
	{"WORD", "wDataDescribe", 16},
}
Protocol.tagOrderItem = {
	{"LONG", "lScore"},
	{"WORD", "wOrderDescribe", 16},
}
Protocol.CMD_GR_OrderInfo = {
	{"WORD", "wOrderCount"},
	{"tagOrderItem", "OrderItem", 128},
}
Protocol.tagColumnItem = {
	{"WORD", "wColumnWidth"},
	{"WORD", "wDataDescribe"},
	{"TCHAR", "szColumnName", 16},
}
Protocol.CMD_GR_ColumnInfo = {
	{"WORD", "wColumnCount"},
	{"tagColumnItem", "ColumnItem", 32},
}
Protocol.tagTableStatus = {
	{"BYTE", "bTableLock"},
	{"BYTE", "bPlayStatus"},
}
Protocol.CMD_GR_TableInfo = {
	{"WORD", "wTableCount"},
	{"tagTableStatus", "TableStatus", 512},
}
Protocol.CMD_GR_TableStatus = {
	{"WORD", "wTableID"},
	{"BYTE", "bTableLock"},
	{"BYTE", "bPlayStatus"},
}
Protocol.CMD_GR_SendWarning = {
	{"WORD", "wChatLength"},
	{"DWORD", "dwTargetUserID"},
	{"TCHAR", "szWarningMessage", MAX_CHAT_LEN},
}
Protocol.CMD_GR_SendMessage = {
	{"BYTE", "cbGame"},
	{"BYTE", "cbRoom"},
	{"WORD", "wChatLength"},
	{"TCHAR", "szSystemMessage", MAX_CHAT_LEN},
}
Protocol.CMD_GR_LookUserIP = {
	{"DWORD", "dwTargetUserID"},
}
Protocol.CMD_GR_KillUser = {
	{"DWORD", "dwTargetUserID"},
}
Protocol.CMD_GR_LimitAccounts = {
	{"DWORD", "dwTargetUserID"},
}
Protocol.CMD_GR_SetUserRight = {
	{"DWORD", "dwTargetUserID"},
	{"BYTE", "cbGameRight"},
	{"BYTE", "cbAccountsRight"},
	{"BYTE", "cbLimitRoomChat"},
	{"BYTE", "cbLimitGameChat"},
	{"BYTE", "cbLimitPlayGame"},
	{"BYTE", "cbLimitSendWisper"},
	{"BYTE", "cbLimitLookonGame"},
}
Protocol.CMD_GR_OptionServer = {
	{"BYTE", "cbOptionFlags"},
	{"BYTE", "cbOptionValue"},
}
Protocol.CMD_GR_Message = {
	{"WORD", "wMessageType"},
	{"WORD", "wMessageLength"},
	{"TCHAR", "szContent", 1024},
}
Protocol.tagOnLineCountInfo = {
	{"WORD", "wKindID"},
	{"DWORD", "dwOnLineCount"},
}
