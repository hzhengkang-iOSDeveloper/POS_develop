//
//  MyFreeGetViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/23.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "MyFreeGetViewController.h"
#import "MyFreeGetRootViewController.h"
#import "PosHomeModel.h"

@interface MyFreeGetViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>
@property (nonatomic, strong, readwrite) WMPageController* pageController;//pageControl
@property (nonatomic, copy) NSString *podId;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MyFreeGetViewController
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
    self.navigationItemTitle = @"免费领取";
    self.view.backgroundColor = CF6F6F6;
    [self creatSelectBillStatus];
    [self getProductIdRequest];
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
    MyFreeGetRootViewController* controller = [[MyFreeGetRootViewController alloc]init];
    PosHomeModel *posModel = self.dataArr[index];
    controller.podId = posModel.ID;
    return controller;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    PosHomeModel *posModel = self.dataArr[index];
    return IF_NULL_TO_STRING(posModel.posBrandName);
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
@end
