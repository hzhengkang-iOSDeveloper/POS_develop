//
//  VipSystemViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "VipSystemViewController.h"
#import "UILabel+Style.h"

@interface VipSystemViewController ()
@property (nonatomic, strong) UILabel *vipGradeL;
@property (nonatomic, strong) UILabel *powerContentL;
@property (nonatomic, strong) UILabel *receivePosTextL;
@property (nonatomic, strong) UILabel *highLevelL;
@property (nonatomic, strong) UILabel *highLevelPhoneL;
@end

@implementation VipSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"会员中心";
    self.view.backgroundColor = WhiteColor;
    [self initUI];
    [self loadAgentListRequest];
    [self loadAgentListAncesRequest];
}

- (void)initUI {
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = CF6F6F6;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(45)));
    }];
    UIImageView *logoImageV = [[UIImageView alloc] init];
    logoImageV.image = [UIImage imageNamed:@"等级"];
    [topView addSubview:logoImageV];
    [logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(FITiPhone6(15));
        make.top.equalTo(topView).offset(FITiPhone6(15));
        make.size.mas_offset(CGSizeMake(FITiPhone6(15), FITiPhone6(16)));
    }];
    UILabel *gradeL = [[UILabel alloc] init];
    gradeL.text = @"我的等级:";
    gradeL.textColor = C000000;
    gradeL.font = F12;
    gradeL.adjustsFontSizeToFitWidth = YES;
    [topView addSubview:gradeL];
    [gradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImageV.mas_right).offset(FITiPhone6(9));
        make.centerY.equalTo(logoImageV.mas_centerY);
        make.height.mas_equalTo(FITiPhone6(12));
    }];
    UILabel *vipGradeL = [[UILabel alloc] init];
    self.vipGradeL = vipGradeL;
//    vipGradeL.text = @"VIP6";
    vipGradeL.textColor = C000000;
    vipGradeL.font = FB18;
    [topView addSubview:vipGradeL];
    [vipGradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(gradeL.mas_right).offset(FITiPhone6(8));
        make.centerY.equalTo(gradeL.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(80), FITiPhone6(15)));
    }];
    UILabel *powerL = [[UILabel alloc] init];
    powerL.text = @"我的权限：";
    powerL.textColor = C000000;
    powerL.font = F13;
    [self.view addSubview:powerL];
    [powerL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(16));
        make.top.equalTo(topView.mas_bottom).offset(FITiPhone6(12));
        make.size.mas_offset(CGSizeMake(FITiPhone6(80), FITiPhone6(13)));
    }];
    UILabel *powerContentL = [[UILabel alloc] init];
    self.powerContentL = powerContentL;
    powerContentL.font = F12;
    powerContentL.numberOfLines = 0;
//    powerContentL.text = @"忙我IEhi教案设计的就爱就开始打进口红酒案件被大家把几点回家噶不敢速度噶US高度牙膏已收到各环节氨甲环酸嘎哈就是地沟油盎司的后果暗红色的：爱仕达多阿道夫俺的沙发大大声道俺的沙发俺的沙发奥瑞特让他富饶的啊设计的就爱就开始打进口红酒案件被大家把几点回家噶不敢速度噶US高度牙膏已收到各环节氨甲环酸嘎哈就是地沟油盎司的后果暗红色的：爱仕达多阿设计的就爱就开始打进口红酒案件被大家把几点回家噶不敢速度噶US高度牙膏已收到各环节氨甲环酸嘎哈就是地沟油盎司的后果暗红色的：爱仕达多阿吃";
    powerContentL.textColor = C000000;
    [powerContentL changeLabelHeightWithWidth:(ScreenWidth-FITiPhone6(30))];//加上这句
    [UILabel heightWithText:powerContentL.text fontSize:FITiPhone6(13) labelWidth:ScreenWidth - FITiPhone6(30)];
    [self.view addSubview:powerContentL];
    [powerContentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(powerL.mas_bottom).offset(FITiPhone6(8));
        make.width.mas_equalTo(ScreenWidth-FITiPhone6(30));//自适应高度无需设置高 看笔记
    }];
    UIView *borderView = [[UIView alloc] init];
    borderView.backgroundColor = ClearColor;
    borderView.layer.cornerRadius = FITiPhone6(3);
    borderView.layer.masksToBounds = YES;
    borderView.layer.borderWidth = FITiPhone6(0.5);
    borderView.layer.borderColor = CE6E2E2.CGColor;
    [self.view addSubview:borderView];
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(powerContentL.mas_bottom).offset(FITiPhone6(30));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(67)));
    }];
    UILabel *receivePosL = [[UILabel alloc] init];
    receivePosL.text = @"免费领取机器：";
    receivePosL.textColor = C000000;
    receivePosL.font = F13;
    receivePosL.adjustsFontSizeToFitWidth = YES;
    [borderView addSubview:receivePosL];
    [receivePosL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(borderView).offset(FITiPhone6(11));
        make.centerY.equalTo(borderView);
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    UILabel *receivePosTextL = [[UILabel alloc] init];
    self.receivePosTextL = receivePosTextL;
    receivePosTextL.numberOfLines = 0;
//    receivePosTextL.text = @"已领3台，还可以领取2台";
    receivePosTextL.textColor = C989898;
    receivePosTextL.font = F13;
    receivePosTextL.adjustsFontSizeToFitWidth = YES;
    [borderView addSubview:receivePosTextL];
    [receivePosTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(receivePosL.mas_right).offset(FITiPhone6(5));
        make.centerY.equalTo(borderView);
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    
    UILabel *highLevelL = [[UILabel alloc] init];
    self.highLevelL = highLevelL;
//    highLevelL.text = @"我的上级：纪总";
    highLevelL.textColor = C000000;
    highLevelL.font = F13;
    highLevelL.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:highLevelL];
    [highLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(16));
        make.top.equalTo(borderView.mas_bottom).offset(FITiPhone6(30));
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    UILabel *highLevelPhoneL = [[UILabel alloc] init];
    self.highLevelPhoneL = highLevelPhoneL;
//    highLevelPhoneL.text = @"上级电话：13020320302";
    highLevelPhoneL.textColor = C000000;
    highLevelPhoneL.font = F13;
    highLevelPhoneL.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:highLevelPhoneL];
    [highLevelPhoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(highLevelL.mas_left);
        make.top.equalTo(highLevelL.mas_bottom).offset(FITiPhone6(8));
        make.height.mas_equalTo(FITiPhone6(13));
    }];
    UIButton *callTelephoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callTelephoneBtn setImage:[UIImage imageNamed:@"myTelphone"] forState:normal];
    [callTelephoneBtn addTarget:self action:@selector(callTelephoneClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callTelephoneBtn];
    [callTelephoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(highLevelPhoneL.mas_right).offset(FITiPhone6(21));
        make.centerY.equalTo(highLevelPhoneL.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(16), FITiPhone6(18)));
    }];
}

#pragma mark ---- 打电话 ----
- (void)callTelephoneClick {
    
}

#pragma mark -------------------------------- 接口 ------------------------------------
- (void)loadAgentListRequest {
    LoginManager *manager = [LoginManager getInstance];
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agent/list" params:@{@"userid":IF_NULL_TO_STRING(manager.userInfo.userId)} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    self.vipGradeL.text = [[array firstObject] valueForKey:@"sbLevelVip"];
                    self.receivePosTextL.text = [NSString stringWithFormat:@"已领%@台，还可以领取%@台",[[array firstObject] valueForKey:@"drawCount"] , [[array firstObject] valueForKey:@"totalCount"]];
                    
                    
                    [self loadVipDescAncesRequest];
                }
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}

- (void)loadAgentListAncesRequest {
    LoginManager *manager = [LoginManager getInstance];
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agent/listAnces" params:@{@"userid":IF_NULL_TO_STRING(manager.userInfo.userId)} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                self.highLevelL.text = [NSString stringWithFormat:@"我的上级：%@",[result[@"data"] valueForKey:@"ancesName"]];
                self.highLevelPhoneL.text = [NSString stringWithFormat:@"上级电话：%@",[result[@"data"] valueForKey:@"ancesMp"]];
                    
                }
            }
        
        NSLog(@"result ------- %@", result);
    }];
}


- (void)loadVipDescAncesRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agent/vipDesc" params:@{@"sbLevel":self.vipGradeL.text} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    self.powerContentL.text = [NSString stringWithFormat:@"%@",[result[@"data"] valueForKey:@"des"]];
                    
                
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end

























