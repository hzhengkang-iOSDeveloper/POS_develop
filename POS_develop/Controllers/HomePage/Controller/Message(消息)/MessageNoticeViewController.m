//
//  MessageNoticeViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/8.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MessageNoticeViewController.h"
#import "MessageNoticeTableViewCell.h"
#import "MessageListViewController.h"
#import "MessageCategoryListModel.h"

@interface MessageNoticeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MessageNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"消息通知";
    self.dataArray = [NSMutableArray array];
    [self createTableView];
    
    [self loadMessageCategoreRequest];
}
- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.backgroundColor = WhiteColor;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MJWeakSelf;
    _myTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadMessageCategoreRequest];
    }];
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    MessageNoticeTableViewCell *cell = [MessageNoticeTableViewCell cellWithTableView:tableView];
    MessageCategoryListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.backgroundColor = CF6F6F6;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    MessageNoticeTableViewCell *cell = (MessageNoticeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    MessageCategoryListModel *model = self.dataArray[indexPath.row];
    MessageListViewController *vc = [[MessageListViewController alloc] init];
    vc.tbMsgCateId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(60);
}



#pragma mark ---- 接口 ----
-(void)loadMessageCategoreRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/messageCategory/list" params:nil cookie:nil result:^(bool success, id result) {
        [self.myTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    [self.dataArray addObjectsFromArray:[MessageCategoryListModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    [self.myTableView reloadData];
                }
                
            }
           
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end
