#ifndef ENCRYPT_HEAD_FILE
#define ENCRYPT_HEAD_FILE

//////////////////////////////////////////////////////////////////////////

//MD5 ?????? 
class CMD5Encrypt
{
	//????????
private:
	//??????
	CMD5Encrypt() {}

	//???????
public:
	//????????
	static void EncryptData(char *pszSrcData, char szMD5Result[33]);
};

//////////////////////////////////////////////////////////////////////////

#endif