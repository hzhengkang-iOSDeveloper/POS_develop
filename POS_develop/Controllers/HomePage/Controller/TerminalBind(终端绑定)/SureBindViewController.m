//
//  SureBindViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "SureBindViewController.h"

@interface SureBindViewController ()
@property (nonatomic, strong) UILabel *productNameL;
@property (nonatomic, strong) UILabel *viceProductNameL;
@property (nonatomic, strong) UILabel *snL;
@property (nonatomic, strong) UILabel *modelL;

//确认绑定
@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation SureBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"确认绑定";
    [self initUI];
    [self loadPosGetRequest];
}
- (void)initUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = WhiteColor;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(62)));
    }];
    self.productNameL = [[UILabel alloc] init];
    self.productNameL.textColor = C000000;
    self.productNameL.font = F13;
    //    self.productNameL.adjustsFontSizeToFitWidth = YES;
    [bgView addSubview:self.productNameL];
    [self.productNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(FITiPhone6(15));
        make.top.equalTo(bgView).offset(FITiPhone6(14));
        //        make.height.mas_equalTo(FITiPhone6(13));
    }];
    self.viceProductNameL = [[UILabel alloc] init];
    self.viceProductNameL.textColor = C989898;
    self.viceProductNameL.font = F9;
    //    self.viceProductNameL.adjustsFontSizeToFitWidth = YES;
    [bgView addSubview:self.viceProductNameL];
    [self.viceProductNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productNameL.mas_right).offset(FITiPhone6(5));
        make.bottom.equalTo(self.productNameL.mas_bottom);
        //        make.height.mas_equalTo(FITiPhone6(11));
    }];
    self.snL = [[UILabel alloc] init];
    self.snL.textColor = C000000;
    self.snL.font = F12;
    //    self.snL.adjustsFontSizeToFitWidth = YES;
    [bgView addSubview:self.snL];
    [self.snL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(FITiPhone6(15));
        make.bottom.equalTo(bgView).offset(FITiPhone6(-14));
        //        make.height.mas_equalTo(FITiPhone6(11));
    }];
    self.modelL = [[UILabel alloc] init];
    self.modelL.textColor = C000000;
    self.modelL.font = F12;
    //    self.modelL.adjustsFontSizeToFitWidth = YES;
    [bgView addSubview:self.modelL];
    [self.modelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(FITiPhone6(-15));
        make.bottom.equalTo(self.productNameL.mas_bottom);
        //        make.height.mas_equalTo(FITiPhone6(14));
    }];
    
   
    
    
    UIButton *sureBtn = [UIButton getButtonWithImageName:@"" titleText:@"确认绑定" superView:self.view masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.offset(FITiPhone6(15));
        make.top.equalTo(bgView.mas_bottom).offset(FITiPhone6(23));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(46)));
        
        [btn setTitleColor:WhiteColor forState:normal];
        btn.titleLabel.font = F15;
        [btn setBackgroundColor:C1E95F9];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.f;
        [btn addTarget:self action:@selector(clickComfirBindBtn) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    self.sureBtn = sureBtn;
}
#pragma mark ---- 确认绑定 ----
- (void)clickComfirBindBtn {
    LoginManager *manager = [LoginManager getInstance];

    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agentPos/save" params:@{@"userid":USER_ID_POS, @"agentId":self.agentId, @"posId":self.posID, @"posBrandNo":self.posBrandNo, @"posSnNo":self.posSnNo, @"bindFlag":@"1"} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                HUD_TIP(@"绑定成功");
                if (self.popBlock) {
                    self.popBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
#pragma mark ---- 终端绑定get ----
- (void)loadPosGetRequest {
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"%@%@", @"api/trans/pos/get/", self.posID] params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                self.productNameL.text = [result[@"data"] objectForKey:@"posBrandName"];
                self.viceProductNameL.text = [result[@"data"] objectForKey:@"posTermType"];
                self.snL.text = [NSString stringWithFormat:@"SN:%@", [result[@"data"] objectForKey:@"posSnNo"]];
                self.modelL.text = [NSString stringWithFormat:@"型号:%@", [result[@"data"] objectForKey:@"posTermModel"]];
                
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}












@end
