//
//  PD_BillSkuFooterView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/20.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillSkuFooterView.h"
#import "BillListModel.h"
@interface PD_BillSkuFooterView ()
//免费
@property (nonatomic, weak) UILabel *isFreeLabel;

//右边按钮
@property (nonatomic, weak) UIButton *rightBtn;
//左侧按钮
@property (nonatomic, weak) UIButton *leftBtn;

@end
@implementation PD_BillSkuFooterView

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
    
    //免费
    UILabel *isFreeLabel = [UILabel new];
//    isFreeLabel.text = @"免费";
    isFreeLabel.textColor = CF52542;
    isFreeLabel.font = F13;
    isFreeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:isFreeLabel];
    self.isFreeLabel = isFreeLabel;
    [_isFreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(14));
    }];
    
    //数量 价格描述
    UILabel *countAndPriceLabel = [UILabel new];
    countAndPriceLabel.font = F12;
    countAndPriceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:countAndPriceLabel];
    self.countAndPriceLabel = countAndPriceLabel;
    [_countAndPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(16));
        make.top.offset(AD_HEIGHT(14));
    }];
    
    
    //右边按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setTitle:@"确认收货" forState:normal];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius = AD_HEIGHT(11);
    [rightBtn setTitleColor:WhiteColor forState:normal];
    [rightBtn setBackgroundColor:CFF0000];
    rightBtn.titleLabel.font = F13;
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    self.rightBtn = rightBtn;
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.top.equalTo(weakSelf.countAndPriceLabel.mas_bottom).offset(AD_HEIGHT(10));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(21)));
    }];
    
    //左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setTitle:@"查看物流" forState:normal];
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.cornerRadius = AD_HEIGHT(11);
    leftBtn.layer.borderColor = C989898.CGColor;
    leftBtn.layer.borderWidth = 1.f;
    [leftBtn setTitleColor:C000000 forState:normal];
    [leftBtn setBackgroundColor:WhiteColor];
    leftBtn.titleLabel.font = F13;
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    self.leftBtn = leftBtn;
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.rightBtn.mas_left).offset(-AD_HEIGHT(10));
        make.top.equalTo(weakSelf.rightBtn.mas_top);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(21)));
    }];
}
#pragma mark ---- 按钮点击 ----
- (void)rightBtnClick
{
    if ([self.model.orderStatus isEqualToString:@"10"]) {
        if (self.rightHandler) {
            self.rightHandler(self.model.orderStatus);
        }
    }else if ( [self.model.orderStatus isEqualToString:@"30"]) {
        [SLPopupShowView createPopupShowViewWithContentText:@"是否确认收货" buttons:@[@"确定收货",@"取消"] buttonClick:^(int index) {
            if (index == 0) {
                if (self.rightHandler) {
                    self.rightHandler(self.model.orderStatus);
                }
            }
        }];
        
    }else if ( [self.model.orderStatus isEqualToString:@"20"]) {
        return;
        
    }else if ( [self.model.orderStatus isEqualToString:@"15"]) {
        return;
        
    }
}

- (void)leftBtnClick
{
  
}

- (void)setModel:(BillListModel *)model {
    if (model) {
        _model = model;
        if ([model.orderPrice isEqualToString:@"0"]) {
            self.isFreeLabel.text = @"免费";
        }else{
            self.isFreeLabel.text = @"";
        }
        
        if ([model.orderStatus isEqualToString:@"10"]) {
            [self changeBtnLeftStr:@"" withRight:@"立即付款"];
        }else if ([model.orderStatus isEqualToString:@"15"]) {
            [self changeBtnLeftStr:@"" withRight:@"待审核"];
        }else if ([model.orderStatus isEqualToString:@"20"]) {
            [self changeBtnLeftStr:@"" withRight:@"待发货"];
        }else if ([model.orderStatus isEqualToString:@"30"]) {
            [self changeBtnLeftStr:@"" withRight:@"确认收货"];
        }else if ([model.orderStatus isEqualToString:@"40"]) {
            [self changeBtnLeftStr:@"" withRight:@""];
        }else if ([model.orderStatus isEqualToString:@"50"]) {
            [self changeBtnLeftStr:@"" withRight:@""];
        }
        

        
    }
}

- (void)changeBtnLeftStr:(NSString*)leftStr withRight:(NSString *)rightStr
{
    if ([leftStr isEqualToString:@""]) {
        self.leftBtn.hidden = YES;
    } else {
        [self.leftBtn setTitle:leftStr forState:normal];
        self.leftBtn.hidden = NO;
    }
    if ([rightStr isEqualToString:@""]) {
        self.rightBtn.hidden = YES;
    } else {
        [self.rightBtn setTitle:rightStr forState:normal];
        self.rightBtn.hidden = NO;
    }
    
}


@end
