//
//  UpdatePhoneViewController.m
//  POS_develop
//
//  Created by syn on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "UpdatePhoneViewController.h"
#import "UpdatePhoneTableViewCell.h"

@interface UpdatePhoneViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *updatePhoneTableView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeSum;

@end

@implementation UpdatePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"修改手机号";
    [self createTableView];
    [self createUpdateBtn];
}
- (void)createTableView {
    _updatePhoneTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FITiPhone6(150)) style:UITableViewStylePlain];
    _updatePhoneTableView.backgroundColor = WhiteColor;
    _updatePhoneTableView.delegate = self;
    _updatePhoneTableView.dataSource = self;
    _updatePhoneTableView.showsVerticalScrollIndicator = NO;
    _updatePhoneTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_updatePhoneTableView];
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
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UpdatePhoneTableViewCell *cell = [UpdatePhoneTableViewCell cellWithTableView:tableView];
    if (indexPath.row == 1) {
        cell.lineView.hidden = NO;
        cell.getCodeBtn.hidden = NO;
    }else {
        cell.lineView.hidden = YES;
        cell.getCodeBtn.hidden = YES;
    }
    NSArray *titleArray = @[@"原手机号", @"新手机号", @"验证码"];
    NSArray *contentArray = @[@"请输入原手机号", @"请输入新手机号", @"请输入验证码"];
    cell.titleLabel.text = titleArray[indexPath.row];
    cell.contentTF.placeholder = contentArray[indexPath.row];
    __weak typeof(cell) weakCell = cell;
    cell.getCodeBlock = ^{
        if (indexPath.row == 1) {
            if (![[weakCell.contentTF textContainsNoCharset] isPhoneNumberFormat]) {
                [weakCell.contentTF becomeFirstResponder];
                HUD_TIP(@"请输入正确的手机号");
                return;
            }else {
                [self getCode];
            }
        }
        
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
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
    UpdatePhoneTableViewCell *cell = [self.updatePhoneTableView cellForRowAtIndexPath:indexPath];
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
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    UpdatePhoneTableViewCell *cell = [self.updatePhoneTableView cellForRowAtIndexPath:indexPath];
    [cell.getCodeBtn setTitle:[NSString stringWithFormat:@"(%dS)",self.timeSum] forState:0];
    if (self.timeSum<=0) {
        [timer invalidate];
        [cell.getCodeBtn setTitle:@"重发" forState:UIControlStateNormal];
        cell.getCodeBtn.userInteractionEnabled = YES;
        
    }
}

@end
