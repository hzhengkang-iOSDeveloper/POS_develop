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
#import "AgentListModel.h"

@interface TerminalAdminViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *terminalAdminTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UIButton *selectBtn;
@property (nonatomic, copy) NSString *selectStr;
@end

@implementation TerminalAdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"终端管理";
    self.dataArray = [NSMutableArray array];
    self.selectStr = @"";
    [self initUI];
    [self createTableView];
    [self loadAgentListRequest];
}
- (void)initUI {
    self.view.backgroundColor = WhiteColor;
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.backgroundColor = CC9C9C9;
    selectBtn.userInteractionEnabled = NO;
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
    _terminalAdminTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _terminalAdminTableView.backgroundColor = WhiteColor;
    _terminalAdminTableView.delegate = self;
    _terminalAdminTableView.dataSource = self;
    _terminalAdminTableView.showsVerticalScrollIndicator = NO;
    _terminalAdminTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _terminalAdminTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadAgentListRequest];
    }];
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
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TerminalAdminTableViewCell *cell = [TerminalAdminTableViewCell cellWithTableView:tableView];
    AgentListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
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
    if ([self.selectStr isEqualToString:@""]) {
        _selectBtn.backgroundColor = CC9C9C9;
        _selectBtn.userInteractionEnabled = NO;
    }else {
        _selectBtn.backgroundColor = C1E95F9;
        _selectBtn.userInteractionEnabled = YES;
    }
    [tableView reloadData];
//    SureBindViewController *vc = [[SureBindViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(59);
}


#pragma mark ------------------------------------ 接口 ------------------------------------
#pragma mark ---- 终端绑定查询 ----
- (void)loadAgentListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agent/list" params:@{@"userid":USER_ID_POS,@"needDes":@"1"} cookie:nil result:^(bool success, id result) {
        [self.terminalAdminTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        NSArray *array = result[@"data"][@"rows"];
                        if (self.dataArray.count > 0 ) {
                            [self.dataArray removeAllObjects];
                        }
                        [self.dataArray addObjectsFromArray:[AgentListModel mj_objectArrayWithKeyValuesArray:array]];
                        
                        [self.terminalAdminTableView reloadData];
                        
                        
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
@end

























