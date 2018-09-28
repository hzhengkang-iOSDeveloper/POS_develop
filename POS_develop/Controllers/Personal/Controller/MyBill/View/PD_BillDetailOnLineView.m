//
//  PD_BillDetailOnLineView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/28.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PD_BillDetailOnLineView.h"
@interface PD_BillDetailOnLineView ()
{
    BOOL _wxSelectStatus;
    BOOL _aliSelectStatus;
}
@property (nonatomic, weak) UIButton *commfirBtn;//确认支付
@property (nonatomic, weak) UIImageView *wxSelectImage;
@property (nonatomic, weak) UIImageView *aliSelectImage;

@end
@implementation PD_BillDetailOnLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        _wxSelectStatus = NO;
        _aliSelectStatus = NO;
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = CF6F6F6;
    
    MJWeakSelf;
    //微信支付
    UIView *wxPayView = [UIView getViewWithColor:WhiteColor superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(56)));
        
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *wxPayGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wxPayGest)];
        [view addGestureRecognizer:wxPayGest];
    }];
    
    
    UILabel *wxTitleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:wxPayView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(24));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"微信支付";
    }];
    
    UIImageView *wxSelectImage = [[UIImageView alloc]init];
    wxSelectImage.contentMode = UIViewContentModeScaleAspectFit;
    wxSelectImage.image = ImageNamed(@"默认");
    [wxPayView addSubview:wxSelectImage];
    [wxSelectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.equalTo(wxTitleLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(15), AD_HEIGHT(15)));
    }];
    self.wxSelectImage = wxSelectImage;
    
    UIView *lineView = [UIView getViewWithColor:CF6F6F6 superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.top.equalTo(wxPayView.mas_bottom);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    
    
    //支付宝
    UIView *aliPayView = [UIView getViewWithColor:WhiteColor superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(lineView.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(56)));
        
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *aliPayGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alipayGest)];
        [view addGestureRecognizer:aliPayGest];
    }];
    
    
    UILabel *aliTitleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:aliPayView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(24));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"支付宝";
    }];
    
    UIImageView *aliSelectImage = [[UIImageView alloc]init];
    aliSelectImage.contentMode = UIViewContentModeScaleAspectFit;
    aliSelectImage.image = ImageNamed(@"默认");
    [aliPayView addSubview:aliSelectImage];
    [aliSelectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.equalTo(aliTitleLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(15), AD_HEIGHT(15)));
    }];
    self.aliSelectImage = aliSelectImage;
    
    
    //合计
    UILabel *totalCountLabel = [[UILabel alloc]init];
    totalCountLabel.font = F13;
    totalCountLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:totalCountLabel];
    [totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.top.equalTo(aliPayView.mas_bottom).offset(AD_HEIGHT(16));
    }];
    
    NSString *tmpStr = @"合计：￥1000.21";
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:tmpStr];
    [newStr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0,3)];
    [newStr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(3,tmpStr.length - 3)];
    totalCountLabel.attributedText=newStr;
    
   
    //确认支付
    UIButton *commfirBtn = [UIButton getButtonWithImageName:@"" titleText:@"确认支付" superView:self masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(totalCountLabel.mas_bottom).offset(AD_HEIGHT(16));
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(-AD_HEIGHT(15));
        make.height.mas_equalTo(AD_HEIGHT(46));
        
        [btn setTitleColor:WhiteColor forState:normal];
        btn.titleLabel.font = F15;
        [btn setBackgroundColor:CC9C9C9];
        btn.userInteractionEnabled = NO;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.f;
        [btn addTarget:self action:@selector(comfirPay) forControlEvents:UIControlEventTouchUpInside];
    }];
    self.commfirBtn = commfirBtn;
    
}

#pragma mark ---- 微信支付 ----
- (void)wxPayGest
{
    _wxSelectStatus = !_wxSelectStatus;
    if (_wxSelectStatus) {
        self.wxSelectImage.image = ImageNamed(@"默认地址");
        _aliSelectStatus = NO;
        self.aliSelectImage.image = ImageNamed(@"默认");
        [self.commfirBtn setBackgroundColor:C1E95F9];
        self.commfirBtn.userInteractionEnabled = YES;
    } else {
        [self.commfirBtn setBackgroundColor:CC9C9C9];
        self.commfirBtn.userInteractionEnabled = NO;
        self.wxSelectImage.image = ImageNamed(@"默认");
    }
}

#pragma mark ---- 支付宝 ----
- (void)alipayGest
{
    _aliSelectStatus = !_aliSelectStatus;
    if (_aliSelectStatus) {
        self.aliSelectImage.image = ImageNamed(@"默认地址");
        _wxSelectStatus = NO;
        self.wxSelectImage.image = ImageNamed(@"默认");
        [self.commfirBtn setBackgroundColor:C1E95F9];
        self.commfirBtn.userInteractionEnabled = YES;
        
    } else {
        [self.commfirBtn setBackgroundColor:CC9C9C9];
        self.commfirBtn.userInteractionEnabled = NO;
        self.aliSelectImage.image = ImageNamed(@"默认");
    }
}

#pragma mark ---- 确认支付 ----
- (void)comfirPay
{
    
}
@end
