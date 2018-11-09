//
//  HDMessageManager.m
//  POS_develop
//
//  Created by 胡正康 on 2018/11/9.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "HDMessageManager.h"

@implementation HDMessageManager
static LoginManager *_instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+(instancetype)shareManager
{
    return [[self alloc]init];
}
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}


- (void)LoginHDWithVc:(UIViewController *)vc
{
    //接口请求用户名和token
    HUD_NOBGSHOW;
    [[HPDConnect connect]PostOtherNetRequestMethod:@"huanxin/token" params:@{@"userId":USER_ID_POS} cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            if ([result[@"code"] integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dic = result[@"data"];
                    HDClient *client = [HDClient sharedClient];
                    NSLog(@"账号%@  token%@",[NSString stringWithFormat:@"a%@",UserDefaultsGet(MOBILE)],[NSString stringWithFormat:@"%@",dic[@"access_token"]]);
                    if (client.isLoggedInBefore != YES) {
                        HDError *error = [client loginWithUsername:[NSString stringWithFormat:@"a%@",UserDefaultsGet(MOBILE)] password:UserDefaultsGet(MOBILE)];
                        if (!error) { //登录成功
                        } else { //登录失败
                            HUD_ERROR(@"登录客服失败，请稍后重试！");
                            return;
                        }
                    }
                    // 进入会话页面
                    HDMessageViewController *chatVC = [[HDMessageViewController alloc] initWithConversationChatter:HD_IMID]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
                    chatVC.sendName = UserDefaultsGet(NICKNAME);
                    chatVC.sendAvatarUrl = UserDefaultsGet(USERHEADERIMAGE);
                    chatVC.hidesBottomBarWhenPushed = YES;
                    [vc.navigationController pushViewController:chatVC animated:YES];
                    
                }
            }
            
        }
    }];
}
@end
