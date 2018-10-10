//
//  SelectDetailBrandViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/8.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SelectDetailBrandViewController.h"

@interface SelectDetailBrandViewController ()

@end

@implementation SelectDetailBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"查看消息";
    [self initUI];
}

- (void)initUI {
    UILabel *titleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(13));
        make.width.mas_equalTo(ScreenWidth - AD_HEIGHT(30));
    }];
    titleLabel.text = self.titleStr;
    
    UILabel *timeLabel = [UILabel getLabelWithFont:F10 textColor:RGB(74, 73, 73) superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(AD_HEIGHT(12));
        make.width.mas_equalTo(ScreenWidth - AD_HEIGHT(30));
    }];
    timeLabel.text = self.timeStr;
    
    UIView *lineView = [UIView getViewWithColor:RGB(216, 214, 214) superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(timeLabel.mas_bottom).offset(AD_HEIGHT(12));
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    UILabel *contentLabel = [UILabel getLabelWithFont:F10 textColor:RGB(74, 73, 73) superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.mas_equalTo(lineView.mas_bottom).offset(AD_HEIGHT(5));
        make.width.mas_equalTo(ScreenWidth - AD_HEIGHT(30));
    }];
    contentLabel.numberOfLines = 0;
    contentLabel.text = self.contentStr;
    
}
@end
