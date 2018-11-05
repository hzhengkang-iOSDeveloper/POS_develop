//
//  PD_BillDetailComfirInfoView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/29.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PD_BillDetailComfirInfoView.h"
@interface PD_BillDetailComfirInfoView ()
//确认收货
@property (nonatomic, weak) UIButton *comfirInfoBtn;

@end
@implementation PD_BillDetailComfirInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = WhiteColor;
    
    //客服
    UIView *infomationerView = [UIView getViewWithColor:WhiteColor superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(20));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(35), AD_HEIGHT(40)));
        
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickInfomationerBtn)];
        [view addGestureRecognizer:gest];
    }];
    
    UIImageView *kefuImage = [[UIImageView alloc]init];
    kefuImage.contentMode = UIViewContentModeScaleAspectFit;
    kefuImage.image = ImageNamed(@"客服");
    [infomationerView addSubview:kefuImage];
    [kefuImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.centerX.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(18), AD_HEIGHT(18)));
    }];
    
    UILabel *kefuLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:infomationerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.top.equalTo(kefuImage.mas_bottom).offset(AD_HEIGHT(7));
        make.centerX.offset(0);
        
        view.text = @"客服";
    }];
    
    
    //确认收货
    UIButton *comfirInfoBtn = [UIButton getButtonWithImageName:@"" titleText:@"确认收货" superView:self masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.centerY.offset(0);
        make.right.offset(-AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(22)));
        
        [btn setTitleColor:WhiteColor forState:normal];
        btn.titleLabel.font = F15;
        [btn setBackgroundColor:C1E95F9];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.f;
        [btn addTarget:self action:@selector(clickComfirBillBtn) forControlEvents:UIControlEventTouchUpInside];
    }];
    self.comfirInfoBtn = comfirInfoBtn;
}
#pragma mark ---- 客服 ----
- (void)clickInfomationerBtn
{
    HDClient *client = [HDClient sharedClient];
    if (client.isLoggedInBefore != YES) {
        HDError *error = [client loginWithUsername:@"username" password:@"password"];
        if (!error) { //登录成功
        } else { //登录失败
            return;
        }
    }
    // 进入会话页面
    HDMessageViewController *chatVC = [[HDMessageViewController alloc] initWithConversationChatter:@"IM 服务号"]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
    [self.viewController.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark ---- 确认收货 ----
- (void)clickComfirBillBtn
{

    [SLPopupShowView createPopupShowViewWithContentText:@"是否确认收货" buttons:@[@"确认收货",@"取消"] buttonClick:^(int index) {
        if (index == 0) {
            if (self.comfirHandler) {
                self.comfirHandler();
            }
        }
    }];
}


@end
