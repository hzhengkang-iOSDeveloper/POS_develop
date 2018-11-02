//
//  TerminalSearchViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalSearchViewController.h"
#import "TerminalBindTableViewCell.h"
#import "SureBindViewController.h"
#import "PosGetModel.h"
#import "AgentPosListModel.h"

@interface TerminalSearchViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    UIImageView *searchImgV;
    UITextField *searchTF;
}
@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *listDataArray;


@property (nonatomic, assign) NSUInteger arrC;

@end

@implementation TerminalSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self initUI];
    self.dataArray = [NSMutableArray array];
    self.listDataArray = [NSMutableArray array];
    [self createTableView];
    self.arrC = 0;

}

- (void)createTableView {
    _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, FITiPhone6(46), ScreenWidth, ScreenHeight - TabbarHeight - FITiPhone6(46)) style:UITableViewStylePlain];
    _searchTableView.backgroundColor = WhiteColor;
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    _searchTableView.showsVerticalScrollIndicator = NO;
    _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_searchTableView];
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
    PosGetModel *model = self.dataArray[indexPath.row];
    cell.model = model;
//    cell.productNameL.text = @"付钱宝";
//    cell.viceProductNameL.text = @"小pos机";
//    cell.snL.text = @"SN:3419020300000SA";
//    cell.modelL.text = @"型号：ky21920机器";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    SureBindViewController *vc = [[SureBindViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    SureBindViewController *vc = [[SureBindViewController alloc] init];
    MJWeakSelf;
    vc.popBlock = ^{
        [weakSelf.searchTableView.mj_header beginRefreshing];
    };
    AgentPosListModel *model = self.listDataArray[indexPath.row];
    vc.posID = model.posId;
    vc.agentId = model.agentId;
    vc.posBrandNo = model.posBrandNo;
    vc.posSnNo = model.posSnNo;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(87);
}

- (void)initUI {
    UIImageView *searchImageV = [[UIImageView alloc] init];
    searchImageV.backgroundColor = RGB(238, 238, 238);
    searchImageV.layer.cornerRadius = FITiPhone6(16);
    searchImageV.layer.masksToBounds = YES;
    searchImageV.userInteractionEnabled = YES;
    searchImageV.image = [UIImage imageNamed:@"搜索框"];
    //    UITapGestureRecognizer *searchTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchTap)];
    //    [searchImageV addGestureRecognizer:searchTap];
    [self.view addSubview:searchImageV];
    [searchImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.view).offset(FITiPhone6(13));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(33)));
    }];
    searchImgV = [[UIImageView alloc] init];
    searchImgV.userInteractionEnabled = YES;
    searchImgV.image = [UIImage imageNamed:@"搜索"];
    [searchImageV addSubview:searchImgV];
    [searchImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageV).offset(FITiPhone6(9));
        make.centerY.equalTo(searchImageV.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(16), FITiPhone6(16)));
    }];
    
    searchTF = [[UITextField alloc] init];
    searchTF.delegate = self;
    searchTF.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    [self.view addSubview:searchTF];
    [searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageV).offset(FITiPhone6(9));
        make.top.equalTo(self.view).offset(FITiPhone6(13));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(33)));
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    NSLog(@"点击了搜索");
    
    [searchTF resignFirstResponder];
    
    [self loadAgentPosListRequest];
    
    return YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    searchImgV.hidden = YES;
    return YES;
}

#pragma mark ---- 终端绑定 ----
- (void)loadAgentPosListRequest{

    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agentPos/list" params:@{@"userid":USER_ID_POS, @"agentId":IF_NULL_TO_STRING(self.agentId), @"posSnNo":IF_NULL_TO_STRING(searchTF.text),@"bindFlag":@"0"} cookie:nil result:^(bool success, id result) {
        [self.searchTableView.mj_header endRefreshing];
        if (success) {
            
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        if (self.dataArray.count > 0) {
                            [self.dataArray removeAllObjects];
                        }
                        NSArray *array = [NSArray arrayWithArray:[AgentPosListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]]];
                        
                        self.listDataArray = [array mutableCopy];
                        
                        
                        for (int i =0; i<array.count; i++) {
                            //                        AgentPosListModel *model = [array objectAtIndex:i];
                            [self loadPosGetRequest:[NSString stringWithFormat:@"%@", [[array objectAtIndex:i] valueForKey:@"posId"]] withArr:array];
                        }
                        
                        
                        //                    [self.searchTableView reloadData];
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
#pragma mark ---- 终端绑定get ----
- (void)loadPosGetRequest:(NSString *)posID  withArr:(NSArray *)arr{
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"%@%@", @"api/trans/pos/get/", posID] params:nil cookie:nil result:^(bool success, id result) {
        [self.searchTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                self.arrC ++;
                PosGetModel *poslistModel = [PosGetModel mj_objectWithKeyValues:result[@"data"]];
                [self.dataArray addObject:poslistModel];
                
                if (self.arrC == arr.count) {
                    [self.searchTableView reloadData];
                }
                
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end
