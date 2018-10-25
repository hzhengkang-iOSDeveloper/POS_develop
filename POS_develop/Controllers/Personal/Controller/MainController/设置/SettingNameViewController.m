//
//  SettingNameViewController.m
//  POS_develop
//
//  Created by syn on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SettingNameViewController.h"

@interface SettingNameViewController ()
@property (nonatomic, strong) UITextField *nameTF;
@end

@implementation SettingNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"设置名字";
    UIButton * rightBtn = [self addStandardRightButtonWithTitle:@"完成" selector:@selector(completeClick)];
    rightBtn.titleLabel.font = F13;
    [self initUI];
                          
}

- (void)initUI {
    self.nameTF = [[UITextField alloc] init];
    self.nameTF.textColor = C000000;
    self.nameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(5), 0)];
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    self.nameTF.placeholder = @"请输入名称";
    [self.nameTF setValue:C989898
                  forKeyPath:@"_placeholderLabel.textColor"];
    [self.nameTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    self.nameTF.borderStyle = UITextBorderStyleNone;
    self.nameTF.font = F13;
    self.nameTF.layer.cornerRadius = FITiPhone6(5);
    self.nameTF.layer.masksToBounds = YES;
    [self.view addSubview:_nameTF];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, FITiPhone6(46)));
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = CE6E2E2;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.nameTF.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(15), FITiPhone6(1)));
    }];
}
#pragma mark ---- 完成 ----
- (void)completeClick {
    [[HPDConnect connect] PostNetRequestMethod:@"sys/user/updateNickname" params:@{@"newName":self.nameTF.text} cookie:nil result:^(bool success, id result) {
        if (success) {
            HUD_TIP(@"设置成功");
            if (self.popBlock) {
                self.popBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
