--//////////////////////////////////////
--/////////////////VARS/////////////////
--//////////////////////////////////////
cc.exports.PROP_DOUBLE = 0
cc.exports.PROP_FOURDOLD = 1
cc.exports.PROP_NEGAGIVE = 2
cc.exports.PROP_FLEE = 3
cc.exports.PROP_BUGLE = 4
cc.exports.PROP_KICK = 5
cc.exports.PROP_SHIELD = 6
cc.exports.PROP_MEMBER_1 = 7
cc.exports.PROP_MEMBER_2 = 8
cc.exports.PROP_MEMBER_3 = 9
cc.exports.PROP_MEMBER_4 = 10
cc.exports.PROP_MEMBER_5 = 11
cc.exports.PROP_MEMBER_6 = 12
cc.exports.PROP_MEMBER_7 = 13
cc.exports.PROP_MEMBER_8 = 14
cc.exports.MAX_CHAIR = 100
cc.exports.MAX_CHAIR_NORMAL = 8
cc.exports.MAX_ANDROID = 256
cc.exports.MAX_CHAT_LEN = 128
cc.exports.LIMIT_CHAT_TIMES = 1200
cc.exports.PORT_VIDEO_SERVER = 7600
cc.exports.PORT_LOGON_SERVER = 9001
cc.exports.PORT_CENTER_SERVER = 9010
cc.exports.SOCKET_VER = 0x66
cc.exports.SOCKET_BUFFER = 8192
cc.exports.MDM_KN_COMMAND = 0
cc.exports.SUB_KN_DETECT_SOCKET = 1
cc.exports.SUB_KN_SHUT_DOWN_SOCKET = 2
cc.exports.IPC_VER = 0x0001
cc.exports.IPC_IDENTIFIER = 0x0001
cc.exports.IPC_PACKAGE = 4096
cc.exports.TYPE_LEN = 32
cc.exports.KIND_LEN = 32
cc.exports.STATION_LEN = 32
cc.exports.SERVER_LEN = 32
cc.exports.MODULE_LEN = 32
cc.exports.GENDER_NULL = 0
cc.exports.GENDER_BOY = 1
cc.exports.GENDER_GIRL = 2
cc.exports.GAME_GENRE_SCORE = 0x0001
cc.exports.GAME_GENRE_GOLD = 0x0002
cc.exports.GAME_GENRE_MATCH = 0x0004
cc.exports.GAME_GENRE_EDUCATE = 0x0008
cc.exports.US_NULL = 0x00
cc.exports.US_FREE = 0x01
cc.exports.US_SIT = 0x02
cc.exports.US_READY = 0x03
cc.exports.US_LOOKON = 0x04
cc.exports.US_PLAY = 0x05
cc.exports.US_OFFLINE = 0x06
cc.exports.NAME_LEN = 32
cc.exports.PASS_LEN = 33
cc.exports.EMAIL_LEN = 32
cc.exports.GROUP_LEN = 32
cc.exports.COMPUTER_ID_LEN = 33
cc.exports.UNDER_WRITE_LEN = 32
--//////////////////////////////////////
--///////////////STRUCT/////////////////
--//////////////////////////////////////
Protocol.TRecvData = {
	{"WORD", "m_wMainCmdID"},
	{"BYTE", "m_data", SOCKET_BUFFER},
}
Protocol.CMD_Info = {
	{"BYTE", "cbVersion"},
	{"BYTE", "cbCheckCode"},
	{"WORD", "wPacketSize"},
}
Protocol.CMD_Command = {
	{"WORD", "wMainCmdID"},
	{"WORD", "wSubCmdID"},
}
Protocol.CMD_Head = {
	{"CMD_Info", "CmdInfo"},
	{"CMD_Command", "CommandInfo"},
}
Protocol.CMD_Buffer = {
	{"CMD_Head", "Head"},
	{"BYTE", "cbBuffer", SOCKET_PACKET},
}
Protocol.CMD_KN_DetectSocket = {
	{"DWORD", "dwSendTickCount"},
	{"DWORD", "dwRecvTickCount"},
}
Protocol.IPC_Head = {
	{"WORD", "wVersion"},
	{"WORD", "wDataSize"},
	{"WORD", "wMainCmdID"},
	{"WORD", "wSubCmdID"},
}
Protocol.IPC_Buffer = {
	{"IPC_Head", "Head"},
	{"BYTE", "cbBuffer", IPC_PACKAGE},
}
Protocol.tagGameType = {
	{"WORD", "wSortID"},
	{"WORD", "wTypeID"},
	{"TCHAR", "szTypeName", TYPE_LEN},
}
Protocol.tagGameKind = {
	{"WORD", "wSortID"},
	{"WORD", "wTypeID"},
	{"WORD", "wKindID"},
	{"DWORD", "dwMaxVersion"},
	{"DWORD", "dwOnLineCount"},
	{"TCHAR", "szKindName", KIND_LEN},
	{"TCHAR", "szProcessName", MODULE_LEN},
}
Protocol.tagGameStation = {
	{"WORD", "wSortID"},
	{"WORD", "wKindID"},
	{"WORD", "wJoinID"},
	{"WORD", "wStationID"},
	{"TCHAR", "szStationName", STATION_LEN},
}
Protocol.tagGameServer = {
	{"WORD", "wSortID"},
	{"WORD", "wKindID"},
	{"WORD", "wServerID"},
	{"WORD", "wStationID"},
	{"WORD", "wServerPort"},
	{"DWORD", "dwServerAddr"},
	{"DWORD", "dwOnLineCount"},
	{"TCHAR", "szServerName", SERVER_LEN},
}
Protocol.tagLevelItem = {
	{"LONG", "lLevelScore"},
	{"WCHAR", "szLevelName", 16},
}
Protocol.tagUserScore = {
	{"LONG", "lScore"},
	{"LONG", "lGameGold"},
	{"LONG", "lInsureScore"},
	{"LONG", "lWinCount"},
	{"LONG", "lLostCount"},
	{"LONG", "lDrawCount"},
	{"LONG", "lFleeCount"},
	{"LONG", "lExperience"},
}
Protocol.tagUserStatus = {
	{"WORD", "wTableID"},
	{"WORD", "wChairID"},
	{"BYTE", "cbUserStatus"},
}
Protocol.tagUserInfoHead = {
	{"WORD", "wFaceID"},
	{"DWORD", "dwUserID"},
	{"DWORD", "dwGameID"},
	{"DWORD", "dwGroupID"},
	{"DWORD", "dwUserRight"},
	{"LONG", "lLoveliness"},
	{"DWORD", "dwMasterRight"},
	{"BYTE", "cbGender"},
	{"BYTE", "cbMemberOrder"},
	{"BYTE", "cbMasterOrder"},
	{"WORD", "wTableID"},
	{"WORD", "wChairID"},
	{"BYTE", "cbUserStatus"},
	{"tagUserScore", "UserScoreInfo"},
	{"DWORD", "dwCustomFaceVer"},
}
Protocol.tagUserData = {
	{"WORD", "wFaceID"},
	{"DWORD", "dwCustomFaceVer"},
	{"DWORD", "dwUserID"},
	{"DWORD", "dwGroupID"},
	{"DWORD", "dwGameID"},
	{"DWORD", "dwUserRight"},
	{"LONG", "lLoveliness"},
	{"DWORD", "dwMasterRight"},
	{"TCHAR", "szName", NAME_LEN},
	{"TCHAR", "szGroupName", GROUP_LEN},
	{"TCHAR", "szUnderWrite", UNDER_WRITE_LEN},
	{"BYTE", "cbGender"},
	{"BYTE", "cbMemberOrder"},
	{"BYTE", "cbMasterOrder"},
	{"LONG", "lInsureScore"},
	{"LONG", "lGameGold"},
	{"LONG", "lScore"},
	{"LONG", "lWinCount"},
	{"LONG", "lLostCount"},
	{"LONG", "lDrawCount"},
	{"LONG", "lFleeCount"},
	{"LONG", "lExperience"},
	{"WORD", "wTableID"},
	{"WORD", "wChairID"},
	{"BYTE", "cbUserStatus"},
	{"BYTE", "cbCompanion"},
}
Protocol.tagClientSerial = {
	{"DWORD", "dwSystemVer"},
	{"DWORD", "dwComputerID", 3},
}
Protocol.tagOptionBuffer = {
	{"BYTE", "cbBufferLen"},
	{"BYTE", "cbOptionBuf", 32},
}
