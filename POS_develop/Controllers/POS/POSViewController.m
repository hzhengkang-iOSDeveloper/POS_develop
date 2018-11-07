//
//  POSViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/12.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "POSViewController.h"
#import "POSRootViewController.h"
#import "POS_ShopCarViewController.h"//购物车
#import "PosHomeModel.h"
@interface POSViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>
// 右边按钮array
@property (nonatomic, strong) NSArray *rightItems;
// 购物车数量
@property (nonatomic, strong) UILabel *cartNumLabel;
//购物车数量
@property (nonatomic,assign)NSUInteger cartNum;
@property (nonatomic, strong, readwrite) WMPageController* pageController;//pageControl
@property (nonatomic, copy) NSString *podId;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation POSViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getShopCarRequest];
}
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"pos机器购买";
    self.view.backgroundColor = CF6F6F6;
    // 右侧功能按钮
    self.navigationItem.rightBarButtonItems = self.rightItems;
    self.navigationItem.leftBarButtonItem = nil;
    
    [self getProductIdRequest];
    [self creatSelectBillStatus];
    
    //获取购物车数量
    [self getShopCarRequest];
//    //接收通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeGoodCarCount:) name:@"changeShopCarCount" object:nil];
}


//#pragma mark ---- 处理购物车label数量 ----
//- (void)changeGoodCarCount:(NSNotification *)notif
//{
//    if ([notif.userInfo isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *dict = notif.userInfo;
//        self.cartNumLabel.hidden = NO;
//        self.cartNum = self.cartNum + [[dict objectForKey:@"goodCount"]integerValue];
//        self.cartNumLabel.text = [NSString stringWithFormat:@"%ld",(long)self.cartNum];
//    }
//}
#pragma mark - nav购物车&更多按钮
- (NSArray *)rightItems {
    if (!_rightItems) {
        UIButton *kindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        kindBtn.frame = CGRectMake(0, 0, 25, 25);
        [kindBtn setImage:ImageNamed(@"套餐信息") forState:normal];
        [kindBtn addTarget:self action:@selector(kindBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *kindItem = [[UIBarButtonItem alloc] initWithCustomView:kindBtn];
        
        
        UIButton *shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shopCartBtn.frame = CGRectMake(0, 0, 25, 25);
        [shopCartBtn setImage:ImageNamed(@"购物车") forState:normal];
        [shopCartBtn addTarget:self action:@selector(shopCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *shopCartItem = [[UIBarButtonItem alloc] initWithCustomView:shopCartBtn];
        
        
        _cartNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopCartBtn.width-10, -5, 18, 18)];
        _cartNumLabel.hidden = YES;
        _cartNumLabel.textColor = WhiteColor;
        _cartNumLabel.textAlignment = NSTextAlignmentCenter;
        _cartNumLabel.font = F8;
        _cartNumLabel.backgroundColor = CF52542;
        _cartNumLabel.layer.cornerRadius = CGRectGetHeight(_cartNumLabel.bounds)/2;
        _cartNumLabel.layer.masksToBounds = YES;
        [shopCartBtn addSubview:_cartNumLabel];
        
        //新加的代码
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = 30;
        
        _rightItems = @[shopCartItem,kindItem,space];
    }
    return _rightItems;
}
#pragma mark ---- 导航栏分类按钮 ----
- (void)kindBtnClick
{
    
}
#pragma mark ---- 购物车按钮 ----
- (void)shopCartBtnClick
{
    POS_ShopCarViewController *vc = [[POS_ShopCarViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---- 创建选择状态栏 ----
- (void)creatSelectBillStatus
{
    
    _pageController = [[WMPageController alloc]init];
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    _pageController.delegate = self;
    _pageController.dataSource = self;
    _pageController.menuItemWidth = ScreenWidth/3;
    _pageController.titleColorNormal = C000000;
    _pageController.titleColorSelected = C1E95F9;
    _pageController.titleSizeNormal = 13;
    _pageController.titleSizeSelected = 13;
    _pageController.menuViewStyle = WMMenuViewStyleLine;
    _pageController.progressWidth = AD_HEIGHT(51);
    [_pageController reloadData];
}

#pragma mark ---- WMPageControllerDelegate,WMPageControllerDataSource ----
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.dataArr.count;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    POSRootViewController* controller = [[POSRootViewController alloc]init];
    PosHomeModel *posModel = self.dataArr[index];

    controller.podId = posModel.ID;
    MJWeakSelf;
    controller.changeShopCarCount = ^(NSUInteger addGoodCount) {
//        weakSelf.cartNumLabel.hidden = NO;
//        weakSelf.cartNum = weakSelf.cartNum + addGoodCount;
//        weakSelf.cartNumLabel.text = [NSString stringWithFormat:@"%ld",(long)weakSelf.cartNum];
        [weakSelf getShopCarRequest];
    };

    return controller;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    PosHomeModel *posModel = self.dataArr[index];
    return IF_NULL_TO_STRING(posModel.posBrandName);
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForContentView:(nonnull WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.pageController.menuView]);
    return CGRectMake(0, originY, ScreenWidth,ScreenHeight- originY-navH-(iPhoneX?83:49));
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForMenuView:(nonnull WMMenuView *)menuView {
    return CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(36));
}

#pragma mark ---- 获取id ----
- (void)getProductIdRequest
{
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"api/trans/product/list?chargeType=%@",@"0"] params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        NSArray *arr = result[@"data"][@"rows"];
                        
                        if (arr.count >3) {
                            for (int i= 0; i<arr.count; i++) {
                                if (i <3) {
                                    [self.dataArr addObject:[PosHomeModel mj_objectWithKeyValues:arr[i]]];
                                }
                            }
                        } else {
                            if (arr.count > 0) {
                            [self.dataArr addObjectsFromArray:[PosHomeModel mj_objectArrayWithKeyValuesArray:arr]];
                            }
                        }
                        [self.pageController reloadData];
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

#pragma mark ---- 查询购物车数量 ----
- (void)getShopCarRequest
{
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/cart/list" params:@{@"userid":USER_ID_POS} cookie:nil result:^(bool success, id result) {
        if (success) {
            
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        NSString *posCount = result[@"data"][@"total"];
                        if ([posCount integerValue] == 0) {
                            self.cartNumLabel.hidden = YES;
                        } else {
                            self.cartNumLabel.hidden = NO;
                            self.cartNumLabel.text = [NSString stringWithFormat:@"%ld",(long)[posCount integerValue]];
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
#pragma mark ---- 移除通知 ----
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeShopCarCount" object:nil];
}
@end
