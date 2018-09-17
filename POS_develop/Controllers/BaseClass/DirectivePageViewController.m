//
//  DirectivePageViewController.m
//  HpCF
//
//  Created by 孙亚男 on 2017/10/11.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import "DirectivePageViewController.h"
#import "PowerfulBannerView.h"

@interface DirectivePageViewController ()

@property (nonatomic) PowerfulBannerView *bannerView;
@end

@implementation DirectivePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [USER_DEFAULT setBool:YES forKey:CF_FirstOpenApp];
    [USER_DEFAULT synchronize];
    [self initUI];
}

- (void)initUI {
    self.bannerView = [[PowerfulBannerView alloc] initWithFrame:self.view.bounds];
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bu_0%ld", i]];
        [items addObject:image];
    }
    self.bannerView.items = items;
    __weak __typeof(self) weakself = self;
    UIPageControl *pageControl     = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _bannerView.frame.size.height-39 / 2 * K_view_scale - 19 /2 * K_view_scale, ScreenWidth, 19 / 2)];
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = RGBA(225, 225, 225, 0.6);
    pageControl.currentPageIndicatorTintColor = C1E95F9;
    _bannerView.pageControl         = pageControl;
    _bannerView.autoLooping         = NO;
    [_bannerView addSubview:pageControl];
    self.bannerView.bannerItemConfigurationBlock = ^UIView *(PowerfulBannerView *banner, id item, UIView *reusableView) {
        // 尽可能重用视图
        UIImageView *imageView = (UIImageView *)reusableView;
        if (!imageView) {
            imageView = [[UIImageView alloc] initWithImage:item];
        }
        imageView.userInteractionEnabled = YES;
        if (item == items[items.count - 1]) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(ScreenWidth / 2 - 377 / 2 / 2 * K_view_scale, ScreenHeight - 115 / 2 * K_view_scale - 74 / 2 * K_view_scale, 377 / 2 * K_view_scale, 74 / 2 * K_view_scale);
            button.titleLabel.font = [UIFont systemFontOfSize:17 * K_view_scale];
            [button setTitleColor:WhiteColor forState:UIControlStateNormal];
            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            button.backgroundColor = C1E95F9;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = button.bounds.size.height / 2;
            button.layer.borderColor = C1E95F9.CGColor;
            button.layer.borderWidth = 1 * K_view_scale;
            [button addTarget:weakself action:@selector(bunm) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        return imageView;
    };
    
    
    self.bannerView.bannerDidSelectBlock = ^(PowerfulBannerView *banner, NSInteger index) {
        if (index == banner.items.count - 1) { // 最后一张
            
        }
    };
    
    [self.view addSubview:self.bannerView];
}
- (void)bunm{
    if (self.endCallback) {
        self.endCallback();
    }
}
@end

