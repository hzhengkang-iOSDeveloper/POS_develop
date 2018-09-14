//
//  verifyTool.m
//  SuperRegister
//
//  Created by 陈竹 on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "verifyTool.h"

@implementation verifyTool
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}





//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
@end
