//
//  PD_BillDetailOnLineView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/28.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PD_BillDetailOnLineView.h"
#import "PD_BillDetailWriteInfoView.h"
#import "PD_BillZhuangZhangViewController.h"

@interface PD_BillDetailOnLineView ()
{
    BOOL _wxSelectStatus;
    BOOL _aliSelectStatus;
    BOOL _outLineSelectStatus;

}
@property (nonatomic, weak) UIButton *commfirBtn;//确认支付
@property (nonatomic, weak) UIImageView *wxSelectImage;
@property (nonatomic, weak) UIImageView *aliSelectImage;
@property (nonatomic, weak) UIImageView *outLineSelectImage;
@property (nonatomic, weak) UILabel *totalCountLabel;
@property (nonatomic, weak) UIButton *transferBtn;//转账说明
@property (nonatomic, weak) PD_BillDetailWriteInfoView *outLineInfoView;
@end
@implementation PD_BillDetailOnLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        _wxSelectStatus = NO;
        _aliSelectStatus = NO;
        _outLineSelectStatus = NO;
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = CF6F6F6;
    
//    MJWeakSelf;
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
    
    UIView *aliLineView = [UIView getViewWithColor:CF6F6F6 superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.top.equalTo(aliPayView.mas_bottom);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    
    //线下支付
    UIView *outLinePayView = [UIView getViewWithColor:WhiteColor superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(aliLineView.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(56)));
        
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *outLinePayGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(outLinePayGest)];
        [view addGestureRecognizer:outLinePayGest];
    }];
    
    
    UILabel *outLineTitleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:outLinePayView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(24));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"线下支付";
    }];
    
    UIImageView *outLineSelectImage = [[UIImageView alloc]init];
    outLineSelectImage.contentMode = UIViewContentModeScaleAspectFit;
    outLineSelectImage.image = ImageNamed(@"默认");
    [outLinePayView addSubview:outLineSelectImage];
    [outLineSelectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.equalTo(outLineTitleLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(15), AD_HEIGHT(15)));
    }];
    self.outLineSelectImage = outLineSelectImage;
    
    
    //线下转账
    PD_BillDetailWriteInfoView *outLineInfoView = [[PD_BillDetailWriteInfoView alloc]init];
    outLineInfoView.hidden = YES;
    [self addSubview:outLineInfoView];
    [outLineInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(outLinePayView.mas_bottom).offset(0);
        make.left.offset(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(0);
        //            make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(282)));
    }];
    self.outLineInfoView = outLineInfoView;
    
    //转账说明
    UIButton *transferBtn = [UIButton getButtonWithImageName:@"" titleText:@"转账说明" superView:self masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(outLineInfoView.mas_bottom).offset(AD_HEIGHT(17));
        make.left.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(60), AD_HEIGHT(31)));
        
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.titleLabel.font = F13;
        btn.hidden = YES;
        btn.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleColor:C1E95F9 forState:normal];
        [btn addTarget:self action:@selector(transferAccountBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    self.transferBtn = transferBtn;
    
    //合计
    UILabel *totalCountLabel = [[UILabel alloc]init];
    totalCountLabel.font = F13;
    totalCountLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:totalCountLabel];
    self.totalCountLabel = totalCountLabel;
    [totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.top.equalTo(outLineInfoView.mas_bottom).offset(AD_HEIGHT(16));
    }];
   
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
    
//    [self layoutIfNeeded];

    _wxSelectStatus = !_wxSelectStatus;
    if (_wxSelectStatus) {
        self.wxSelectImage.image = ImageNamed(@"默认地址");
        _aliSelectStatus = NO;
        _outLineSelectStatus = NO;
        self.aliSelectImage.image = ImageNamed(@"默认");
        self.outLineSelectImage.image = ImageNamed(@"默认");
        [self.commfirBtn setBackgroundColor:C1E95F9];
        self.commfirBtn.userInteractionEnabled = YES;
        
        
        [self hideOutLineInfoView];

    } else {
        [self.commfirBtn setBackgroundColor:CC9C9C9];
        self.commfirBtn.userInteractionEnabled = NO;
        self.wxSelectImage.image = ImageNamed(@"默认");
    }
}

#pragma mark ---- 支付宝 ----
- (void)alipayGest
{
//    [self layoutIfNeeded];

    _aliSelectStatus = !_aliSelectStatus;
    if (_aliSelectStatus) {
        self.aliSelectImage.image = ImageNamed(@"默认地址");
        _wxSelectStatus = NO;
        _outLineSelectStatus = NO;
        self.wxSelectImage.image = ImageNamed(@"默认");
        self.outLineSelectImage.image = ImageNamed(@"默认");
        [self.commfirBtn setBackgroundColor:C1E95F9];
        self.commfirBtn.userInteractionEnabled = YES;
        
        
        [self hideOutLineInfoView];


    } else {
        [self.commfirBtn setBackgroundColor:CC9C9C9];
        self.commfirBtn.userInteractionEnabled = NO;
        self.aliSelectImage.image = ImageNamed(@"默认");
    }
}

#pragma mark ---- 线下支付 ----
- (void)outLinePayGest
{
//    [self layoutIfNeeded];

    _outLineSelectStatus = !_outLineSelectStatus;
    if (_outLineSelectStatus) {
        self.outLineSelectImage.image = ImageNamed(@"默认地址");
        _wxSelectStatus = NO;
        _aliSelectStatus = NO;
        self.wxSelectImage.image = ImageNamed(@"默认");
        self.aliSelectImage.image = ImageNamed(@"默认");
        [self.commfirBtn setBackgroundColor:C1E95F9];
        self.commfirBtn.userInteractionEnabled = YES;
        
        [self showOutLineInfoView];
        
    } else {
        [self.commfirBtn setBackgroundColor:CC9C9C9];
        self.commfirBtn.userInteractionEnabled = NO;
        self.outLineSelectImage.image = ImageNamed(@"默认");
        
        [self hideOutLineInfoView];
    }
}


#pragma mark ---- 显示线下信息页面 ----
- (void)showOutLineInfoView
{
    self.transferBtn.hidden = NO;
    [self.outLineInfoView showView];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(AD_HEIGHT(214)+AD_HEIGHT(57)+AD_HEIGHT(102));
    }];
}
#pragma mark ---- 隐藏线下信息页面 ----
- (void)hideOutLineInfoView
{
    self.transferBtn.hidden = YES;
    [self.outLineInfoView hideView];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(AD_HEIGHT(214)+AD_HEIGHT(57));
    }];
}

#pragma mark ---- 确认支付 ----
- (void)comfirPay
{
    if (_aliSelectStatus) {
        //支付宝
        if (![OpenShare canOpen:@"alipay://"]) {
            HUD_ERROR(@"请安装支付宝客户端");
            return;
        }
        if (self.payHandler) {
            self.payHandler(1,@{});
        }
    } else if (_wxSelectStatus) {
        //微信
        if (![OpenShare canOpen:@"weixin://"]) {
            HUD_ERROR(@"请安装微信客户端");
            return;
        }
        if (self.payHandler) {
            self.payHandler(0,@{});
        }
    } else {
        
        if ([self.outLineInfoView.nameTF.text isEqualToString:@""]) {
            HUD_ERROR(@"请填写转账姓名！");
            return;
        }
        if ([self.outLineInfoView.orderNoTF.text isEqualToString:@""]) {
            HUD_ERROR(@"请填写单号！");
            return;
        }
        NSDictionary *dict = @{
                               @"name":self.outLineInfoView.nameTF.text,
                               @"orderNo":self.outLineInfoView.orderNoTF.text
                               };
        
        
        if (self.payHandler) {
            self.payHandler(2,dict);
        }
    }
}


#pragma mark ---- 转账说明 ----
- (void)transferAccountBtn
{
    PD_BillZhuangZhangViewController *vc = [[PD_BillZhuangZhangViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


- (void)setHeJiMoneyStr:(NSString *)heJiMoneyStr
{
    if (heJiMoneyStr) {
        _heJiMoneyStr = heJiMoneyStr;
        NSString *tmpStr = [NSString stringWithFormat:@"合计：￥%@",heJiMoneyStr];
        NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:tmpStr];
        [newStr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0,3)];
        [newStr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(3,tmpStr.length - 3)];
        self.totalCountLabel.attributedText=newStr;
    }
}
@end
