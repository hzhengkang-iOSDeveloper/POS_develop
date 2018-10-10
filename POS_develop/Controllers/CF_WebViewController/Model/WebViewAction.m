//
//  WebViewAction.m
//  SCWebViewControllerDemo
//
//  Created by hpjr on 2016/12/6.
//  Copyright © 2016年 sands. All rights reserved.
//

#import "WebViewAction.h"

//#import "CF_RegisterNewUserViewController.h"
//
//#import "CF_LoginViewController.h"
//
//#import "SigninViewController.h"
//#import "RecommendedFriendVC.h"

#import "ActivityView.h"
#import "SGActionView.h"

static WebViewAction *instance = nil;

@implementation WebViewAction{

}

+ (instancetype)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WebViewAction alloc] init];
    });
    return instance;
}
- (NSString *)ocstringEncode:(NSString *)str {
    
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%<>[\\]^`{|}\"]+"].invertedSet];

    
}
- (NSString *)ocstringDecode:(NSString *)str {
    
    return [str stringByRemovingPercentEncoding];
}
- (void)respondVC:(UIViewController*)respondVC actionKey:(NSString*)aKey{
    self.loginMagr = [LoginManager getInstance];
    
    NSString* string4 = [aKey stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    //截取掉前面八位
    NSString *jsonStr = [string4 substringFromIndex:8];

    //字符串赚词典
    NSDictionary *dic = [jsonStr objectFromJSONString];
    [self actionDistribute:respondVC actionDic:dic];
  
}

- (void)respondVC:(UIViewController*)respondVC actionDic:(NSDictionary*)aDic{
     self.loginMagr = [LoginManager getInstance];
    [self actionDistribute:respondVC actionDic:aDic];
}

- (void)actionDistribute:(UIViewController*)respondVC actionDic:(NSDictionary*)dic{
    //0 -> 本地页面跳转
    //1 -> HTML页面分享
    //2 -> 打开一个新的webview界面
    //3 -> 关闭HTML页面
    if ([dic[@"actionType"] intValue] == 0) {
        [self respondVC:respondVC actionWithOpenLocalVC:dic];
        
    }else if ([dic[@"actionType"] intValue] == 1){

        
    }else if ([dic[@"actionType"] intValue] == 2){
        [self respondVC:respondVC actionWithOpenNewWebView:dic];
        
    }else if ([dic[@"actionType"] intValue] == 3){
        [self respondVC:respondVC actionWithCloseAllWebView:dic];
        
    }
}

/**
 webView跳转APP本地页面

 @param respondVC 操作的VC
 @param actionDictory 参数字典
 */
- (void)respondVC:(UIViewController*)respondVC actionWithOpenLocalVC:(NSDictionary*)actionDictory{
    NSString* action = actionDictory[@"action"];
    
    if ([action isEqualToString:@"main_page"]) {
        [self comtoHome:respondVC];
        
    }else if ([action isEqualToString:@"login"]){
        if (self.loginMagr.wasLogin) {
            HUD_TIP(@"您已登录!");
            return;
        }
//        CF_LoginViewController *loginVC = [[CF_LoginViewController alloc] initWithShowType:LoginViewShowTypePresent];
//        UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:loginVC ];
//        [respondVC presentViewController:naviVC animated:YES completion:^{
        
//        }];
    }else if ([action isEqualToString:@"register"]){
        if (self.loginMagr.wasLogin) {
            HUD_TIP(@"您已登录，请退出后再注册!");
            [self comtoHome:respondVC];
        }else{
//            CF_RegisterNewUserViewController* registerVC = [[CF_RegisterNewUserViewController alloc] init];
//            registerVC.hidesBottomBarWhenPushed = true;
//            [respondVC.navigationController pushViewController:registerVC animated:YES];
        }
        
    }

    else if ([action isEqualToString:@"product"]){
        NSDictionary *doObject;
        if ([actionDictory[@"doObject"] isKindOfClass:[NSString class]]) {
            doObject = [actionDictory[@"doObject"] objectFromJSONString];
        }else{
            doObject = actionDictory[@"doObject"];
        }
        

    }else if ([action isEqualToString:@"products_list"]){
        if ([actionDictory[@"doObject"] isKindOfClass:[NSString class]]) {
            NSDictionary *dict = [actionDictory[@"doObject"] objectFromJSONString];
            [NOTIFICATION_CENTER postNotificationName:kWebOpenProductListNotification object:nil userInfo:@{@"index":dict[@"stringId"]}];
        }else{
           [NOTIFICATION_CENTER postNotificationName:kWebOpenProductListNotification object:nil userInfo:@{@"index":actionDictory[@"doObject"][@"stringId"]}];
        }
        respondVC.tabBarController.selectedIndex = 1;
        respondVC.tabBarController.tabBar.hidden = NO;
        [respondVC.navigationController popToRootViewControllerAnimated:YES];
        
    }else if ([action isEqualToString:@"shake"]){
        if (!self.loginMagr.wasLogin) {
            [self cometoLogin:respondVC];
        }else{
//            SigninViewController* signin = [[SigninViewController alloc]init];
//            signin.hidesBottomBarWhenPushed = true;
//            [respondVC.navigationController pushViewController:signin animated:YES];
        }
        
    }else if ([action isEqualToString:@"introduce_freiends"]){
        if (!self.loginMagr.wasLogin) {
            [self cometoLogin:respondVC];
        }else{
//            RecommendedFriendVC* RecommendedFriend = [[RecommendedFriendVC  alloc] init];
//            RecommendedFriend.hidesBottomBarWhenPushed = true;
//            [respondVC.navigationController pushViewController:RecommendedFriend animated:YES];
        }
        
    }

}





/**
 webView->打开新的webView

 @param respondVC 操作的VC
 @param actionDictory 参数字典
 */
- (void)respondVC:(UIViewController*)respondVC actionWithOpenNewWebView:(NSDictionary*)actionDictory{
    NSString* action = actionDictory[@"action"];
    NSDictionary *doObject;
    if ([actionDictory[@"doObject"] isKindOfClass:[NSString class]]) {
        doObject = [actionDictory[@"doObject"] objectFromJSONString];
    }else{
        doObject = actionDictory[@"doObject"];
    }
        @try {
            //如果@try中的代码会导致程序崩溃，就会来到@catch
            if ([action isEqualToString:@"open_new_url"]){
                CommunityWebViewController* CommunityWebView = [[CommunityWebViewController alloc]init];
                CommunityWebView.CommunityUrl = doObject[@"url"];
                CommunityWebView.title= doObject[@"title"];
                CommunityWebView.hidesBottomBarWhenPushed = true;
                NSLog(@"CommunityWebView.CommunityUrl = %@",CommunityWebView.CommunityUrl);
                [respondVC.navigationController pushViewController:CommunityWebView animated:YES];
            }
        }
        @catch (NSException *exception) {
    
            UIAlertView * alert =
            [[UIAlertView alloc]
             initWithTitle:@"错误"
             message: [[NSString alloc] initWithFormat:@"%@",exception]
             delegate:self
             cancelButtonTitle:nil
             otherButtonTitles:@"OK", nil];
            [alert show];
    
            //如果@try中的代码有问题(导致崩溃),就会来到@catch
    
            //在这里你可以进行相应的处理操作
            
            //如果你要抛出异常(让程序崩溃),就写上 @throw exception
            
        }
}

/**
 webView->关闭webView

 @param respondVC 操作的VC
 @param actionDictory 参数字典
 */
- (void)respondVC:(UIViewController*)respondVC actionWithCloseAllWebView:(NSDictionary*)actionDictory{
    NSString* action = actionDictory[@"action"];
    if ([action isEqualToString:@"close_webview"]){
        UIWindow* keywindosw = [[UIApplication sharedApplication]keyWindow];
        for (UIView *view in keywindosw.subviews) {
            if ([view isKindOfClass:[ActivityView class]]) {
                [view removeFromSuperview];
            }
        }
    }
}


- (void)comtoHome:(UIViewController*)respondVC{
    respondVC.tabBarController.selectedIndex = 0;
    respondVC.tabBarController.tabBar.hidden = NO;
    [respondVC.navigationController popToRootViewControllerAnimated:YES];
}

- (void)cometoLogin:(UIViewController*)respondVC{
    
    HUD_ERROR(@"请先登录后再操作!");
//    CF_LoginViewController *login = [[CF_LoginViewController  alloc] init];
//    [respondVC.navigationController pushViewController:login animated:YES];
}

//HTML 活动页面跳转
- (void)toCommunityWebViewController:(UIViewController *)VC
{
    CommunityWebViewController* CommunityWebView = [[CommunityWebViewController alloc]init];
    CommunityWebView.CommunityUrl = @"http://weixin.hepandai.com/ad/ActivityCenter?source=app";
    CommunityWebView.title = @"活动中心";
    NSLog(@"CommunityWebView.CommunityUrl = %@",CommunityWebView.CommunityUrl);
    CommunityWebView.hidesBottomBarWhenPushed = true;
    [VC.navigationController pushViewController:CommunityWebView animated:YES];
}




- (NSString*) unescapeUnicodeString:(NSString*)string
{
    // unescape quotes and backwards slash
    NSString* unescapedString = [string stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    unescapedString = [unescapedString stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
    
    
    // tokenize based on unicode escape char
    NSMutableString* tokenizedString = [NSMutableString string];
    NSScanner* scanner = [NSScanner scannerWithString:unescapedString];
    while ([scanner isAtEnd] == NO)
    {
        // read up to the first unicode marker
        // if a string has been scanned, it's a token
        // and should be appended to the tokenized string
        NSString* token = @"";
        [scanner scanUpToString:@"%u" intoString:&token];
        NSLog(@"%@",token);
        if (token != nil && token.length > 0)
        {
            token = [token substringFromIndex:1];
            unichar codeValue = (unichar) strtol([token UTF8String], NULL, 16);
            [tokenizedString appendString:[NSString stringWithFormat:@"%C", codeValue]];
            NSLog(@"%@",[NSString stringWithFormat:@"%C", codeValue]);
            //            [tokenizedString appendString:token];
            continue;
        }
        
        // skip two characters to get past the marker
        // check if the range of unicode characters is
        // beyond the end of the string (could be malformed)
        // and if it is, move the scanner to the end
        // and skip this token
        NSUInteger location = [scanner scanLocation];
        NSInteger extra = scanner.string.length - location - 4 - 2;
        if (extra < 0)
        {
            NSRange range = {location, -extra};
            [tokenizedString appendString:[scanner.string substringWithRange:range]];
            [scanner setScanLocation:location - extra];
            continue;
        }
        
        // move the location pas the unicode marker
        // then read in the next 4 characters
        location += 2;
        NSRange range = {location, 4};
        token = [scanner.string substringWithRange:range];
        unichar codeValue = (unichar) strtol([token UTF8String], NULL, 16);
        [tokenizedString appendString:[NSString stringWithFormat:@"%C", codeValue]];
        
        // move the scanner past the 4 characters
        // then keep scanning
        location += 4;
        [scanner setScanLocation:location];
    }
    // done
    return tokenizedString;
}

+ (NSString*) escapeUnicodeString:(NSString*)string
{
    // lastly escaped quotes and back slash
    // note that the backslash has to be escaped before the quote
    // otherwise it will end up with an extra backslash
    NSString* escapedString = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    // convert to encoded unicode
    // do this by getting the data for the string
    // in UTF16 little endian (for network byte order)
    NSData* data = [escapedString dataUsingEncoding:NSUTF16LittleEndianStringEncoding allowLossyConversion:YES];
    size_t bytesRead = 0;
    const char* bytes = data.bytes;
    NSMutableString* encodedString = [NSMutableString string];
    
    // loop through the byte array
    // read two bytes at a time, if the bytes
    // are above a certain value they are unicode
    // otherwise the bytes are ASCII characters
    // the %C format will write the character value of bytes
    while (bytesRead < data.length)
    {
        uint16_t code = *((uint16_t*) &bytes[bytesRead]);
        if (code > 0x007E)
        {
            [encodedString appendFormat:@"%%u%04X", code];
        }
        else
        {
            [encodedString appendFormat:@"%C", code];
        }
        bytesRead += sizeof(uint16_t);
    }
    
    // done
    return encodedString;
}


-(NSString *)StringDecodeJava:(NSString *)src
{
    NSMutableString *tmp = [NSMutableString string];
    int lastPos = 0, pos = 0;
    NSScanner* scanner = [NSScanner scannerWithString:src];
    while (lastPos < src.length) {
        NSString* token = @"";
        [scanner scanUpToString:@"%" intoString:&token];
        pos = [scanner scanLocation];
        if (pos == lastPos) {
            if ([src characterAtIndex:(pos + 1)] == 'u') {
                NSString *t = [src substringWithRange:NSMakeRange(pos+2, 4)];
                unichar codeValue = (unichar) strtol([t UTF8String], NULL, 16);
                [tmp appendString:[NSString stringWithFormat:@"%C", codeValue]];
                lastPos = pos + 6;
                
            }
            else {
                NSString *t = [src substringWithRange:NSMakeRange(pos+1, 2)];
                unichar codeValue = (unichar) strtol([t UTF8String], NULL, 16);
                [tmp appendString:[NSString stringWithFormat:@"%C", codeValue]];
                lastPos = pos + 3;
            }
        }
        else if (pos == -1) {
            [tmp appendString:[src substringFromIndex:lastPos]];
            lastPos = src.length;
        }
        else {
            [tmp appendString:[src substringWithRange:NSMakeRange(lastPos, pos-lastPos)]];;
            lastPos = pos;
        }
        [scanner setScanLocation:lastPos];
    }
    return tmp;
}

@end
