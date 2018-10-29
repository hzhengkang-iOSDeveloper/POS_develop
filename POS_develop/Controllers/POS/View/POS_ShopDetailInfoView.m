//
//  POS_ShopDetailInfoView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/11.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "POS_ShopDetailInfoView.h"
#import "POS_RootViewModel.h"
@interface POS_ShopDetailInfoView ()
//商品logo
@property (nonatomic, weak) UIImageView *goodImageV;
//商品名称
@property (nonatomic, weak) UILabel *skuNameLabel;
//采购价格
@property (nonatomic, weak) UILabel *skuPriceLabel;
//激活返现金
@property (nonatomic, weak) UILabel *activeBackMoneyLabel;
//推荐指数
@property (nonatomic, weak) UILabel *recommendRateLabel;
//商品介绍
@property (nonatomic, weak) UILabel *goodIntroduceLabel;

@end
@implementation POS_ShopDetailInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatMainView];
    }
    return self;
}

- (void)creatMainView
{
    
    self.backgroundColor = WhiteColor;
    MJWeakSelf;
    //商品logo
    UIImageView *goodImageV = [[UIImageView alloc]init];
    goodImageV.contentMode = UIViewContentModeScaleAspectFit;
//    goodImageV.image = ImageNamed(@"默认头像");
    [self addSubview:goodImageV];
    self.goodImageV = goodImageV;
    [_goodImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(5));
        make.right.offset(-AD_HEIGHT(15));
        make.height.mas_equalTo(AD_HEIGHT(147));
    }];
    
    //商品名称
    UILabel *skuNameLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goodImageV.mas_bottom).offset(AD_HEIGHT(12));
        make.left.equalTo(weakSelf.goodImageV.mas_left);
        
        view.textAlignment = NSTextAlignmentLeft;
//        view.text = @"创立包（立刷888）";
    }];
    self.skuNameLabel = skuNameLabel;
    
    //采购价格
    UILabel *skuPriceLabel = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.skuNameLabel.mas_left);
        make.top.equalTo(weakSelf.skuNameLabel.mas_bottom).offset(AD_HEIGHT(7));
        
        view.textAlignment = NSTextAlignmentLeft;
//        view.text = @"采购价格：900.00元/2台";
    }];
    self.skuPriceLabel = skuPriceLabel;
    
    //激活返现金
    UILabel *activeBackMoneyLabel = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.skuPriceLabel.mas_left);
        make.top.equalTo(weakSelf.skuPriceLabel.mas_bottom).offset(AD_HEIGHT(7));
        
        view.textAlignment = NSTextAlignmentLeft;
//        view.text = @"激活返现金：1900.00元/台";
    }];
    self.activeBackMoneyLabel = activeBackMoneyLabel;
    
    //推荐指数
    UILabel *recommendRateLabel = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.equalTo(weakSelf.activeBackMoneyLabel.mas_centerY);
        
        
    }];
    self.recommendRateLabel = recommendRateLabel;
    
    UIView *lineView = [UIView getViewWithColor:CF6F6F6 superView:self masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(weakSelf.activeBackMoneyLabel.mas_bottom).offset(AD_HEIGHT(12));
        make.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    
    
    //商品介绍
    UILabel *goodIntroduceLabel =  [UILabel getLabelWithFont:F13 textColor:RGB(106, 104, 104) superView:self masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(-AD_HEIGHT(15));
        make.top.equalTo(lineView.mas_bottom).offset(AD_HEIGHT(7));
        make.bottom.offset(-AD_HEIGHT(14));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 0;
    }];
    self.goodIntroduceLabel = goodIntroduceLabel;
    [self.goodIntroduceLabel changeLabelHeightWithWidth:(ScreenWidth-AD_HEIGHT(30))];

}

- (void)setModel:(POS_RootViewModel *)model {
    if (model) {
        _model = model;
        POS_RootPackageFreeModel *packageFreeM = model.packageFreeItemDOList.firstObject;
        POS_RootProductDOModel *productM = [POS_RootProductDOModel mj_objectWithKeyValues:packageFreeM.productDO];
        [self.goodImageV sd_setImageWithURL:[NSURL URLWithString:model.packagePic]];
        self.skuNameLabel.text = model.packageName;
        self.skuPriceLabel.text = [NSString stringWithFormat:@"采购价格：%@元/%@台",IF_NULL_TO_STRING(model.packagePrice),IF_NULL_TO_STRING(model.countInPackage)];
        self.activeBackMoneyLabel.text = [NSString stringWithFormat:@"激活返现金：%@元/台",productM.posRebatePrice];
        
        NSString *tmpStr = [NSString stringWithFormat:@"推荐指数：%@星！",model.recommendStar];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:tmpStr];
        [attriStr addAttribute:NSForegroundColorAttributeName value:C989898 range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(5, tmpStr.length-5)];
        self.activeBackMoneyLabel.attributedText = attriStr;
        
//        self.goodIntroduceLabel.text =
        
    }
}

- (void)setPosDetailStr:(NSString *)posDetailStr
{
    if (posDetailStr) {
        _posDetailStr = posDetailStr;
        self.goodIntroduceLabel.text = posDetailStr;
    }
}
@end
