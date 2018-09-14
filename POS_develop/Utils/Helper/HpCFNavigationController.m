//
//  HpCFNavigationController.m
//  HpCF
//
//  Created by syn on 2017/10/20.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "HpCFNavigationController.h"

@interface HpCFNavigationController ()

@end

@implementation HpCFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.改变导航栏按钮的颜色
    self.navigationBar.tintColor = [UIColor grayColor];
    // 2.滑动返回手势
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}
#pragma mark 返回按钮
-(void)popself {
    [self popViewControllerAnimated:YES];
}

#pragma mark 创建返回按钮
-(UIBarButtonItem *)createBackButton {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e916",25,ShallowTextColor)] style:UIBarButtonItemStylePlain target:self action:@selector(popself)];
}

#pragma mark 重写方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
}  
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
