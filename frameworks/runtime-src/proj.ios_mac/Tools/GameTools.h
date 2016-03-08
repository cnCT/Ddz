//
//  GameTools.h
//  BRTenHalf
//
//  Created by z l on 13-5-14.
//
//

#ifndef __BRTenHalf__GameTools__
#define __BRTenHalf__GameTools__

#include <iostream>
#include "GlobalDef.h"
#include "cocos2d.h"

#define FONTSIZE(s) (float)s/g_fFontScale

/*class IPaymentCallBack
{
public:
    virtual void onPurchaseComplete(std::string tid,std::string receipt) = 0;
    //virtual void onPurchaseFail() = 0;
};*/

class CGameTools
{
public:
    static std::string md5(std::string str);
    static std::string utf2gb(std::string str);
    static std::string gb2utf(std::string str);
    static void showMessage(std::string title, std::string msg);
    static void setLocalData(const char*  key, const char* value);
    static std::string getLocalData(const char* key);
    static void getSerial(BYTE* buf);
    static std::string encodeBase64(const unsigned char* input, int length);
    static void showActivetyView(std::string msg);
    static void holdActivetyView();
    static void showWebView(std::string url,cocos2d::CCPoint point,cocos2d::CCSize size);
    static void holdWebView();
    /*static void showTextView(std::string str,cocos2d::CCPoint point,cocos2d::CCSize size);
    static void holdTextView();
    static std::string getTextViewString();*/
    static std::string cutUTF8String(std::string str,int len,bool isbytes=true);
    
    static void reqProductData();
    static bool reqPurchaseProduct(std::string pid);
    static void reqFinishPurchase(std::string tid);
    static void reqRestorePurchase();
    
    static void showSelMsg(std::string msg, int key);
    
    static void evaluate(DWORD id);
    
    static void runGame(std::string url,DWORD id);
    static bool isGameOnline(DWORD id);
    
    static bool sendWX(std::string msg);
    
    static bool isIOS7();
};

#endif /* defined(__BRTenHalf__GameTools__) */
