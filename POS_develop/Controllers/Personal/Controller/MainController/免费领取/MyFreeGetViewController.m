//
//  MyFreeGetViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/23.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "MyFreeGetViewController.h"
#import "MyFreeGetRootViewController.h"
@interface MyFreeGetViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>
@property (nonatomic, strong, readwrite) WMPageController* pageController;//pageControl
@property (nonatomic, copy) NSString *podId;

@end

@implementation MyFreeGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"免费领取";
    self.view.backgroundColor = CF6F6F6;
    [self creatSelectBillStatus];
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
    MyFreeGetRootViewController* controller = [[MyFreeGetRootViewController alloc]init];

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
    return CGRectMake(0, originY, ScreenWidth,ScreenHeight- originY-navH);
}

- (CGRect)pageController:(nonnull WMPageController *)pageController preferredFrameForMenuView:(nonnull WMMenuView *)menuView {
    return CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(36));
}
#pragma mark ---- 获取id ----
- (void)getProductIdRequest
{
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"api/trans/product/list?chargeType=%@",@"1"] params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = result[@"data"][@"rows"];
                    if (arr.count > 0) {
                        NSDictionary *posDic = arr.firstObject;
                        self.podId = [posDic objectForKey:@"id"];
                        
                        [self.pageController reloadData];
                    }
                }
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
    
}
@end
