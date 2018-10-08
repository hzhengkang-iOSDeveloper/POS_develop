//
//  TerminalSelectResultViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/7.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalSelectResultViewController.h"
#import "TerminalBindTableViewCell.h"

@interface TerminalSelectResultViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *terminalResultTableView;

@end

@implementation TerminalSelectResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"终端查询";
    [self createTableView];
}


- (void)createTableView {
    _terminalResultTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _terminalResultTableView.backgroundColor = CF6F6F6;
    _terminalResultTableView.delegate = self;
    _terminalResultTableView.dataSource = self;
    _terminalResultTableView.showsVerticalScrollIndicator = NO;
    _terminalResultTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_terminalResultTableView];
    [_terminalResultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
        
    }];
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
    
    cell.bindStateL.hidden = NO;
    cell.bindStateL.text = @"未绑定";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
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
