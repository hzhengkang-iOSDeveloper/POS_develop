//
//  UserInfo.h
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-5.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *nickname;                 ///< 用户昵称
@property (nonatomic, copy) NSString *password;                 ///< 用户密码
@property (nonatomic, copy) NSString *email;                    ///< 用户邮箱
@property (nonatomic, copy) NSString *phoneNumber;              ///< 用户手机号
@property (nonatomic, copy) NSString *personal_assets;          ///< 个人资产
@property (nonatomic, copy) NSString *fundTotle;                ///< 账户余额
@property (nonatomic, copy) NSString *balance;                  ///< 可用金额
@property (nonatomic, copy) NSString *freezFund;                ///< 冻结资金
@property (nonatomic, copy) NSString *ungetInterest;            ///< 待收利息
@property (nonatomic, copy) NSString *ungetIntefund;            ///< 待收本息
@property (nonatomic, copy) NSString *getInterest;              ///< 已赚利息
@property (nonatomic, copy) NSString *realName;                 ///< 真实姓名
@property (nonatomic, copy) NSString *cardID;                   ///< 身份证号码
@property (nonatomic, copy) NSString *customerCode;             ///< 标号
@property (nonatomic, copy) NSString *lastLogin;                ///< 上次登陆时间
@property (nonatomic) BOOL whetherCertification;                ///< 是否已经实名认证
@property (nonatomic, copy) NSString *idCardAndRealName;        ///< 身份证号和真实姓名
@property (nonatomic) BOOL userInfoWasRequesed;                 //这个是告诉你下次对于充值 提现这种涉及资产隐私的时候需不需要再次请求用户信息 ????需要么

@property (nonatomic, copy) NSString *leftredBag;               ///< 剩余的红包数
@property (nonatomic) BOOL iseditpwd;                           ///< 是否是新手
@property (nonatomic) NSInteger lotteryTimes;                   ///< 抽奖次数
@property (nonatomic, copy) NSString* lotteryURL;                   ///< 抽奖网页链接
@property (nonatomic, retain) NSArray* JXQList;                 ///< 加息券
//@property (nonatomic, copy) NSString* CardCount;                ///< 银行卡数量
@property (nonatomic, copy) NSString* MessageCount;             ///< 系统消息数量
@property (nonatomic, copy) NSString* feedcount;             ///< 系统消息数量
@property (nonatomic, copy) NSString* Autograph;                ///< 侧栏提示语
@property (nonatomic, copy) NSString* UserImg;                  ///< 用户头像地址
@property (nonatomic, copy) NSString* nice_name;                ///< 用户昵称
@property (nonatomic, copy) NSString* mobile_phone;             ///< 用户手机号
@property (nonatomic, copy) NSString* myfooturl;                ///< 我的足迹
@property (nonatomic, copy) NSString* qukankan;                 ///< 我的合盘弹框

@property (nonatomic, copy) NSString* cardCount;                ///< 银行卡个数

- (void)clean;

- (void)valueFromeDict:(NSDictionary *)dict;

@end
