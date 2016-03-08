--//////////////////////////////////////
--/////////////////VARS/////////////////
--//////////////////////////////////////
cc.exports.KIND_ID = 522
cc.exports.KIND_ID = 102
cc.exports.GAME_PLAYER = 3
cc.exports.CSD_NORMAL = 0
cc.exports.CSD_SNATCHLAND = 1
cc.exports.CSD_BRIGHTCARD = 2
cc.exports.CSD_GAMESTART = 3
cc.exports.BRIGHT_START_TIME = 8
cc.exports.BRIGHT_CARD_TIME = 4
cc.exports.SUB_S_SEND_CARD = 100
cc.exports.SUB_S_LAND_SCORE = 101
cc.exports.SUB_S_GAME_START = 102
cc.exports.SUB_S_OUT_CARD = 103
cc.exports.SUB_S_PASS_CARD = 104
cc.exports.SUB_S_GAME_END = 105
cc.exports.SUB_S_BRIGHT_START = 106
cc.exports.SUB_S_BRIGHT_CARD = 107
cc.exports.SUB_S_DOUBLE_SCORE = 108
cc.exports.SUB_S_USER_DOUBLE = 109
cc.exports.SUB_C_LAND_SCORE = 1
cc.exports.SUB_C_OUT_CART = 2
cc.exports.SUB_C_PASS_CARD = 3
cc.exports.SUB_C_TRUSTEE = 4
cc.exports.SUB_C_BRIGHT_START = 5
cc.exports.SUB_C_BRIGHT = 6
cc.exports.SUB_C_DOUBLE_SCORE = 7
--//////////////////////////////////////
--///////////////STRUCT/////////////////
--//////////////////////////////////////
Protocol.CMD_S_StatusFree = {
	{"LONG", "lBaseScore"},
	{"bool", "bBrightStart", GAME_PLAYER},
}
Protocol.CMD_S_StatusScore = {
	{"BYTE", "bLandScore"},
	{"LONG", "lBaseScore"},
	{"WORD", "wCurrentUser"},
	{"BYTE", "bScoreInfo", 3},
	{"BYTE", "bCardData", 3*20},
	{"bool", "bUserTrustee", GAME_PLAYER},
	{"BYTE", "bCallScorePhase"},
	{"BYTE", "bBrightTime"},
	{"bool", "bUserBrightCard", GAME_PLAYER},
}
Protocol.CMD_S_StatusDoubleScore = {
	{"WORD", "wLandUser"},
	{"LONG", "lBaseScore"},
	{"BYTE", "bLandScore"},
	{"BYTE", "bBackCard", 3},
	{"BYTE", "bCardData", 3*20},
	{"BYTE", "bCardCount", 3},
	{"bool", "bUserTrustee", GAME_PLAYER},
	{"bool", "bAllowDouble"},
	{"bool", "bDoubleUser", GAME_PLAYER},
	{"bool", "bUserBrightCard", GAME_PLAYER},
}
Protocol.CMD_S_StatusPlay = {
	{"WORD", "wLandUser"},
	{"WORD", "wBombTime"},
	{"LONG", "lBaseScore"},
	{"BYTE", "bLandScore"},
	{"WORD", "wLastOutUser"},
	{"WORD", "wCurrentUser"},
	{"BYTE", "bBackCard", 3},
	{"BYTE", "bCardData", 3*20},
	{"BYTE", "bCardCount", 3},
	{"BYTE", "bTurnCardCount"},
	{"BYTE", "bTurnCardData", 20},
	{"bool", "bUserTrustee", GAME_PLAYER},
	{"BYTE", "bBrightTime"},
	{"bool", "bUserBrightCard", GAME_PLAYER},
}
Protocol.CMD_S_SendCard = {
	{"WORD", "wCurrentUser"},
	{"BYTE", "bCardData", 17},
}
Protocol.CMD_S_SendAllCard = {
	{"WORD", "wCurrentUser"},
	{"BYTE", "bCardData", GAME_PLAYER*20},
	{"BYTE", "bBackCardData", 3},
	{"bool", "bUserBrightCard", GAME_PLAYER},
}
Protocol.CMD_S_LandScore = {
	{"WORD", "bLandUser"},
	{"WORD", "wCurrentUser"},
	{"BYTE", "bLandScore"},
	{"BYTE", "bCurrentScore"},
	{"BYTE", "bPreCallScorePhase"},
	{"BYTE", "bCallScorePhase"},
	{"bool", "bBrightCardUser", GAME_PLAYER},
}
Protocol.CMD_S_GameStart = {
	{"WORD", "wLandUser"},
	{"BYTE", "bLandScore"},
	{"WORD", "wCurrentUser"},
	{"BYTE", "bBrightCard"},
	{"bool", "bUserBrightCard", GAME_PLAYER},
	{"BYTE", "bBackCardData", 3},
}
Protocol.CMD_S_OutCard = {
	{"BYTE", "bCardCount"},
	{"WORD", "wCurrentUser"},
	{"WORD", "wOutCardUser"},
	{"BYTE", "bCardData", 20},
}
Protocol.CMD_S_PassCard = {
	{"BYTE", "bNewTurn"},
	{"WORD", "wPassUser"},
	{"WORD", "wCurrentUser"},
}
Protocol.CMD_S_GameEnd = {
	{"LONG", "lGameTax"},
	{"LONG", "lGameScore", 3},
	{"BYTE", "bCardCount", 3},
	{"BYTE", "bCardData", 54},
}
Protocol.CMD_S_BrightStart = {
	{"WORD", "wBrightUser"},
	{"bool", "bBright"},
}
Protocol.CMD_S_BrightCard = {
	{"WORD", "wBrightUser"},
	{"BYTE", "cbBrightTime"},
	{"BYTE", "cbCurrenBrightTime"},
	{"BYTE", "cbCallScorePhase"},
}
Protocol.CMD_S_DoubleScore = {
	{"bool", "bAllowDouble"},
	{"BYTE", "bBackCard", 3},
	{"WORD", "wLandUser"},
	{"BYTE", "bCurrentScore"},
}
Protocol.CMD_S_UserDouble = {
	{"WORD", "wDoubleUser"},
	{"bool", "bDoubleScore"},
	{"BYTE", "bCurrentScore"},
}
Protocol.CMD_C_UserTrustee = {
	{"WORD", "wUserChairID"},
	{"bool", "bTrustee"},
}
Protocol.CMD_C_LandScore = {
	{"BYTE", "bLandScore"},
}
Protocol.CMD_C_OutCard = {
	{"BYTE", "bCardCount"},
	{"BYTE", "bCardData", 20},
}
Protocol.CMD_C_BrightCard = {
	{"BYTE", "cbBrightCardTime"},
}
Protocol.CMD_C_DoubleScore = {
	{"bool", "bDoubleScore"},
}
