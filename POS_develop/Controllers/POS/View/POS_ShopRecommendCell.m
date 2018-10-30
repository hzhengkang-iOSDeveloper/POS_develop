//
//  POS_ShopRecommendCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/11.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "POS_ShopRecommendCell.h"
#import "POS_RootViewModel.h"
@interface POS_ShopRecommendCell ()
//商品logo
@property (nonatomic, weak) UIImageView *goodImageV;
//商品名称
@property (nonatomic, weak) UILabel *goodNameLabel;
//商品价格
@property (nonatomic, weak) UILabel *goodPriceLabel;

@end
@implementation POS_ShopRecommendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"POS_ShopRecommendCell";
    POS_ShopRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[POS_ShopRecommendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self  initUI];
    }
    return self;
}

- (void)initUI
{
    self.contentView.backgroundColor = WhiteColor;
    MJWeakSelf;
    
    //商品logo
    UIImageView *goodImageV = [[UIImageView alloc]init];
    goodImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:goodImageV];
    self.goodImageV = goodImageV;
    [_goodImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(10));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(80), AD_HEIGHT(70)));
    }];

    //商品名称
    UILabel *goodNameLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodImageV.mas_right).offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(15));
        
        view.textAlignment = NSTextAlignmentLeft;
    }];
    self.goodNameLabel = goodNameLabel;
    

    //商品价格
    UILabel *goodPriceLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodNameLabel.mas_left);
        make.top.equalTo(weakSelf.goodNameLabel.mas_bottom).offset(7);
        
        view.textAlignment = NSTextAlignmentLeft;
    }];
    self.goodPriceLabel = goodPriceLabel;
    
    
    [UIView getViewWithColor:CE6E2E2 superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.bottom.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
}

- (void)setPosM:(POS_RootViewModel *)posM
{
    if (posM) {
        _posM  = posM;
        [self.goodImageV sd_setImageWithURL:URL(posM.packagePic)];
        self.goodNameLabel.text = IF_NULL_TO_STRING(posM.packageName);
        self.goodPriceLabel.text = [NSString stringWithFormat:@"￥%@",IF_NULL_TO_STRING(posM.packagePrice)];
    }
}
@end
