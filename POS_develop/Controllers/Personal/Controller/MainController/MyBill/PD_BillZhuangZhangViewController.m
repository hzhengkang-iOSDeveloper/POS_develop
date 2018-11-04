//
//  PD_BillZhuangZhangViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/11/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PD_BillZhuangZhangViewController.h"

@interface PD_BillZhuangZhangViewController ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation PD_BillZhuangZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"转账说明";
    
    self.view.backgroundColor = WhiteColor;
    [self getZhuanZhangTextRequest];
    
   UILabel *label =  [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.top.offset(AD_HEIGHT(15));
        make.right.offset(-AD_HEIGHT(15));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 0;
       
        [view changeLabelHeightWithWidth:(ScreenWidth-AD_HEIGHT(30))];
    }];
    self.label = label;
}

- (void)getZhuanZhangTextRequest
{
    [[HPDConnect connect]PostNetRequestMethod:@"api/trans/orderPay/getPayDesc" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                self.label.text = result[@"data"];
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
        }
    }];
}

@end
