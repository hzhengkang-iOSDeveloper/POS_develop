//
//  GeneralizeViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/12.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "GeneralizeViewController.h"
#import "XRCarouselView.h"
#import "ImageGeneralizeViewController.h"
#import "QRGenerailzeViewController.h"
#import "HtmlGenerailzeViewController.h"
#import "BuySuccessViewController.h"

@interface GeneralizeViewController () <XRCarouselViewDelegate>
@property (nonatomic, strong) XRCarouselView *advView;
@property (nonatomic, strong) UIButton *qrCodeBtn;//二维码推广
@property (nonatomic, strong) UIButton *imageBtn;//图片推广
@property (nonatomic, strong) UIButton *htmlBtn;//h5推广
@end

@implementation GeneralizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"推广";
    [self initAdvView];//创建轮播图
    [self initMainView];
}
- (void)initAdvView {
    //轮播图
    self.advView = [[XRCarouselView alloc] init];
    [self.view addSubview:self.advView];
    //用代理处理图片点击
    self.advView.delegate = self;
    //设置每张图片的停留时间，默认值为5s，最少为2s
    self.advView.time = 3;
    [self.advView setPageImage:ImageNamed(@"图层11拷贝2") andCurrentPageImage:ImageNamed(@"椭圆2拷贝")];
    [_advView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(-AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(4));
        make.height.mas_equalTo(AD_HEIGHT(165));
    }];
    
    NSMutableArray *imgs = [NSMutableArray array];
    [imgs addObject:ImageNamed(@"图层6")];
    [imgs addObject:ImageNamed(@"图层6")];
    [imgs addObject:ImageNamed(@"图层6")];
    self.advView.imageArray = imgs;
}

- (void)initMainView {
    UIView *bgView = [UIView getViewWithColor:WhiteColor superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(self.advView.mas_bottom).offset(AD_HEIGHT(36));
        make.size.mas_offset(CGSizeMake(ScreenWidth - AD_HEIGHT(30), AD_HEIGHT(107)));
    }];
    [[bgView layer] setShadowOffset:CGSizeMake(0, FITiPhone6(5))];
    [[bgView layer] setShadowRadius:FITiPhone6(7)];
    [[bgView layer] setShadowOpacity:0.2];
    [[bgView layer] setShadowColor:C000000.CGColor];
    
    self.qrCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.qrCodeBtn addTarget:self action:@selector(qrCodeClick) forControlEvents:UIControlEventTouchUpInside];
    //    self.qrCodeBtn.backgroundColor = [UIColor redColor];
    [bgView addSubview:self.qrCodeBtn];
    [self.qrCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(107-30)));
    }];
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageBtn addTarget:self action:@selector(imageClick) forControlEvents:UIControlEventTouchUpInside];
    //    self.imageBtn.backgroundColor = [UIColor redColor];
    [bgView addSubview:self.imageBtn];
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(107-30)));
    }];
    
    self.htmlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.htmlBtn addTarget:self action:@selector(htmlClick) forControlEvents:UIControlEventTouchUpInside];
    //    self.htmlBtn.backgroundColor = [UIColor redColor];
    [bgView addSubview:self.htmlBtn];
    [self.htmlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(107-30)));
    }];
    
    UIImageView *qrImageView = [[UIImageView alloc] init];
    qrImageView.image = [UIImage imageNamed:@"二维码"];
    [bgView addSubview:qrImageView];
    [qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(31));
        make.top.offset(AD_HEIGHT(28));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(26), AD_HEIGHT(26)));
    }];
    UILabel *qrLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(qrImageView.mas_bottom).offset(AD_HEIGHT(17));
    }];
    qrLabel.text = @"二维码推广";
    
    UIImageView *imageImageView = [[UIImageView alloc] init];
    imageImageView.image = [UIImage imageNamed:@"图片推广"];
    [bgView addSubview:imageImageView];
    [imageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(AD_HEIGHT(28));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(26), AD_HEIGHT(26)));
    }];
    UILabel *imageLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(qrImageView.mas_bottom).offset(AD_HEIGHT(17));
    }];
    imageLabel.text = @"图片推广";
    
    UIImageView *htmlImageView = [[UIImageView alloc] init];
    htmlImageView.image = [UIImage imageNamed:@"推广copy"];
    [bgView addSubview:htmlImageView];
    [htmlImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(AD_HEIGHT(-40));
        make.top.offset(AD_HEIGHT(28));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(26), AD_HEIGHT(26)));
    }];
    UILabel *htmlLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerX.equalTo(htmlImageView.mas_centerX);
        make.top.equalTo(qrImageView.mas_bottom).offset(AD_HEIGHT(17));
    }];
    htmlLabel.text = @"html5推广";
}
#pragma mark ---- 二维码推广 ----
- (void)qrCodeClick {
    QRGenerailzeViewController *vc = [[QRGenerailzeViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---- 图片推广 ----
- (void)imageClick {
    ImageGeneralizeViewController *vc = [[ImageGeneralizeViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
//    BuySuccessViewController *vc = [[BuySuccessViewController alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---- html推广 ----
- (void)htmlClick {
    HtmlGenerailzeViewController *vc = [[HtmlGenerailzeViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- 轮播图点击方法
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
    
}
@end
