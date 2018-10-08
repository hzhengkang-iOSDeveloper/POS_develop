//
//  TerminalAdminViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/2.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalAdminViewController.h"
#import "TerminalAdminTableViewCell.h"
#import "TerminalDistributionViewController.h"

@interface TerminalAdminViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *terminalAdminTableView;
@property (nonatomic, weak) UIButton *selectBtn;
@property (nonatomic, copy) NSString *selectStr;
@end

@implementation TerminalAdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"终端管理";
    self.selectStr = @"";
    [self initUI];
    [self createTableView];
}
- (void)initUI {
    self.view.backgroundColor = WhiteColor;
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.backgroundColor = C1E95F9;
    [selectBtn setTitle:@"选择" forState:UIControlStateNormal];
    [selectBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    selectBtn.layer.cornerRadius = FITiPhone6(3);
    selectBtn.layer.masksToBounds = YES;
    [selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    self.selectBtn = selectBtn;
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(-FITiPhone6(11));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(46)));
    }];
}
- (void)createTableView {
    MJWeakSelf;
    _terminalAdminTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight - FITiPhone6(68)) style:UITableViewStylePlain];
    _terminalAdminTableView.backgroundColor = WhiteColor;
    _terminalAdminTableView.delegate = self;
    _terminalAdminTableView.dataSource = self;
    _terminalAdminTableView.showsVerticalScrollIndicator = NO;
    _terminalAdminTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_terminalAdminTableView];
    [_terminalAdminTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.right.offset(0);
        make.bottom.equalTo(weakSelf.selectBtn.mas_top).offset(-AD_HEIGHT(15));
    }];
}

#pragma mark ---- 选择 ----
- (void)selectClick {
    TerminalDistributionViewController *vc = [[TerminalDistributionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TerminalAdminTableViewCell *cell = [TerminalAdminTableViewCell cellWithTableView:tableView];
    cell.delegateAccount.text = @"代理商账号：sy70022";
    cell.delegateName.text = @"代理商名称：胡子";
//    MJWeakSelf;
//    cell.clickSelectBtnHandler = ^{
//
//    };
    
    if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
        cell.selectBtn.selected = YES;
    } else {
        cell.selectBtn.selected = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TerminalAdminTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectBtn.selected = !cell.selectBtn.selected;
    if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
        self.selectStr = @"";
    } else {
        self.selectStr = [NSString stringWithFormat:@"%li",indexPath.row];
    }
    
    [tableView reloadData];
//    SureBindViewController *vc = [[SureBindViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(59);
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
