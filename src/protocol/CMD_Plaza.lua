--//////////////////////////////////////
--/////////////////VARS/////////////////
--//////////////////////////////////////
cc.exports.VER_PLAZA_LOW = 1
cc.exports.VER_PLAZA_HIGH = 2
cc.exports.ERC_GP_LOGON_SUCCESS = 0
cc.exports.ERC_GP_ACCOUNTS_NOT_EXIST = 1
cc.exports.ERC_GP_LONG_NULLITY = 2
cc.exports.ERC_GP_PASSWORD_ERCOR = 3
cc.exports.MDM_GP_LOGON = 1
cc.exports.SUB_GP_LOGON_ACCOUNTS = 1
cc.exports.SUB_GP_LOGON_USERID = 2
cc.exports.SUB_GP_REGISTER_ACCOUNTS = 3
cc.exports.SUB_GP_UPLOAD_CUSTOM_FACE = 4
cc.exports.SUB_GP_LOGON_SUCCESS = 100
cc.exports.SUB_GP_LOGON_ERROR = 101
cc.exports.SUB_GP_LOGON_FINISH = 102
cc.exports.MDM_GP_SERVER_LIST = 2
cc.exports.SUB_GP_LIST_TYPE = 100
cc.exports.SUB_GP_LIST_KIND = 101
cc.exports.SUB_GP_LIST_STATION = 102
cc.exports.SUB_GP_LIST_SERVER = 103
cc.exports.SUB_GP_LIST_FINISH = 104
cc.exports.SUB_GP_LIST_CONFIG = 105
cc.exports.MDM_GP_SYSTEM = 3
cc.exports.SUB_GP_VERSION = 100
cc.exports.SUB_SP_SYSTEM_MSG = 101
cc.exports.MDM_GP_USER = 4
cc.exports.SUB_GP_USER_UPLOAD_FACE = 100
cc.exports.SUB_GP_USER_DOWNLOAD_FACE = 101
cc.exports.SUB_GP_UPLOAD_FACE_RESULT = 102
cc.exports.SUB_GP_DELETE_FACE_RESULT = 103
cc.exports.SUB_GP_CUSTOM_FACE_DELETE = 104
cc.exports.SUB_GP_MODIFY_INDIVIDUAL = 105
cc.exports.SUB_GP_MODIFY_INDIVIDUAL_RESULT = 106
--//////////////////////////////////////
--///////////////STRUCT/////////////////
--//////////////////////////////////////
Protocol.CMD_GP_LogonByAccounts = {
	{"DWORD", "dwPlazaVersion"},
	{"TCHAR", "szAccounts", NAME_LEN},
	{"TCHAR", "szPassWord", PASS_LEN},
}
Protocol.CMD_GP_LogonByUserID = {
	{"DWORD", "dwPlazaVersion"},
	{"DWORD", "dwUserID"},
	{"TCHAR", "szPassWord", PASS_LEN},
}
Protocol.CMD_GP_RegisterAccounts = {
	{"WORD", "wFaceID"},
	{"BYTE", "cbGender"},
	{"DWORD", "dwPlazaVersion"},
	{"TCHAR", "szSpreader", NAME_LEN},
	{"TCHAR", "szAccounts", NAME_LEN},
	{"TCHAR", "szPassWord", PASS_LEN},
	{"TCHAR", "szPassWordBank", PASS_LEN},
}
Protocol.CMD_GP_LogonSuccess = {
	{"WORD", "wFaceID"},
	{"BYTE", "cbGender"},
	{"BYTE", "cbMember"},
	{"DWORD", "dwUserID"},
	{"DWORD", "dwGameID"},
	{"DWORD", "dwExperience"},
	{"DWORD", "dwCustomFaceVer"},
}
Protocol.CMD_GP_LogonError = {
	{"LONG", "lErrorCode"},
	{"TCHAR", "szErrorDescribe", 128},
}
Protocol.CMD_GP_ListConfig = {
	{"BYTE", "bShowOnLineCount"},
}
Protocol.CMD_GP_Version = {
	{"BYTE", "bNewVersion"},
	{"BYTE", "bAllowConnect"},
}
Protocol.CMD_GP_ModifyIndividual = {
	{"DWORD", "dwUserID"},
	{"TCHAR", "szNickname", NAME_LEN},
	{"int", "nGender"},
	{"int", "nAge"},
	{"TCHAR", "szAddress", 64},
	{"TCHAR", "szUnderWrite", 32},
	{"TCHAR", "szPassword", 33},
}
Protocol.CMD_GP_UploadCustomFace = {
	{"DWORD", "dwUserID"},
	{"WORD", "wCurrentSize"},
	{"bool", "bLastPacket"},
	{"bool", "bFirstPacket"},
	{"BYTE", "bFaceData", 2048},
}
Protocol.CMD_GP_DownloadFaceSuccess = {
	{"DWORD", "dwToltalSize"},
	{"DWORD", "dwCurrentSize"},
	{"DWORD", "dwUserID"},
	{"BYTE", "bFaceData", 2048},
}
Protocol.CMD_GP_DownloadFace = {
	{"DWORD", "dwUserID"},
}
Protocol.CMD_GP_UploadFaceResult = {
	{"TCHAR", "szDescribeMsg", 128},
	{"DWORD", "dwFaceVer"},
	{"bool", "bOperateSuccess"},
}
Protocol.CMD_GP_DeleteFaceResult = {
	{"TCHAR", "szDescribeMsg", 128},
	{"DWORD", "dwFaceVer"},
	{"bool", "bOperateSuccess"},
}
Protocol.CMD_GP_CustomFaceDelete = {
	{"DWORD", "dwUserID"},
	{"DWORD", "dwFaceVer"},
}
Protocol.CMD_GP_ModifyIndividualResult = {
	{"TCHAR", "szDescribeMsg", 128},
	{"bool", "bOperateSuccess"},
}
