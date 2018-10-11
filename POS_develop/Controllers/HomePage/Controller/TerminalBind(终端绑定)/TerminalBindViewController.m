//
//  TerminalBindViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalBindViewController.h"
#import "TerminalBindTableViewCell.h"
#import "TerminalSearchViewController.h"
#import "SureBindViewController.h"

@interface TerminalBindViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *terminalBindTableView;
@end

@implementation TerminalBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"终端绑定";
    MJWeakSelf;
    [self addRightBarButtonWithImage:[UIImage imageNamed:@"增加"] clickHandler:^{
        NSLog(@"点击右边按钮");
        TerminalSearchViewController *vc = [[TerminalSearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self createTableView];
}

- (void)createTableView {
    _terminalBindTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight) style:UITableViewStylePlain];
    _terminalBindTableView.backgroundColor = WhiteColor;
    _terminalBindTableView.delegate = self;
    _terminalBindTableView.dataSource = self;
    _terminalBindTableView.showsVerticalScrollIndicator = NO;
    _terminalBindTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_terminalBindTableView];
}

 #pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TerminalBindTableViewCell *cell = [TerminalBindTableViewCell cellWithTableView:tableView];
    cell.productNameL.text = @"付钱宝";
    cell.viceProductNameL.text = @"小pos机";
    cell.snL.text = @"SN:3419020300000SA";
    cell.modelL.text = @"型号：ky21920机器";
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SureBindViewController *vc = [[SureBindViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(62);
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
