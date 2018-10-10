//
//  NullViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/9.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "NullViewController.h"

@interface NullViewController ()

@end

@implementation NullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"未开通"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(AD_HEIGHT(72));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(45), AD_HEIGHT(45)));
    }];
    UILabel *label = [UILabel getLabelWithFont:F15 textColor:C000000 superView:self.view masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(imageView.mas_bottom).offset(AD_HEIGHT(40));
    }];
    label.text = @"内容暂未开放......敬请期待";
}

@end
