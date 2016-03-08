//
//  GameTools.cpp
//  BRTenHalf
//
//  Created by z l on 13-5-14.
//
//

#include "GameTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/NSThread.h>
#import <UIKit/UIKit.h>
//#import "WXApi.h"

std::string CGameTools::md5(std::string str)
{
    unsigned char result[16];
    CC_MD5( str.c_str(), str.size(), result );
    NSString* s = [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    std::string r = [s UTF8String];
    return r;
}
std::string CGameTools::utf2gb(std::string str)
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString* s = [[[NSString alloc]initWithUTF8String:str.c_str()]autorelease];
    NSData *data = [s dataUsingEncoding:enc];
    char* tmps = new char([data length]+1);
    memset(tmps, 0, [data length]+1);
    memcpy(tmps, [data bytes], [data length]);
    //CCLOG( "utf2gb s=" << tmps << ",l=" << [data length] );
    std::string r = tmps;
    delete tmps;
    return r;
}
std::string CGameTools::gb2utf(std::string str)
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [NSData dataWithBytes:str.c_str() length:str.size()];
    NSString *s = [[[NSString alloc]initWithData:data encoding:enc]autorelease];
    std::string r = [s UTF8String];
    return r;
}

void CGameTools::showMessage(std::string title, std::string msg)
{
    NSString* t = [[[NSString alloc]initWithUTF8String:title.c_str()]autorelease];
    NSString* m = [[[NSString alloc]initWithUTF8String:msg.c_str()]autorelease];
    UIAlertView* msgbox = [[UIAlertView alloc]initWithTitle:t message:m delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [msgbox autorelease];
    [msgbox performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
}
void CGameTools::setLocalData(const char* key, const char* value)
{
    NSString* k = [[[NSString alloc]initWithUTF8String:key]autorelease];
    NSString* v = [[[NSString alloc]initWithUTF8String:value]autorelease];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:v forKey:k];
    [defaults synchronize];
}
std::string CGameTools::getLocalData(const char* key)
{
    NSString* k = [[[NSString alloc]initWithUTF8String:key]autorelease];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* v = [defaults objectForKey:k];
    if (v != nil)
        return [v UTF8String];
    else
        return "";
}
void CGameTools::getSerial(BYTE* buf)
{
    int j = 0;
    NSString* strUID = @"ABC123456";
    //NSLog(@"getSerial=%@ len=%d",strUID,strUID.length);
    for(int i=0;i<[strUID length];i++) {
        unichar hex_char1 = [strUID characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        if (hex_char1 == '-') {
            continue;
        }
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        
        ++i;
        unichar hex_char2 = [strUID characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int int_ch = int_ch1+int_ch2;
        
        //NSLog(@"int_ch=%d",int_ch);
        
        buf[j++] = int_ch;  ///将转化后的数放入Byte数组里
    }
}
std::string CGameTools::encodeBase64(const uint8_t* input, int length)
{
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t *)data.mutableBytes;
    
    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
            
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    table[(value >> 18) & 0x3F];
        output[index + 1] =                    table[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    NSString* r = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
    return [r UTF8String];
}
/*void CGameTools::showTextView(std::string str,cocos2d::CCPoint point,cocos2d::CCSize size)
{
    g_pTextView = [[TextViewIOS alloc]initWithFrame:CGRectMake(point.x,point.y,size.width,size.height)];
    g_pTextView.textView.layer.cornerRadius = 4;
    g_pTextView.textView.layer.masksToBounds = YES;
    g_pTextView.textView.returnKeyType = UIReturnKeyDone;
    if (!str.empty()) {
        NSString* s = [[[NSString alloc]initWithUTF8String:str.c_str()]autorelease];
        g_pTextView.textView.text = s;
    }
    [[EAGLView sharedEGLView] addSubview:g_pTextView.textView];
}
void CGameTools::holdTextView()
{
    [g_pTextView.textView removeFromSuperview];
    [g_pTextView release];
    g_pTextView = nil;
}
std::string CGameTools::getTextViewString()
{
    if (g_pTextView != nil)
        return [[g_pTextView.textView text]UTF8String];
    else
        return "";
    
}*/

std::string CGameTools::cutUTF8String(std::string str,int len,bool isbytes)
{
    std::string s = str;
    int k = 0, l = 0, c = s.size();
    while (k < c) {
        if ((BYTE)s[k] > 224)
            k += 3;
        else if ((BYTE)s[k] > 192)
            k += 2;
        else
            k += 1;
        ++l;
        if ((isbytes && k >= len)||(!isbytes && l >= len)) {
            s = s.substr(0,k);
            break;
        }
    }

    return s;
}

void CGameTools::evaluate(DWORD id)
{
    static NSString *const iOSAppStoreURLFormat = @"itms-apps://itunes.apple.com/app/id%d";
    static NSString *const iOS7AppStoreURLFormat = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d";

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)? iOS7AppStoreURLFormat: iOSAppStoreURLFormat, id]]];
}

void CGameTools::runGame(std::string url,DWORD id)
{
    NSString* u = [[[NSString alloc]initWithUTF8String:url.c_str()]autorelease];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:u]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:u]];
    else
        evaluate(id);
    
}

bool CGameTools::isGameOnline(DWORD id)
{
    static NSString *const url = @"http://www.100rgame.com/online.asp?id=%d";
    
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:url, id]] encoding:NSUTF8StringEncoding error:&error];
    
    if (string != nil && [string isEqualToString:@"yes"])
        return true;
    else
        return false;
}

bool CGameTools::sendWX(std::string msg)
{
//    if ([WXApi isWXAppInstalled] == NO || [WXApi isWXAppSupportApi] == NO) {
//        return false;
//    }
//    
//    WXMediaMessage *message = [WXMediaMessage message];
//    
//    WXImageObject *ext = [WXImageObject object];
//    
//    cocos2d::CCSize size = cocos2d::CCDirector::sharedDirector()->getWinSize();
//    //定义一个屏幕大小的渲染纹理
//    cocos2d::CCRenderTexture* pScreen = cocos2d::CCRenderTexture::create(size.width,size.height, cocos2d::kCCTexture2DPixelFormat_RGBA8888);
//    //获得当前的场景指针
//    cocos2d::CCScene* pCurScene = cocos2d::CCDirector::sharedDirector()->getRunningScene();
//    //渲染纹理开始捕捉
//    pScreen->begin();
//    //当前场景参与绘制
//    pCurScene->visit();
//    //结束捕捉
//    pScreen->end();
//    pScreen->saveToFile("screenshot.png", cocos2d::kCCImageFormatPNG);
//
//    NSString *filePath = [NSString stringWithFormat:@"%s/screenshot.png",cocos2d::CCFileUtils::sharedFileUtils()->getWriteablePath().c_str()];
//    ext.imageData = [NSData dataWithContentsOfFile:filePath] ;
//    message.mediaObject = ext;
//    
//    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
//    req.bText = NO;
//    req.message = message;
//    req.scene = WXSceneTimeline;
//    
//    [WXApi sendReq:req];
//    
//    CC_SAFE_DELETE(pScreen);
    return true;
}

bool CGameTools::isIOS7()
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)
        return true;
    else
        return false;
}