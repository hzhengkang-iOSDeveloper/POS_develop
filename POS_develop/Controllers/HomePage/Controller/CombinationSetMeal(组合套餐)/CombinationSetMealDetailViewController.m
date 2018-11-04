//
//  CombinationSetMealDetailViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/17.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "CombinationSetMealDetailViewController.h"
#import "SetMealOrderCell.h"
#import "PackageChargeListModel.h"

@interface CombinationSetMealDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *myTable;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CombinationSetMealDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = WhiteColor;
    [self creatTableView];
    [self loadPackageChargeGetRequest];
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
    [_myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
        make.width.mas_equalTo(ScreenWidth);
    }];
}
#pragma mark ---- header ----
- (UIView *)creatSectionHeaderView:(PackageChargeListModel *)model
{
    self.navigationItemTitle = model.packageName;
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = WhiteColor;
    
    UIImageView *img = [[UIImageView alloc]init];
    img.contentMode = UIViewContentModeScaleAspectFit;
//    img.image = ImageNamed(@"WechatIMG48-1");
    [img sd_setImageWithURL:[NSURL URLWithString:model.packagePic]];
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
//        view.text = @"双喜临门套餐";
        view.text = model.packageName;
        
    }];
    
    return headerView;
}
#pragma mark ---- footer ----
- (UIView *)creatSectionFooterView:(PackageChargeListModel *)model
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
//        view.text = @"￥800";
        view.text = [NSString stringWithFormat:@"￥%@", model.packagePrice];
    }];
    
    [UILabel getLabelWithFont:F12 textColor:C989898 superView:mainView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(realPriceLabel.mas_right).offset(AD_HEIGHT(27));
        make.centerY.offset(0);
        
        view.textAlignment = NSTextAlignmentLeft;
//        NSString *str = @"981.00";
        NSString *str = model.originPrice;
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
        // 赋值
        view.attributedText = attribtStr;
        if ([model.originPrice isEqualToString:model.packagePrice]) {
            view.hidden = YES;
        }else {
            view.hidden = NO;
        }
    }];
    
    //加入购物车
    [UIButton getButtonWithImageName:@"购物车" titleText:@"加入购物车" superView:mainView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
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
    [self loadCartSaveRequest];
}

#pragma mark -- tableView代理数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PackageChargeListModel *model = self.dataArray[section];
    return model.packageChargeItemDOList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SetMealOrderCell *cell = [SetMealOrderCell cellWithTableView:tableView];
    PackageChargeListModel *model = self.dataArray[indexPath.section];
    packageChargeItemDOListModel *detailModel = model.packageChargeItemDOList[indexPath.row];
    cell.model = detailModel;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(85);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    POS_CommitBillViewController *vc = [[POS_CommitBillViewController alloc]init];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PackageChargeListModel *model = self.dataArray[section];
    return [self creatSectionHeaderView:model];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AD_HEIGHT(136);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AD_HEIGHT(55);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    PackageChargeListModel *model = self.dataArray[section];
    return [self creatSectionFooterView:model];
}


#pragma mark ---- 接口 ----
-(void)loadPackageChargeGetRequest {
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"%@%@",@"api/trans/packageCharge/get/",self.myID] params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *array = result[@"data"];
                    self.dataArray = [NSMutableArray arrayWithObject:[PackageChargeListModel mj_objectWithKeyValues:array]];
                    
                    [self.myTable reloadData];
                }
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
        }
        
        
        NSLog(@"result ------- %@", result);
    }];
}

#pragma mark ---- 加入购物车接口 ----
- (void)loadCartSaveRequest
{
    HUD_NOBGSHOW;
    NSDictionary *dict = @{
                           @"userid":USER_ID_POS,
                           @"pkgPrdId":IF_NULL_TO_STRING(self.myID),
                           @"pkgPrdType":@"1",
                           @"count":@"1",
                           @"operation":@"1"
                           };
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/cart/save" params:dict cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                HUD_SUCCESS(@"成功加入购物车");
                //发送通知 更改nav的购物车数量
                [[NSNotificationCenter defaultCenter]postNotificationName:@"changeShopCarCount" object:nil userInfo:@{@"goodCount":@"1"}];
            } else if ([result[@"code"]integerValue] == -1) {
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            } else {
                HUD_ERROR(@"加入购物车失败，请稍后重试！");
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end



















