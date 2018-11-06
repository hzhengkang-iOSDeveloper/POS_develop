//
//  PD_BillDetailWriteInfoView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/11/6.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PD_BillDetailWriteInfoView.h"
@interface PD_BillDetailWriteInfoView ()
//姓名
@property (nonatomic, weak) UILabel *nameLabel;

//单号
@property (nonatomic, weak) UILabel *orderNoLabel;

@end
@implementation PD_BillDetailWriteInfoView

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
    self.backgroundColor = WhiteColor;
    
    
    MJWeakSelf;
    UIView *lineTop =  [UIView getViewWithColor:CF6F6F6 superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    
    
    //姓名
    UILabel *nameLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
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
    [self addSubview:nameTF];
    self.nameTF = nameTF;
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_right).offset(AD_HEIGHT(37));
        make.top.equalTo(lineTop.mas_bottom);
        make.height.mas_equalTo(AD_HEIGHT(50));
        make.right.offset(0);
    }];
    
    UIView *lineView = [UIView getViewWithColor:CF6F6F6 superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(AD_HEIGHT(19));
        make.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    
    //单号
    UILabel *orderNoLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
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
    [self addSubview:orderNoTF];
    self.orderNoTF = orderNoTF;
    [_orderNoTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.orderNoLabel.mas_right).offset(AD_HEIGHT(37));
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.bottom.offset(0);
        make.right.offset(0);
    }];

}


- (void)hideView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = YES;
    } completion:^(BOOL finished) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }];
}


- (void)showView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = NO;
    } completion:^(BOOL finished) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(AD_HEIGHT(102));
        }];
    }];
}

@end
