//
//  CombinationSetMealViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/17.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "CombinationSetMealViewController.h"
#import "SetMealOrderCell.h"
#import "CombinationSetMealDetailViewController.h"//套餐详情
@interface CombinationSetMealViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *myTable;

@end

@implementation CombinationSetMealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self confir];
    [self creatTableView];
    
}

- (void)confir
{
    self.view.backgroundColor = CF6F6F6;
    [self addStandardRightButtonWithTitle:@"购物车" selector:@selector(goShopCar)];
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
    
    myTable.mj_footer = [SLRefreshFooter footerWithRefreshingBlock:^{
//        [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2];
        //        weakSelf.loadDataIndex += 1;
        //
        //        if (weakSelf.count%10 >0) {
        //            if (weakSelf.loadDataIndex <= weakSelf.count/10 + 1) {
        //
        //                [weakSelf loadDataWithStatus:weakSelf.status];
        //            }else{
        //
        //                [orderTableView.mj_footer endRefreshingWithNoMoreData];
        //            }
        //        }else{
        //
        //            if (weakSelf.loadDataIndex <= weakSelf.count/10) {
        //
        //                [weakSelf loadDataWithStatus:weakSelf.status];
        //            }else{
        //                [orderTableView.mj_footer endRefreshingWithNoMoreData];
        //            }
        //        }
    }];
    [_myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
        make.width.mas_equalTo(ScreenWidth);
    }];
}
#pragma mark ---- 购物车 ----
- (void)goShopCar
{
    
}

#pragma mark ---- header ----
- (UIView *)creatSectionHeaderView
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = WhiteColor;
    
    UIImageView *img = [[UIImageView alloc]init];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = ImageNamed(@"WechatIMG48-1");
    [headerView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(-AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(5));
        make.height.mas_equalTo(AD_HEIGHT(131));
    }];
    
    [UILabel getLabelWithFont:F15 textColor:WhiteColor superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(img.mas_left).offset(AD_HEIGHT(8));
        make.top.equalTo(img.mas_top).offset(AD_HEIGHT(12));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"双喜临门套餐";
    }];
    
    return headerView;
}
#pragma mark ---- footer ----
- (UIView *)creatSectionFooterView
{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = CF6F6F6;
    
    UIView *mainView = [UIView getViewWithColor:WhiteColor superView:footerView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(50));
    }];
    
    
    UILabel *realPriceLabel = [UILabel getLabelWithFont:F13 textColor:CF52542 superView:mainView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"￥800";
    }];
    
    UILabel *orignPriceLabel = [UILabel getLabelWithFont:F12 textColor:C989898 superView:mainView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(realPriceLabel.mas_right).offset(AD_HEIGHT(27));
        make.centerY.offset(0);
        
        view.textAlignment = NSTextAlignmentLeft;
        NSString *str = @"981.00";
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
        // 赋值
        view.attributedText = attribtStr;
    }];
    
    //加入购物车
    UIButton *addCarBtn = [UIButton getButtonWithImageName:@"购物车" titleText:@"加入购物车" superView:mainView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.right.offset(-AD_HEIGHT(16));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(96), AD_HEIGHT(32)));
        
        [btn setTitleColor:WhiteColor forState:normal];
        btn.titleLabel.font = F12;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -7)];
        btn.backgroundColor = C1E95F9;
        [btn addTarget:self action:@selector(addShopCar) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    return footerView;
}

#pragma mark ---- 加入购物车 ----
- (void)addShopCar
{
    
}

#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SetMealOrderCell *cell = [SetMealOrderCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(85);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CombinationSetMealDetailViewController *vc = [[CombinationSetMealDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self creatSectionHeaderView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AD_HEIGHT(136);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AD_HEIGHT(55);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [self creatSectionFooterView];
}
@end
