//
//  PD_BillDetailOutLineInfoView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/27.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PD_BillDetailOutLineInfoView.h"
#import "PD_BillZhuangZhangViewController.h"
@interface PD_BillDetailOutLineInfoView ()
//姓名
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UITextField  *nameTF;

//单号
@property (nonatomic, weak) UILabel *orderNoLabel;
@property (nonatomic, weak) UITextField *orderNoTF;
@property (nonatomic, weak) UILabel *totalCountLabel;
@property (nonatomic, weak) UIButton *commfirBtn;//确认支付
@end
@implementation PD_BillDetailOutLineInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = CF6F6F6;
    
    MJWeakSelf;
    UIView *topView = [UIView getViewWithColor:WhiteColor superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(162));
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
    
   UIView *lineTop =  [UIView getViewWithColor:CF6F6F6 superView:topView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(titleLabel.mas_bottom).offset(AD_HEIGHT(19));
        make.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    
    
    //姓名
    UILabel *nameLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:topView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(lineTop.mas_bottom).offset(AD_HEIGHT(19));
        make.width.mas_equalTo(AD_HEIGHT(32));
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"姓名:";
    }];
    self.nameLabel = nameLabel;
    
    UITextField *nameTF = [[UITextField alloc]init];
    [nameTF setValue:C989898
                  forKeyPath:@"_placeholderLabel.textColor"];
    [nameTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    nameTF.borderStyle = UITextBorderStyleNone;
    nameTF.font = F13;
    nameTF.placeholder = @"请输入姓名";
    nameTF.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:nameTF];
    self.nameTF = nameTF;
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_right).offset(AD_HEIGHT(37));
        make.top.equalTo(lineTop.mas_bottom);
        make.height.mas_equalTo(AD_HEIGHT(50));
        make.right.offset(0);
    }];
    
    UIView *lineView = [UIView getViewWithColor:CF6F6F6 superView:topView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(AD_HEIGHT(19));
        make.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    
    //单号
    UILabel *orderNoLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:topView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(lineView.mas_bottom).offset(AD_HEIGHT(19));
        make.width.mas_equalTo(AD_HEIGHT(32));

        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"单号:";
    }];
    self.orderNoLabel = orderNoLabel;

    UITextField *orderNoTF = [[UITextField alloc]init];
    [orderNoTF setValue:C989898
          forKeyPath:@"_placeholderLabel.textColor"];
    [orderNoTF setValue:F13 forKeyPath:@"_placeholderLabel.font"];
    orderNoTF.borderStyle = UITextBorderStyleNone;
    orderNoTF.font = F13;
    orderNoTF.placeholder = @"请输入单号";
    orderNoTF.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:orderNoTF];
    self.orderNoTF = orderNoTF;
    [_orderNoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.orderNoLabel.mas_right).offset(AD_HEIGHT(37));
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.bottom.offset(0);
        make.right.offset(0);
    }];

    
    //转账说明
    UIButton *transferBtn = [UIButton getButtonWithImageName:@"" titleText:@"转账说明" superView:self masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(topView.mas_bottom).offset(AD_HEIGHT(17));
        make.left.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(60), AD_HEIGHT(31)));
        
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.titleLabel.font = F13;
        btn.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleColor:C1E95F9 forState:normal];
        [btn addTarget:self action:@selector(transferAccountBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    
    
    UILabel *totalCountLabel = [[UILabel alloc]init];
    totalCountLabel.font = F13;
    totalCountLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:totalCountLabel];
    self.totalCountLabel = totalCountLabel;
    [totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.equalTo(transferBtn.mas_centerY);
    }];
    
    
    
    //确认支付
    UIButton *commfirBtn = [UIButton getButtonWithImageName:@"" titleText:@"确认支付" superView:self masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(transferBtn.mas_bottom).offset(AD_HEIGHT(20));
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

#pragma mark ---- 转账说明 ----
- (void)transferAccountBtn
{
    PD_BillZhuangZhangViewController *vc = [[PD_BillZhuangZhangViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---- 确认支付 ----
- (void)comfirPay
{
    if ([self.nameTF.text isEqualToString:@""]) {
        HUD_ERROR(@"请填写转账姓名！");
        return;
    }
    if ([self.orderNoTF.text isEqualToString:@""]) {
        HUD_ERROR(@"请填写单号！");
        return;
    }
    NSDictionary *dict = @{
                           @"name":self.nameTF.text,
                           @"orderNo":self.orderNoTF.text
                           };
    if (self.outLinePayHandler) {
        self.outLinePayHandler(dict);
    }
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
