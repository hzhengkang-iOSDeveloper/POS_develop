//
//  POS_CommfirBillOutLinePayView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/12.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "POS_CommfirBillOutLinePayView.h"
@interface POS_CommfirBillOutLinePayView ()
{
    BOOL _payTypeStatus;
}
@property (nonatomic, weak) UIButton *commfirBtn;//确认支付
@property (nonatomic, weak) UIImageView *selectImage;
@property (nonatomic, weak) UILabel *totalCountLabel;
@end
@implementation POS_CommfirBillOutLinePayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        _payTypeStatus = YES;
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = CF6F6F6;
    
    MJWeakSelf;
    UIView *topView = [UIView getViewWithColor:WhiteColor superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(51));
        
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPayType)];
        [view addGestureRecognizer:gest];
    }];
    
    UILabel *titleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:topView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(24));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"线下转账";
    }];
    
    UIImageView *selectImage = [[UIImageView alloc]init];
    selectImage.contentMode = UIViewContentModeScaleAspectFit;
    selectImage.image = ImageNamed(@"默认地址");
    [topView addSubview:selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(15), AD_HEIGHT(15)));
    }];
    self.selectImage = selectImage;
    
    UILabel *tipView =[UILabel getLabelWithFont:F10 textColor:CF52542 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(topView.mas_bottom).offset(AD_HEIGHT(10));
        
        view.text = @"超过1000元请用线下转账形式支付";
        view.textAlignment = NSTextAlignmentLeft;
        
    }];
    
    UILabel *totalCountLabel = [[UILabel alloc]init];
    totalCountLabel.font = F13;
    totalCountLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:totalCountLabel];
    [totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.equalTo(tipView.mas_centerY);
    }];
    self.totalCountLabel =totalCountLabel;

    
    
    //确认支付
    UIButton *commfirBtn = [UIButton getButtonWithImageName:@"" titleText:@"支付" superView:self masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(tipView.mas_bottom).offset(AD_HEIGHT(30));
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(-AD_HEIGHT(15));
        make.height.mas_equalTo(AD_HEIGHT(46));
        
        [btn setTitleColor:WhiteColor forState:normal];
        btn.titleLabel.font = F15;
        [btn setBackgroundColor:C1E95F9];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.f;
        [btn addTarget:self action:@selector(comfirPay) forControlEvents:UIControlEventTouchUpInside];
    }];
    self.commfirBtn = commfirBtn;
}

#pragma mark ---- 确认支付 ----
- (void)comfirPay
{
    if (self.outLinePayHandler) {
        self.outLinePayHandler();
    }
}

#pragma mark ---- 选中状态 ----
- (void)clickPayType
{
    _payTypeStatus = !_payTypeStatus;
    if (_payTypeStatus == YES) {
        self.selectImage.image = ImageNamed(@"默认地址");
        self.commfirBtn.userInteractionEnabled = YES;
        self.commfirBtn.backgroundColor = C1E95F9;
    } else {
        self.selectImage.image = ImageNamed(@"默认");
        self.commfirBtn.userInteractionEnabled = NO;
        self.commfirBtn.backgroundColor = CC9C9C9;
    }
}

- (void)setMoneyCount:(NSString *)moneyCount
{
    if (moneyCount) {
        _moneyCount = moneyCount;
        NSString *tmpStr = [NSString stringWithFormat:@"合计：%@",moneyCount];
        NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:tmpStr];
        [newStr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0,3)];
        [newStr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(3,tmpStr.length - 3)];
        self.totalCountLabel.attributedText=newStr;
    }
}
@end
