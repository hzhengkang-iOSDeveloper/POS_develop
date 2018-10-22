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
#import "AgentPosListModel.h"

@interface TerminalBindViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *terminalBindTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSString *agentId;
@end

@implementation TerminalBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"终端绑定";
    MJWeakSelf;
    self.dataArray = [NSMutableArray array];
    
    [self addRightBarButtonWithImage:[UIImage imageNamed:@"增加"] clickHandler:^{
        NSLog(@"点击右边按钮");
        TerminalSearchViewController *vc = [[TerminalSearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self createTableView];
    [self loadAgentListRequest];
    
}

- (void)createTableView {
    _terminalBindTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _terminalBindTableView.backgroundColor = WhiteColor;
    _terminalBindTableView.delegate = self;
    _terminalBindTableView.dataSource = self;
    _terminalBindTableView.showsVerticalScrollIndicator = NO;
    _terminalBindTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    MJWeakSelf;
    _terminalBindTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadAgentPosListRequest:self.agentId];
    }];
    [self.view addSubview:_terminalBindTableView];
    [_terminalBindTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

 #pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TerminalBindTableViewCell *cell = [TerminalBindTableViewCell cellWithTableView:tableView];
    AgentPosListModel * model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
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



#pragma mark ------------------------------------ 接口 ------------------------------------

#pragma mark ---- 终端绑定 id 获取 ----
- (void)loadAgentListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agent/list" params:@{@"userid":@"1"} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    self.agentId = [[result[@"data"][@"rows"] firstObject] objectForKey:@"id"];
                    [self loadAgentPosListRequest:[[result[@"data"][@"rows"] firstObject] objectForKey:@"id"]];
                }
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
#pragma mark ---- 终端绑定 ----
- (void)loadAgentPosListRequest:(NSString *)agentId {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agentPos/list" params:@{@"userid":@"1", @"agentId":agentId, @"bindFlag":@"0"} cookie:nil result:^(bool success, id result) {
        [self.terminalBindTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    if (self.dataArray.count > 0) {
                        [self.dataArray removeAllObjects];
                    }
                    [self.dataArray addObjectsFromArray:[AgentPosListModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    [self.terminalBindTableView reloadData];
                    
                }
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end




















