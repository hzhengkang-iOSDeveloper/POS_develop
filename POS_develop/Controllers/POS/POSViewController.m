//
//  POSViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/12.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "POSViewController.h"
#import "POSRootViewController.h"
@interface POSViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>
// 右边按钮array
@property (nonatomic, strong) NSArray *rightItems;
@property (nonatomic, strong, readwrite) WMPageController* pageController;//pageControl

@end

@implementation POSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"pos机器购买";
    self.view.backgroundColor = CF6F6F6;
    // 右侧功能按钮
    self.navigationItem.rightBarButtonItems = self.rightItems;
    self.navigationItem.leftBarButtonItem = nil;
    
    [self creatSelectBillStatus];
}
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
    return 3;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    POSRootViewController* controller = [[POSRootViewController alloc]init];
    //    switch (index) {
    //        case 0:{
    //            controller.fileType = ARMFileTypeAll;
    //        }
    //            break;
    //        case 1:{
    //            controller.fileType = ARMFileTypeAudio;
    //        }
    //            break;
    //        case 2:{
    //            controller.fileType = ARMFileTypeTxt;
    //        }
    //            break;
    //        default:
    //            break;
    //    }
    return controller;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return @"品牌一";
        case 1:
            return @"品牌二";
        case 2:
            return @"品牌三";
    }
    return @"";
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForContentView:(nonnull WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.pageController.menuView]);
    return CGRectMake(0, originY+AD_HEIGHT(5), ScreenWidth,ScreenHeight- (originY+AD_HEIGHT(5))-navH-(iPhoneX?83:49));
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForMenuView:(nonnull WMMenuView *)menuView {
    return CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(36));
}
@end
