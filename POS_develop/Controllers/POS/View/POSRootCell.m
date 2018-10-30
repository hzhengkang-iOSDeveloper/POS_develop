//
//  POSRootCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/10.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "POSRootCell.h"
#import "POS_RootViewModel.h"
@interface  POSRootCell ()
{
    NSUInteger _skuCount;//记录sku 数量
}
//商品图片
@property (nonatomic, weak) UIImageView *skuImageView;
//商品名称
@property (nonatomic, weak) UILabel *skuNameLabel;
//采购价格
@property (nonatomic, weak) UILabel *skuPriceLabel;
//激活返现金
@property (nonatomic, weak) UILabel *activeBackMoneyLabel;
//推荐指数
@property (nonatomic, weak) UILabel *recommendRateLabel;
//商品增减数量
@property (nonatomic, weak) UILabel *skuCountLabel;

@end
@implementation POSRootCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"POSRootCell";
    POSRootCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[POSRootCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        _skuCount = 1;
    }
    return self;
}

- (void)initUI
{
    self.contentView.backgroundColor = WhiteColor;
    
    MJWeakSelf;
    //商品图片
    UIImageView *skuImageView = [[UIImageView alloc]init];
    skuImageView.contentMode = UIViewContentModeScaleAspectFit;
//    skuImageView.image = ImageNamed(@"默认头像");
    [self.contentView addSubview:skuImageView];
    self.skuImageView = skuImageView;
    [_skuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(10));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(80), AD_HEIGHT(70)));
    }];
    
    //商品名称
    UILabel *skuNameLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.skuImageView.mas_top);
        make.left.equalTo(weakSelf.skuImageView.mas_right).offset(AD_HEIGHT(26));
        
        view.textAlignment = NSTextAlignmentLeft;
    }];
    self.skuNameLabel = skuNameLabel;
    
    //采购价格
    UILabel *skuPriceLabel = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.skuNameLabel.mas_left);
        make.top.equalTo(weakSelf.skuNameLabel.mas_bottom).offset(AD_HEIGHT(7));
        
        view.textAlignment = NSTextAlignmentLeft;
    }];
    self.skuPriceLabel = skuPriceLabel;

    //激活返现金
    UILabel *activeBackMoneyLabel = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.skuPriceLabel.mas_left);
        make.top.equalTo(weakSelf.skuPriceLabel.mas_bottom).offset(AD_HEIGHT(7));
        
        view.textAlignment = NSTextAlignmentLeft;
    }];
    self.activeBackMoneyLabel = activeBackMoneyLabel;
    
    //推荐指数
    UILabel *recommendRateLabel = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.skuImageView.mas_left);
        make.top.equalTo(weakSelf.skuImageView.mas_bottom).offset(AD_HEIGHT(8));
        
    }];
    self.recommendRateLabel = recommendRateLabel;
    
    //底部分割线
    UIView *lineView = [UIView getViewWithColor:CF6F6F6 superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.bottom.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    
    //商品增减数量
    UIView *skuCountMainView = [UIView getViewWithColor:WhiteColor superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.skuImageView.mas_right).offset(AD_HEIGHT(16));
        make.bottom.equalTo(lineView.mas_top).offset(-AD_HEIGHT(7));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(100), AD_HEIGHT(26)));
        
        view.layer.borderWidth =1;
        view.layer.borderColor = CF6F6F6.CGColor;
        
    }];
    
    //减
    UIButton *subtractBtn = [UIButton getButtonWithImageName:@"" titleText:@"一" superView:skuCountMainView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.top.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(29), AD_HEIGHT(26)));
        
        [btn setTitleColor:RGB(134, 134, 134) forState:normal];
        btn.titleLabel.font = F10;
        [btn addTarget:self action:@selector(clickSubtractbtn) forControlEvents:UIControlEventTouchUpInside];
    }];
    UIView *leftLineView = [UIView getViewWithColor:CF6F6F6 superView:skuCountMainView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.equalTo(subtractBtn.mas_right);
        make.top.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(1), AD_HEIGHT(26)));
        
    }];
    
    //加
    UIButton *addBtn = [UIButton getButtonWithImageName:@"" titleText:@"+" superView:skuCountMainView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.right.top.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(29), AD_HEIGHT(26)));
        
        [btn setTitleColor:RGB(134, 134, 134) forState:normal];
        btn.titleLabel.font = F16;
        [btn addTarget:self action:@selector(clickAddbtn) forControlEvents:UIControlEventTouchUpInside];
    }];
    UIView *rightLineView = [UIView getViewWithColor:CF6F6F6 superView:skuCountMainView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.right.equalTo(addBtn.mas_left);
        make.top.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(1), AD_HEIGHT(26)));
    }];
    
    UILabel *skuCountLabel = [UILabel getLabelWithFont:FB15 textColor:C000000  superView:skuCountMainView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(leftLineView.mas_right).offset(0);
        make.right.equalTo(rightLineView.mas_left).offset(0);
        make.height.mas_equalTo(AD_HEIGHT(26));
        make.top.offset(0);
        
//        view.text  = @"1";
        view.textAlignment = NSTextAlignmentCenter;
        
    }];
    self.skuCountLabel = skuCountLabel;
    
    //加入购物车
     UIButton *addShopCarBtn = [UIButton getButtonWithImageName:@"购物车" titleText:@"加入购物车" superView:self.contentView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.right.offset(-AD_HEIGHT(7));
        make.bottom.equalTo(skuCountMainView.mas_bottom);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(96), AD_HEIGHT(32)));
        
        [btn setTitleColor:WhiteColor forState:normal];
        btn.titleLabel.font = F12;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -7)];
        btn.backgroundColor = C1E95F9;
         [btn addTarget:self action:@selector(addShopCar:) forControlEvents:UIControlEventTouchUpInside];
    }];
    self.addShopCarBtn = addShopCarBtn;
}

#pragma mark ---- 减 ----
- (void)clickSubtractbtn
{
    if (self.posRootModel.goodCount == 0) {
        HUD_TIP(@"数量最少为1");
        return;
    }
    if (self.posRootModel.goodCount > 0) {
        self.posRootModel.goodCount --;
    }
    
    self.skuCountLabel.text = [NSString stringWithFormat:@"%li",self.posRootModel.goodCount+1];
}
#pragma mark ---- 加 ----
- (void)clickAddbtn
{
    self.posRootModel.goodCount ++;

    self.skuCountLabel.text = [NSString stringWithFormat:@"%li",self.posRootModel.goodCount+1];
}
#pragma mark ---- 加入购物车 ----
- (void)addShopCar:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    if (self.addShopCarHandler) {
        self.addShopCarHandler(sender);
    }
}


- (void)setPosRootModel:(POS_RootViewModel *)posRootModel
{
    if (posRootModel) {
        _posRootModel = posRootModel;
        POS_RootPackageFreeModel *packageFreeM = posRootModel.packageFreeItemDOList.firstObject;
        POS_RootProductDOModel *productM = [POS_RootProductDOModel mj_objectWithKeyValues:packageFreeM.productDO];
        
        [self.skuImageView sd_setImageWithURL:URL(posRootModel.packagePic)];
        self.skuNameLabel.text = IF_NULL_TO_STRING(posRootModel.packageName);
        self.skuPriceLabel.text = [NSString stringWithFormat:@"采购价格：%@元/%@台",IF_NULL_TO_STRING(posRootModel.packagePrice),IF_NULL_TO_STRING(posRootModel.countInPackage)];
        self.activeBackMoneyLabel.text = [NSString stringWithFormat:@"激活返现金：%@元/台",productM.posRebatePrice];
        
        NSString *tmpStr = [NSString stringWithFormat:@"推荐指数：%@星！",posRootModel.recommendStar];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:tmpStr];
        [attriStr addAttribute:NSForegroundColorAttributeName value:C989898 range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(5, tmpStr.length-5)];
        self.recommendRateLabel.attributedText = attriStr;
        
        self.skuCountLabel.text = [NSString stringWithFormat:@"%li",posRootModel.goodCount +1];
    }
}
@end
