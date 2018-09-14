//
//  GlobalMethod.h
//  HePanDai2_0
//
//  Created by 余盛褚 on 15/8/13.
//  Copyright (c) 2015年 HePanDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalMethod : NSObject
//判断是否登录
//+ (BOOL)isNotLoginAccount;

//判断是否登录超时
+ (BOOL)isnotLoginOverDue:(NSString*)doMsg;

//判断是否为整数
+ (BOOL)IsPureInt:(NSString*)string;

//是否设置过交易密码
//+ (BOOL)iseditpwd;
+ (void)callPhone;
//html关键字转码
+ (NSString*)HtmlConversion:(NSString*)string;

//判断身份证号码
+ (BOOL)checkIdCard:(NSString*)CardString;

//验证手机号码
+ (BOOL)checkPhoneNumber:(NSString*)String;

//校验金额
+ (BOOL)checkMoney:(NSString*)money;

//金额格式化
+ (NSString*)MoneyFormatter:(float)money;

//json字符串转字典
+ (id )dictionaryWithJsonString:(NSString *)jsonString;

//判断接口是否需要缓存
+ (BOOL)isCachePort:(NSString*)portName;

//判断接口是否有缓存存在
+ (BOOL)portCacheIsNo:(NSString*)portName;

//缓存接口数据
+ (void)cacheCurrentPort:(NSString*)portName cacheDic:(NSDictionary*)cacheDic;

//判断接口是否有测试接口
+ (BOOL)isSimulationPort:(NSString*)portName;

//登录超时的统一处理登录超时
+ (void)LoginOutMethod:(UIViewController*)Vc;

//截取小数点后面两位
+ (NSString*)GetFloatTwoString:(NSString*)str;

//金额格式化-千分符
+ (NSString*)NumberFormatWithMoney:(CGFloat)Money;

//webview Url转换
+ (NSString *)StrTohtml5With:(NSString *)str;

//易联支付订单状态错误码
+ (NSString*)GetYlPayErrorCodeMsg:(NSString*)ErrorCode;

//获取截至到天的日期
+ (NSString*)GetYYYYMMDDTimer:(NSString*)timer;

//姓氏后用*号代替
+ (NSString*)UserNameHideWithStr:(NSString*)UserName;

//md5加密
+(NSString *)md5:(NSString *) inPutText;

//转json字符串
+(NSString*)GlobalStringWithDictionary:(NSDictionary*)dic;

// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSData *)jsonData;

// 统一接口返回数据处理
+ (void)FromUintAPIResult:(NSDictionary*)result withVC:(UIViewController*)UIVC errorBlcok:(void (^)(NSDictionary *dict))error;

// 计算时间差
+ (long)CalculateWithTimer:(NSDate*)fromDate toDate:(NSDate*)toDate;

// 富文本-字体
+ (NSMutableAttributedString*)getAttStringWitFontSize:(NSRange)rang string:(NSString*)aString FontSize:(UIFont*)aFont;

//  富文本-颜色
+ (NSMutableAttributedString*)getAttStringWitColor:(NSRange)rang string:(NSString*)aString Color:(UIColor*)aColor;

// 使用颜色创建image
+ (UIImage*)getImageWithColor:(UIColor*)aColor;

// 统一的出错处理
+ (void)connectError;

// 计算文字高度
+ (CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;

// lab HTML字符串加载
+ (NSAttributedString *)attributeLab:(UILabel *)lab WithhtmlString:(NSString *)htmlString;

/**
 获取infoPlist文件内容

 @param fileName Plist文件名
 @param type 0为字典 1为数组
 @return id类型返回值 可能是arr 也可能是dic
 */
+ (id)getInfoPlistFileContent:(NSString*)fileName withType:(NSInteger)type;
+ (UIActivityIndicatorView *)addUIActivityIndicator:(UIButton *)btn;
+ (NSString*)deviceModelName;
+(NSString *)reviseString:(NSString *)str;
@end
