//
//  PD_BillDetailUnCheckView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/28.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PD_BillDetailUnCheckView.h"
#import "BillListModel.h"
@interface PD_BillDetailUnCheckView ()
//姓名
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UITextField  *nameTF;

//单号
@property (nonatomic, weak) UILabel *orderNoLabel;
@property (nonatomic, weak) UITextField *orderNoTF;
@property (nonatomic, weak) UIButton *reInputBtn;//重新输入
@end
@implementation PD_BillDetailUnCheckView

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
        make.height.mas_equalTo(AD_HEIGHT(106));
    }];
    
    //姓名
    UILabel *nameLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:topView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(19));
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
    nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTF.userInteractionEnabled = NO;
    [topView addSubview:nameTF];
    self.nameTF = nameTF;
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_right).offset(AD_HEIGHT(37));
        make.top.offset(0);
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
    orderNoTF.userInteractionEnabled = NO;
    orderNoTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [topView addSubview:orderNoTF];
    self.orderNoTF = orderNoTF;
    [_orderNoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.orderNoLabel.mas_right).offset(AD_HEIGHT(37));
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.bottom.offset(0);
        make.right.offset(0);
    }];
    
    //重新输入
    UIButton *reInputBtn = [UIButton getButtonWithImageName:@"" titleText:@"重新输入" superView:self masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(topView.mas_bottom).offset(AD_HEIGHT(20));
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(-AD_HEIGHT(15));
        make.height.mas_equalTo(AD_HEIGHT(45));
        
        [btn setTitleColor:WhiteColor forState:normal];
        btn.titleLabel.font = F15;
        [btn setBackgroundColor:C1E95F9];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.f;
        [btn addTarget:self action:@selector(reInput) forControlEvents:UIControlEventTouchUpInside];
    }];
    self.reInputBtn = reInputBtn;
}

#pragma mark ---- 重新输入 ----
- (void)reInput
{
    if ([self.reInputBtn.titleLabel.text isEqualToString:@"重新输入"]) {
        self.nameTF.userInteractionEnabled = YES;
        self.orderNoTF.userInteractionEnabled = YES;
        
        
        [self.nameTF becomeFirstResponder];
        
        [self.reInputBtn setTitle:@"确认保存" forState:normal];
    } else if ([self.reInputBtn.titleLabel.text isEqualToString:@"确认保存"]) {
        if ([self.nameTF.text isEqualToString:@""]) {
            HUD_TIP(@"姓名不能为空！");
            return;
        }
        
        if ([self.orderNoTF.text isEqualToString:@""]) {
            HUD_TIP(@"单号不能为空！");
            return;
        }
        
        
        if (self.comfirSaveInfoHandler) {
            self.comfirSaveInfoHandler(self.payDoM);
        }
    }
    
    
}

- (void)setPayDoM:(PayDOModel *)payDoM
{
    if (payDoM) {
        _payDoM = payDoM;
        
        self.nameTF.text = IF_NULL_TO_STRING(payDoM.payBankName);
        self.orderNoTF.text = IF_NULL_TO_STRING(payDoM.transactionId);
    }
}
@end
