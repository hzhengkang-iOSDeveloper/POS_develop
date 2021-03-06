//
//  MessageListViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/8.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageListTableViewCell.h"
#import "SelectDetailBrandViewController.h"
#import "MessageListModel.h"
@interface MessageListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"消息列表";
    self.dataArray = [NSMutableArray array];
    [self createTableView];
    [self loadMessageListRequest];
}

- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.backgroundColor = CF6F6F6;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    MessageListTableViewCell *cell = [MessageListTableViewCell cellWithTableView:tableView];
    MessageListModel *model = self.dataArray[indexPath.row];
    cell.timeLabel.text = [model.createtime substringToIndex:10];
    cell.titleLabel.text = model.msgTitle;
    cell.contentLabel.text = model.msgContent;
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.msgIconUrl]];
//    [cell.iconImageView sd_setImageWithURL:model.msgIconUrl placeholderImage:[UIImage imageNamed:@"default"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageListModel *model = self.dataArray[indexPath.row];
    SelectDetailBrandViewController *vc = [[SelectDetailBrandViewController alloc] init];
//    vc.titleStr = cell.titleLabel.text;
//    vc.contentStr = cell.contentLabel.text;
//    vc.timeStr = cell.timeLabel.text;
    vc.myId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(88+32);
}


#pragma mark ---- 接口 ----
-(void)loadMessageListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/message/list" params:@{@"tbMsgCateId":self.tbMsgCateId} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        NSArray *array = result[@"data"][@"rows"];
                        if (array.count > 0) {
                            [self.dataArray addObjectsFromArray:[MessageListModel mj_objectArrayWithKeyValuesArray:array]];
                            
                            [self.myTableView reloadData];
                        }
                        
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
