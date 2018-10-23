//
//  DelegateManagerViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/4.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "DelegateManagerViewController.h"
#import "DelegateManagerMainView.h"
#import "DelegateManagerResultViewController.h"




@interface DelegateManagerViewController () 
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) DelegateManagerMainView *mainView;
@end

@implementation DelegateManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"代理商管理";
    
    [self initUI];
}

- (void)initUI {
    
    _mainView = [[[NSBundle mainBundle] loadNibNamed:@"DelegateManagerMainView" owner:self options:nil] lastObject];
    [self.view addSubview:_mainView];
//    _mainView.nameTF.delegate = self;
//    _mainView.platformAccountTF.delegate = self;
    [_mainView.nameTF addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [_mainView.platformAccountTF addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, 152));
    }];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.userInteractionEnabled = NO;
    self.selectBtn.backgroundColor = RGB(210, 210, 210);
    [self.selectBtn setTitle:@"查询" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.selectBtn.layer.cornerRadius = FITiPhone6(3);
    self.selectBtn.layer.masksToBounds = YES;
    [self.selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.mainView.mas_bottom).offset(FITiPhone6(109));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(45)));
    }];
}


- (void)textFieldEditChanged:(UITextField *)textField

{
    if (_mainView.nameTF.text.length > 0 && _mainView.platformAccountTF.text.length > 0) {
        self.selectBtn.userInteractionEnabled = YES;
        self.selectBtn.backgroundColor = C1E95F9;
    }else {
        self.selectBtn.userInteractionEnabled = NO;
        self.selectBtn.backgroundColor = RGB(210, 210, 210);
    }
    NSLog(@"textfield.text %@",textField.text);
    
    
    
}
- (void)selectClick {
    DelegateManagerResultViewController *vc = [[DelegateManagerResultViewController alloc] init];
    vc.agentName = _mainView.nameTF.text;
    vc.agentNo = _mainView.platformAccountTF.text;
    [self.navigationController pushViewController:vc animated:YES];
}

@end












