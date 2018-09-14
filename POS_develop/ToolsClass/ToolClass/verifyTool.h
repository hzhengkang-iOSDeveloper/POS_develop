//
//  verifyTool.h
//  SuperRegister
//
//  Created by 陈竹 on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface verifyTool : NSObject

///邮箱
+ (BOOL) validateEmail:(NSString *)email;

///手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

///密码
+ (BOOL) validatePassword:(NSString *)passWord;

///身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//提示框
+ (void)MBProgressTextShowWithView:(UIView *)view returnText:(NSString *)text afterDelay:(NSInteger)afterDelay;
@end
