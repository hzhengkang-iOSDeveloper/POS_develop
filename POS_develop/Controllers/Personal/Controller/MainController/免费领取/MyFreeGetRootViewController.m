//
//  MyFreeGetRootViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/23.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "MyFreeGetRootViewController.h"
#import "MyFreeGetCell.h"
@interface MyFreeGetRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *myTable;

//最大领取view
@property (nonatomic, weak) UIButton *maxGetBtn;
//确认领取View
@property (nonatomic, weak) UIButton *comfirBtn;
@end

@implementation MyFreeGetRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CF6F6F6;
    [self creatBottomView];
    [self creatTableView];
    
}

#pragma mark ---- Table ----
- (void)creatTableView
{
    UITableView *myTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTable.delegate = self;
    myTable.dataSource = self;
    [self.view addSubview:myTable];
    self.myTable = myTable;
    myTable.separatorStyle = NO;
    
//    MJWeakSelf;
    myTable.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        //        weakSelf.orderArr = nil;
        //        weakSelf.orderArr = [NSMutableArray array];
        //        weakSelf.orderModelArr = nil;
        //        weakSelf.orderModelArr = [NSMutableArray array];
        //        weakSelf.loadDataIndex = 1;
        //
        //        [weakSelf loadDataWithStatus:self.status];
    }];
    [_myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AD_HEIGHT(5));
        make.left.offset(0);
        make.bottom.equalTo(self.comfirBtn.mas_top);
        make.width.mas_equalTo(ScreenWidth);
    }];
}

#pragma mark ---- bottomView ----
- (void)creatBottomView
{
    UIButton *maxGetBtn = [UIButton getButtonWithImageName:@"" titleText:@"(已达到最大领取数量)" superView:self.view masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.offset(-(ScreenWidth/2));
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth/2, AD_HEIGHT(49)));
        
        btn.titleLabel.font = F13;
        [btn setTitleColor:WhiteColor forState:normal];
        [btn setBackgroundColor:RGB(239, 0, 51)];
    }];
    self.maxGetBtn = maxGetBtn;
    MJWeakSelf;
    
    UIButton *comfirBtn = [UIButton getButtonWithImageName:@"" titleText:@"确认领取（1）" superView:self.view masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.equalTo(weakSelf.maxGetBtn.mas_right);
        make.right.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
        make.height.mas_offset(AD_HEIGHT(49));
        
        btn.titleLabel.font = F13;
        [btn setTitleColor:WhiteColor forState:normal];
        [btn setBackgroundColor:C1E95F9];

    }];
    self.comfirBtn = comfirBtn;
}
#pragma mark ---- 停止刷新 ----
- (void)endRefresh
{
    //    [self.myTable.mj_footer endRefreshing];
    //    [self.myTable.mj_header endRefreshing];
    [self.myTable.mj_footer endRefreshingWithNoMoreData];
}
#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyFreeGetCell *cell = [MyFreeGetCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MJWeakSelf;
    cell.clickMaxCountHandler = ^(BOOL isMax) {
        if (isMax) {
            [UIView animateWithDuration:2 animations:^{
                [weakSelf.maxGetBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(0);
                }];
            }];
        } else {
            [UIView animateWithDuration:2 animations:^{
                [weakSelf.maxGetBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(-(ScreenWidth/2));
                }];
            }];
        }
    };
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(112);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

@end
