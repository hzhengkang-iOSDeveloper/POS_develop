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
    updateBtn.backgroundColor = RGB(210, 210, 210);
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
                showToast(@"请输入正确的手机号");
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
    //MARK: 接口获取短信验证码
    //    [[HPDConnect connect] ansySoapUintMethod:@"SendMessage_NoLogin" params:@{@"Mobile_Phone" :[self.telephoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@"" ], @"SmsType" : @(0)} cookie:[[LoginManager getInstance] userCookie] result:^(bool success, NSDictionary *result) {
    //        [self.codeTimeBtn setTitle:@"重发" forState:UIControlStateNormal];
    //        if (success) {
    //            if ([[result valueForKeyPath:kSoapResponseStatu] intValue] == 1) {
    self.timeSum = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange:) userInfo:nil repeats:YES];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UpdatePasswordTableViewCell *cell = [self.updatePasswordTableView cellForRowAtIndexPath:indexPath];
    cell.getCodeBtn.userInteractionEnabled = NO;
    //            }else {
    //                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
    //
    //                }];
    //            }
    //        }
    //    }];
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


@end
