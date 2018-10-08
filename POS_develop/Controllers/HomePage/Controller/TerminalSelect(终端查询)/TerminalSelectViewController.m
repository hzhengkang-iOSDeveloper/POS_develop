//
//  TerminalSelectViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalSelectViewController.h"
#import "TerminalSelectMainView.h"
#import "TerminalSelectResultViewController.h"

@interface TerminalSelectViewController ()
@property (nonatomic, strong) UIButton *selectBtn;
@end

@implementation TerminalSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"终端查询";
    self.view.backgroundColor = CF6F6F6;
    [self initUI];
}


- (void)initUI {
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-navH)];
    mainScrollView.backgroundColor = CF6F6F6;
    [self.view addSubview:mainScrollView];
    
    
    TerminalSelectMainView *mainView = [[[NSBundle mainBundle] loadNibNamed:@"TerminalSelectMainView" owner:self options:nil] lastObject];
    __weak typeof(mainView) wkmainView = mainView;
    mainView.brandBlock = ^(NSString * _Nonnull selectedStr) {//机器品牌
        wkmainView.brandNameLabel.text = selectedStr;
    };
    mainView.typeBlock = ^(NSString * _Nonnull selectedStr){//机器类型
        wkmainView.typeNameLabel.text = selectedStr;
    };
    mainView.modelBlock = ^(NSString * _Nonnull selectedStr){//机器型号
        wkmainView.modelNameLabel.text = selectedStr;
    };
    mainView.isActivationBlock = ^(NSString * _Nonnull selectedStr){//是否激活
        wkmainView.isActivationNameLabel.text = selectedStr;
    };
    mainView.frame = CGRectMake(0, 0, ScreenWidth, 520);
    mainView.backgroundColor = WhiteColor;
    [mainScrollView addSubview:mainView];
//    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.offset(0);
//        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(520)));
////        make.width.mas_equalTo(ScreenWidth);
//    }];
    
//    UIButton *selectBtn = [UIButton getButtonWithImageName:@"" titleText:@"查询" superView:mainScrollView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
//        make.left.offset(FITiPhone6(15));
//        make.top.equalTo(mainView.mas_bottom).offset(FITiPhone6(23));
//        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(46)));
//
//        [btn setTitleColor:WhiteColor forState:normal];
//        btn.titleLabel.font = F15;
//        [btn setBackgroundColor:C1E95F9];
//        btn.layer.masksToBounds = YES;
//        btn.layer.cornerRadius = 3.f;
//        [btn addTarget:self action:@selector(clickSelectBtn) forControlEvents:UIControlEventTouchUpInside];
//    }];
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(AD_HEIGHT(15), CGRectGetMaxY(mainView.frame)+AD_HEIGHT(23), ScreenWidth-AD_HEIGHT(30), AD_HEIGHT(46));
    [selectBtn setTitle:@"查询" forState:normal];
    [selectBtn setTitleColor:WhiteColor forState:normal];
    selectBtn.titleLabel.font = F15;
    [selectBtn setBackgroundColor:C1E95F9];
    selectBtn.layer.masksToBounds = YES;
    selectBtn.layer.cornerRadius = 3.f;
    [selectBtn addTarget:self action:@selector(clickSelectBtn) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:selectBtn];
    self.selectBtn = selectBtn;
    
    mainScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(self.selectBtn.frame)+AD_HEIGHT(20));
}

#pragma mark ---- 查询 ----
- (void)clickSelectBtn {
    TerminalSelectResultViewController *vc = [[TerminalSelectResultViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
