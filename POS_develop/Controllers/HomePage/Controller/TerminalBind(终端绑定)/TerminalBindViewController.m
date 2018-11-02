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
#import "PosGetModel.h"

@interface TerminalBindViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *terminalBindTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *listDataArray;
@property (nonatomic, copy) NSString *agentId;
@property (nonatomic, assign) NSUInteger arrC;
@end

@implementation TerminalBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"终端绑定";
    MJWeakSelf;
    self.dataArray = [NSMutableArray array];
    self.listDataArray = [NSMutableArray array];
    
    [self addRightBarButtonWithImage:[UIImage imageNamed:@"增加"] clickHandler:^{
        NSLog(@"点击右边按钮");
        TerminalSearchViewController *vc = [[TerminalSearchViewController alloc] init];
        vc.agentId = weakSelf.agentId;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self createTableView];
    [self loadAgentListRequest];
    self.arrC = 0;
    
}

- (void)createTableView {
    _terminalBindTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _terminalBindTableView.backgroundColor = WhiteColor;
    _terminalBindTableView.delegate = self;
    _terminalBindTableView.dataSource = self;
    _terminalBindTableView.showsVerticalScrollIndicator = NO;
    _terminalBindTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MJWeakSelf;
    _terminalBindTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadAgentPosListRequest:weakSelf.agentId];
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
    PosGetModel * model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SureBindViewController *vc = [[SureBindViewController alloc] init];
    MJWeakSelf;
    vc.popBlock = ^{
        [weakSelf.terminalBindTableView.mj_header beginRefreshing];
    };
    AgentPosListModel *model = self.listDataArray[indexPath.row];
    vc.posID = model.posId;
    vc.agentId = model.agentId;
    vc.posBrandNo = model.posBrandNo;
    vc.posSnNo = model.posSnNo;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(62);
}



#pragma mark ------------------------------------ 接口 ------------------------------------

#pragma mark ---- 终端绑定 id 获取 ----
- (void)loadAgentListRequest {

    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agent/list" params:@{@"userid":USER_ID_POS} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        self.agentId = IF_NULL_TO_STRING([[result[@"data"][@"rows"] firstObject] objectForKey:@"id"]);
                        [self loadAgentPosListRequest:IF_NULL_TO_STRING([[result[@"data"][@"rows"] firstObject] objectForKey:@"id"])];
                    }
                    
                }
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
#pragma mark ---- 终端绑定 ----
- (void)loadAgentPosListRequest:(NSString *)agentId {

    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agentPos/list" params:@{@"userid":USER_ID_POS, @"agentId":IF_NULL_TO_STRING(agentId), @"bindFlag":@"0"} cookie:nil result:^(bool success, id result) {
        [self.terminalBindTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = [NSArray arrayWithArray:[AgentPosListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]]];
                    self.listDataArray = [array mutableCopy];
                    if (self.dataArray.count > 0) {
                        [self.dataArray removeAllObjects];
                    }
                    
                    for (int i =0; i<array.count; i++) {
                        AgentPosListModel *model = [array objectAtIndex:i];
                        [self loadPosGetRequest:[NSString stringWithFormat:@"%@", model.posId] withArr:array];
                    }
                    
                }
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}

#pragma mark ---- 终端绑定get ----
- (void)loadPosGetRequest:(NSString *)posID  withArr:(NSArray *)arr{
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"%@%@", @"api/trans/pos/get/", posID] params:nil cookie:nil result:^(bool success, id result) {
        [self.terminalBindTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                self.arrC ++;
                PosGetModel *poslistModel = [PosGetModel mj_objectWithKeyValues:result[@"data"]];
                [self.dataArray addObject:poslistModel];
                
                if (self.arrC == arr.count) {
                    [self.terminalBindTableView reloadData];
                }

                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end




















