//
//  POSViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/12.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "POSViewController.h"

@interface POSViewController ()
// 右边按钮array
@property (nonatomic, strong) NSArray *rightItems;
@end

@implementation POSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"pos机器购买";
    // 右侧功能按钮
    self.navigationItem.rightBarButtonItems = self.rightItems;
    self.navigationItem.leftBarButtonItem = nil;
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
@end
