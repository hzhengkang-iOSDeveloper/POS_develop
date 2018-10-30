//
//  UpdatePasswordViewController.m
//  POS_develop
//
//  Created by syn on 2018/9/15.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "UpdatePasswordViewController.h"
#import "UpdatePasswordTableViewCell.h"

@interface UpdatePasswordViewController () <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *updatePasswordTableView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeSum;
@end

@implementation UpdatePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"修改密码";
    [self createTableView];
    [self createUpdateBtn];
}
- (void)createTableView {
    _updatePasswordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FITiPhone6(200)) style:UITableViewStylePlain];
    _updatePasswordTableView.backgroundColor = WhiteColor;
    _updatePasswordTableView.delegate = self;
    _updatePasswordTableView.dataSource = self;
    _updatePasswordTableView.showsVerticalScrollIndicator = NO;
    _updatePasswordTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_updatePasswordTableView];
}
- (void)createUpdateBtn {
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updateBtn.backgroundColor = C1E95F9;
    updateBtn.frame = CGRectMake(FITiPhone6(15), FITiPhone6(261), ScreenWidth - FITiPhone6(30), FITiPhone6(46));
    [updateBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    updateBtn.titleLabel.font = F13;
    [updateBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(UpdateClick) forControlEvents:UIControlEventTouchUpInside];
    updateBtn.layer.cornerRadius = FITiPhone6(3);
    updateBtn.layer.masksToBounds = YES;
    [self.view addSubview:updateBtn];
}
#pragma mark ---- 确认修改 ----
- (void)UpdateClick {
    [self loadChangepasswordRequest];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UpdatePasswordTableViewCell *cell = [UpdatePasswordTableViewCell cellWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.lineView.hidden = NO;
        cell.getCodeBtn.hidden = NO;
    }else {
        if (indexPath.row == 2 || indexPath.row == 3) {
            cell.contentTF.secureTextEntry = YES;
        }
        cell.lineView.hidden = YES;
        cell.getCodeBtn.hidden = YES;
    }
    NSArray *titleArray = @[@"手机号", @"验证码", @"输入密码", @"确认密码"];
    NSArray *contentArray = @[@"请输入手机号", @"请输入验证码", @"请输入8~16位密码", @"请再次输入密码"];
    cell.titleLabel.text = titleArray[indexPath.row];
    cell.contentTF.placeholder = contentArray[indexPath.row];
    [cell.contentTF addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    __weak typeof(cell) weakCell = cell;
    cell.getCodeBlock = ^{
        if (indexPath.row == 0) {
            if (![[weakCell.contentTF textContainsNoCharset] isPhoneNumberFormat]) {
                [weakCell.contentTF becomeFirstResponder];
                return;
            }else {
                [self getCode];
            }
        }
        
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

-(void)textField1TextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);

}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(50);
}
#pragma mark ---- 获取验证码 ----
- (void)getCode {
    [self.view endEditing:YES];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UpdatePasswordTableViewCell *phoneCell =(UpdatePasswordTableViewCell *)[self.updatePasswordTableView cellForRowAtIndexPath:indexPath];

    //MARK: 接口获取短信验证码
    
    [[HPDConnect connect] GetNetRequestMethod:[NSString stringWithFormat:@"changepassword/getsmscode?mobile=%@", phoneCell.contentTF.text] params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"msg"] isEqualToString:@"操作成功"]) {
                self.timeSum = 60;
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange:) userInfo:nil repeats:YES];
                phoneCell.getCodeBtn.userInteractionEnabled = NO;
            }else{
                HUD_TIP(result[@"msg"]);
            }
            
        }
    }];

  
}
-(void)timerChange:(NSTimer*)timer
{
    self.timeSum-=1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UpdatePasswordTableViewCell *cell = [self.updatePasswordTableView cellForRowAtIndexPath:indexPath];
    [cell.getCodeBtn setTitle:[NSString stringWithFormat:@"(%dS)",self.timeSum] forState:0];
    if (self.timeSum<=0) {
        [timer invalidate];
        [cell.getCodeBtn setTitle:@"重发" forState:UIControlStateNormal];
        cell.getCodeBtn.userInteractionEnabled = YES;
        
    }
}

- (void)loadChangepasswordRequest {
    LoginManager *manager = [LoginManager getInstance];
    [[HPDConnect connect]PostOtherNetRequestMethod:@"changepassword" params:@{@"newPwd":@"", @"smsCode":@"", @"userid":IF_NULL_TO_STRING(manager.userInfo.userId)} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"msg"] isEqualToString:@"操作成功"]) {
                HUD_TIP(@"修改成功，请重新登录！");
                //做退出登录操作
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else {
                HUD_TIP(result[@"msg"]);
            }
        }
    }];
}
@end
