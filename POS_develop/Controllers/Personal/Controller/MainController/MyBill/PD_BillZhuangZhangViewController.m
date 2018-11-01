//
//  PD_BillZhuangZhangViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/11/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PD_BillZhuangZhangViewController.h"

@interface PD_BillZhuangZhangViewController ()

@end

@implementation PD_BillZhuangZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"转账说明";
    
    self.view.backgroundColor = WhiteColor;
    
    
    [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.top.offset(AD_HEIGHT(15));
        make.right.offset(-AD_HEIGHT(15));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 0;
        view.text = @"这段文字后台可以编辑，主要是转账的流程，一些注意事项 以及转账的账号信息等等。";
        
        [view changeLabelHeightWithWidth:(ScreenWidth-AD_HEIGHT(30))];
    }];
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
