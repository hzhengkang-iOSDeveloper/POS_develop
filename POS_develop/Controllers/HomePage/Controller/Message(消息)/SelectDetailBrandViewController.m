//
//  SelectDetailBrandViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/8.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SelectDetailBrandViewController.h"

@interface SelectDetailBrandViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation SelectDetailBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"查看消息";
    [self initUI];
    [self loadMessageGetRequest];
}

- (void)initUI {
    self.titleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(13));
        make.width.mas_equalTo(ScreenWidth - AD_HEIGHT(30));
    }];
    
    
    self.timeLabel = [UILabel getLabelWithFont:F10 textColor:RGB(74, 73, 73) superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(AD_HEIGHT(12));
        make.width.mas_equalTo(ScreenWidth - AD_HEIGHT(30));
    }];
    
   
    
    UIView *lineView = [UIView getViewWithColor:RGB(216, 214, 214) superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(AD_HEIGHT(12));
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    self.contentLabel = [UILabel getLabelWithFont:F10 textColor:RGB(74, 73, 73) superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.mas_equalTo(lineView.mas_bottom).offset(AD_HEIGHT(5));
        make.width.mas_equalTo(ScreenWidth - AD_HEIGHT(30));
    }];
    self.contentLabel.numberOfLines = 0;
    
}

#pragma mark ---- 接口 ----
-(void)loadMessageGetRequest {
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"%@%@",@"api/trans/message/get/",self.myId] params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                self.titleLabel.text = [result[@"data"] valueForKey:@"msgTitle"];
                self.timeLabel.text = [[result[@"data"] valueForKey:@"createtime"] substringToIndex:10];
                self.contentLabel.text = [result[@"data"] valueForKey:@"msgContent"];
                
            }
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end


















