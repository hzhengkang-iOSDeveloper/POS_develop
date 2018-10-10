 //
//  GlobalMethod.m
//  HePanDai2_0
//
//  Created by 余盛褚 on 15/8/13.
//  Copyright (c) 2015年 HePanDai. All rights reserved.
//

#import "GlobalMethod.h"
//#import "LoginViewController.h"
#import "GTMNSString+HTML.h"
#import <sys/utsname.h>
@implementation GlobalMethod

#pragma mark 判断是否登录
/*
+(BOOL)isNotLoginAccount{
    LoginManager *loginMagr;
    loginMagr = [LoginManager  getInstance];
    if (loginMagr.wasLogin) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)iseditpwd{
    LoginManager *loginMagr;
    loginMagr = [LoginManager  getInstance];
    if (loginMagr.userInfo.iseditpwd) {
        return YES;
    }else{
        return NO;
    }
}
*/
#pragma mark 判断是否登录超时
+(BOOL)isnotLoginOverDue:(NSString*)doMsg{
    if ([doMsg integerValue] == 100001) {
        return YES;
    }
    else{
    return YES;
    }
}

#pragma mark 判断是否为整数
+ (BOOL)IsPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val]&&[scan isAtEnd];
}


#pragma mark html关键字转码
+(NSString*)HtmlConversion:(NSString*)string{
    NSString* str = string;
    str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    return str;
}

#pragma mark 判断身份证号码
+ (BOOL)checkIdCard:(NSString*)CardString
{
    NSString* String = [CardString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",CardString);
    if (!String || String.length == 0) {
        showAlertWithMessgae(@"请输入您的身份证号");
        return NO;
    }
    else if (![String isIDCardFormart]) {
        showAlertWithMessgae(@"请输入正确的身份证号");
        return NO;
    }
    return YES;
}

#pragma mark 判断手机号码是否符合规则
+ (BOOL)checkPhoneNumber:(NSString*)String
{
    if (!String || String.length == 0) {
        HUD_TIP(@"请输入您的手机号码!");
        return NO;
    }
    else if (![String isPhoneNumberFormat]) {
        HUD_TIP(@"请输入正确的手机号码!");
        return NO;
    }
    else
        return YES;
}

#pragma mark 校验金额
+ (BOOL)checkMoney:(NSString *)money
{
    if (money.length<=0) {
        HUD_TIP(@"请输入提现金额");
        return NO;
    }
    
    if (![money isMoneyFormmat]) {
        HUD_TIP(@"请输入正确的金额格式");
        return NO;
    }
    return YES;
}

#pragma mark 金额格式化
+ (NSString*)MoneyFormatter:(float)money{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithFloat:money]];
    NSLog(@"Formatted number string:%@",string);
    return string;
}

#pragma mark json字符串转字典
+ (id)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil || [jsonString isEqual:[NSNull null]]) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark 判断当前接口是否需要缓存
+ (BOOL)isCachePort:(NSString*)portName{
    NSBundle* Bound = [NSBundle mainBundle];
    NSString* Path = [Bound pathForResource:@"cachePort" ofType:@"plist"];
    NSArray* tempArr = [NSArray arrayWithContentsOfFile:Path];
    if (tempArr.count == 0 || [tempArr indexOfObject:portName] == NSNotFound) {
        NSLog(@"当前接口不需要缓存😂😂😂");
        return NO;
    }
    NSLog(@"当前接口需要缓存,先判断缓存是否存在😂😂😂");
    return YES;
}

#pragma mark 判断接口缓存是否存在
+ (BOOL)portCacheIsNo:(NSString*)portName{
    NSDictionary* cacheDic = [USER_DEFAULT objectForKey:portName];
    if (cacheDic != nil) {
        NSLog(@"缓存存在,先载入缓存😂😂😂");
        return YES;
    }
    NSLog(@"缓存不存在😂😂😂");
    return NO;
}

#pragma mark 添加接口缓存
+ (void)cacheCurrentPort:(NSString*)portName cacheDic:(NSDictionary*)cacheDic{
    if ([GlobalMethod isCachePort:portName]) {
        [UserInformation saveUserinfoWithKey:portName value:cacheDic];
//        [USER_DEFAULT setObject:cacheDic forKey:portName];
    }
}

+ (BOOL)isSimulationPort:(NSString*)portName{
    NSBundle* Bound = [NSBundle mainBundle];
    NSString* Path = [Bound pathForResource:@"simulationPort" ofType:@"plist"];
    NSArray* tempArr = [NSArray arrayWithContentsOfFile:Path];
    if (tempArr.count == 0 || [tempArr indexOfObject:portName] == NSNotFound) {
        NSLog(@"非模拟接口");
        return NO;
    }else{
        if (showSimulationPort) {
            NSLog(@"模拟接口,开启");
            return YES;
        }else{
            NSLog(@"模拟接口,不开启");
            return NO;
        }
    }
    
}

#pragma mark 登录超时的统一处理登录超时
+ (void)LoginOutMethod:(UIViewController*)Vc{
    /*
    LoginViewController *loginVC = [[LoginViewController alloc] initWithShowType:LoginViewShowTypePresent];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:loginVC ];
    [Vc presentViewController:naviVC animated:YES completion:^{}];
     */
}


#pragma mark 截取小数点后面两位
+ (NSString*)GetFloatTwoString:(NSString*)str{
   NSRange rang = [str rangeOfString:@"."];
    NSUInteger index = 0;
    if (rang.length>0) {
        index = rang.location + 3;
        if (index>str.length) {
            index = str.length;
        }
        return [str substringToIndex:index];
    }
    return str;
}

#pragma mark 金额格式化-千分符
+ (NSString*)NumberFormatWithMoney:(CGFloat)Money{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setPositiveFormat:@"###,##0.00;"];
    //formatter.numberStyle =kCFNumberFormatterDecimalStyle;
    NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithFloat:Money]];
    return newAmount;
}

+ (NSString *)StrTohtml5With:(NSString *)str{
    
    NSMutableString *html5str = [NSMutableString stringWithString:[str gtm_stringByUnescapingFromHTML]];
    NSRange range = [html5str rangeOfString:@"?"];
    if ((range.length > 0)) {
        NSRange range1 = [html5str rangeOfString:@"source=app"];
        if ((range1.length > 0)) {
            [html5str appendString:@"&platform=1"];
        }else{
            [html5str appendString:@"&source=app&platform=1"];
        }
    }else{
        [html5str appendString:@"?source=app&platform=1"];
    }
    NSRange range2 = [html5str rangeOfString:@"usercode"];
    if (range2.length > 0) {
        NSRange range3 = [html5str rangeOfString:@"&" options:0 range:NSMakeRange(range2.location, [html5str length]-range2.location-range.length)];
    if ([[[LoginManager getInstance] userInfo] customerCode]) {
        [html5str replaceCharactersInRange:NSMakeRange(range2.location, range3.location-range2.location) withString:[NSString stringWithFormat:@"usercode=%@",[[[LoginManager getInstance] userInfo] customerCode]]];
    }
    }else{
    if ([[[LoginManager getInstance] userInfo] customerCode]) {
        [html5str appendString:[NSString stringWithFormat:@"&usercode=%@",[[[LoginManager getInstance] userInfo] customerCode]]];
    }
    }
    return html5str;
}
+ (NSString*)GetYlPayErrorCodeMsg:(NSString*)ErrorCode{
    NSBundle* Bound = [NSBundle mainBundle];
    NSString* Path = [Bound pathForResource:@"YLPayErrorCode" ofType:@"plist"];
    NSDictionary* tempDic = [NSDictionary dictionaryWithContentsOfFile:Path];
    NSLog(@"tempDic = %@",tempDic);
    NSString* Msg = tempDic[ErrorCode];
    if (Msg.length<=0) {
        return [NSString stringWithFormat:@"订单状态未知,statusCode =%@",ErrorCode];
    }else{
        return Msg;
    }
}

#pragma mark 获取截至到天的日期
+ (NSString*)GetYYYYMMDDTimer:(NSString*)timer{
    if (timer.length<10) {
        return timer;
    }
    NSString *currentDateStr = [timer substringToIndex:10];
    //输出格式为：2010-10-27 10:22:13
    NSLog(@"%@",currentDateStr);
    return currentDateStr;
}

#pragma mark 姓氏后用*号代替
+ (NSString*)UserNameHideWithStr:(NSString*)UserName{
    NSInteger len = UserName.length;
    NSString* HeadStr = [UserName substringToIndex:1];
    for (int i = 0; i<len-1; i++) {
        HeadStr = [NSString stringWithFormat:@"%@*",HeadStr];
    }
    NSLog(@"headStr = %@",HeadStr);
    return HeadStr;
}
//md5加密
+(NSString *)md5:(NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

//字典转json字符串
+(NSString*)GlobalStringWithDictionary:(NSDictionary*)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    if (jsonData == nil) {
        return nil;
    }
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}
// 统一接口返回数据处理
+ (void)FromUintAPIResult:(NSDictionary*)result withVC:(UIViewController*)UIVC errorBlcok:(void (^)(NSDictionary *dict))error{
    if ([result[@"doStatu"] intValue] == 0) {
        if(![result[@"doObject"] isKindOfClass:[NSNull class]] && result[@"doObject"]){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[result[@"doObject"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers  error:nil];
            if(dict[@"Error_Type"]){
                if ([dict[@"Error_Type"] intValue] == 1) {
                    if (dict[@"Error_Btn_Two_Text"]) {
                        [UIAlertView showAlertViewWithTitle:dict[@"Error_Title"] message:[dict[@"Error_Content"]gtm_stringByUnescapingFromHTML]cancelButtonTitle:nil otherButtonTitles:@[dict[@"Error_Btn_One_Text"],dict[@"Error_Btn_Two_Text"]] onDismiss:^(NSInteger buttonIndex) {
//                            WebViewAction *AC = [WebViewAction getInstance];
//                            if (-1 == buttonIndex) {
//                                [AC respondVC:UIVC actionKey:dict[@"Error_Btn_One_Url"]];
//                            }else if (0 == buttonIndex){
//                                [AC respondVC:UIVC actionKey:dict[@"Error_Btn_Two_Url"]];
//                            }
                        } onCancel:^{

                        }];
                    }else{
                        [UIAlertView showAlertViewWithTitle:dict[@"Error_Title"] message:[dict[@"Error_Content"]gtm_stringByUnescapingFromHTML]cancelButtonTitle:nil otherButtonTitles:@[dict[@"Error_Btn_One_Text"]] onDismiss:^(NSInteger buttonIndex) {
//                            WebViewAction *AC = [WebViewAction getInstance];
//                            [AC respondVC:UIVC actionKey:dict[@"Error_Btn_One_Url"]];
                        } onCancel:^{

                        }];
                    }

                }else if ([dict[@"Error_Type"] intValue] == 0){
                    HUD_TIP([dict[@"Error_Content"] gtm_stringByUnescapingFromHTML]);
                }

            }else{
                error(dict);
            }
        }else{
            HUD_TIP([result[@"prompt"] gtm_stringByUnescapingFromHTML]);
        }
    }else if ([result[@"doStatu"] intValue] == 2){
        if([result[@"errCode"] isEqualToString:@"9999"]){
            HUD_ERROR(@"用户未登录");
        }else if ([result[@"errCode"] isEqualToString:@"100001"]){
            //登录超时
            [UIVC.view endEditing:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIAlertShowMessage(@"用户登录超时，请重新登录", ^{
                   
                });
                
                [NOTIFICATION_CENTER postNotificationName:UN_LoginOutTime object:nil];
                //                    UIVC.tabBarController.selectedIndex = 0;
                UIVC.tabBarController.tabBar.hidden = NO;
                UIVC.hidesBottomBarWhenPushed = NO;
                [UIVC.navigationController popToRootViewControllerAnimated:YES];
            });
           
        }else if ([result[@"errCode"] isEqualToString:@"99990004"]){
            HUD_ERROR(@"接口异常");
        }
        else{
            HUD_TIP([result[@"prompt"] gtm_stringByUnescapingFromHTML]);
        }
    }
}

#pragma mark 计算时间差
+ (long)CalculateWithTimer:(NSDate*)fromDate toDate:(NSDate*)toDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *day = [calendar components:unitFlags fromDate:fromDate toDate:toDate options:0];
    
    long sec = [day day]*86400 + [day hour]*3600 + [day minute]*60 + [day second];
    
    return sec;
}

#pragma mark 自定义NSMutableAttributedString


/**
 富文本-字体
 @param rang 范围
 @param aString 原始字符串
 @param aFont 字体
 @return 特效
 */
+ (NSMutableAttributedString*)getAttStringWitFontSize:(NSRange)rang string:(NSString*)aString FontSize:(UIFont*)aFont{
    if (aString.length<=0) {
        return [[NSMutableAttributedString alloc]initWithString:@""];
    }
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc]initWithString:aString];
    
    [attStr addAttribute:NSFontAttributeName
                   value:aFont
                   range:rang];
    return attStr;
}
/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+(NSString *)reviseString:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%.2lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

/**
 富文本-颜色

 @param rang 范围
 @param aString 原始
 @param aColor 颜色
 @return 特效
 */
+ (NSMutableAttributedString*)getAttStringWitColor:(NSRange)rang string:(NSString*)aString Color:(UIColor*)aColor{
    if (aString.length<=0) {
        return [[NSMutableAttributedString alloc]initWithString:@""];
    }
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc]initWithString:aString];
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:aColor
                   range:rang];
    return attStr;
}


/**
 使用颜色创建image

 @param aColor 颜色
 @return image对象
 */
+ (UIImage*)getImageWithColor:(UIColor*)aColor{
    // 使用颜色创建UIImage
    CGSize imageSize = CGSizeMake(1,1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [aColor set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+ (void)connectError{
    showRequestFailedAlert;
}

//计算文字高度
+ (CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    if([string isEqual:[NSNull null]]){
        return 0;
    }
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height;
}

+ (id)getInfoPlistFileContent:(NSString*)fileName withType:(NSInteger)type{
    NSBundle* Bound = [NSBundle mainBundle];
    NSString* Path = [Bound pathForResource:fileName ofType:@"plist"];
    id temp = type == 0 ? [NSDictionary dictionaryWithContentsOfFile:Path] : [NSArray arrayWithContentsOfFile:Path];
    return temp;
}
+ (void)callPhone{
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:4008818158"]]) {
        [UIAlertView showMessage:@"您的设备不支持拨打电话！"];
    }else{
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4008818158"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}
#pragma mark lab HTML字符串加载
+ (NSAttributedString *)attributeLab:(UILabel *)lab WithhtmlString:(NSString *)htmlString{
    NSDictionary *optoins=@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,                             NSFontAttributeName:lab.font};
    NSData *data=[htmlString dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *attributeString=[[NSAttributedString alloc] initWithData:data                                                                      options:optoins                                                           documentAttributes:nil                                                                        error:nil];
    return attributeString;
}
#pragma mark btn 加载loading
+ (UIActivityIndicatorView *)addUIActivityIndicator:(UIButton *)btn{
    
    UIActivityIndicatorView *_aview;
    if (CGColorEqualToColor(btn.backgroundColor.CGColor, WhiteColor.CGColor)) {
        _aview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    }else{
        _aview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    }
    _aview.frame = CGRectMake(0, 0, btn.bounds.size.width, btn.bounds.size.height);
    _aview.center = btn.center;
    _aview.backgroundColor = ClearColor;
    [btn setTitle:@"" forState:UIControlStateNormal];
    _aview.hidesWhenStopped = YES;
    [btn.superview addSubview:_aview];
    [_aview startAnimating];
    return _aview;
}

// 需要
+ (NSString*)deviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    
    //iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceModel isEqualToString:@"iPad4,4"]
        ||[deviceModel isEqualToString:@"iPad4,5"]
        ||[deviceModel isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceModel isEqualToString:@"iPad4,7"]
        ||[deviceModel isEqualToString:@"iPad4,8"]
        ||[deviceModel isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceModel;
}
@end
