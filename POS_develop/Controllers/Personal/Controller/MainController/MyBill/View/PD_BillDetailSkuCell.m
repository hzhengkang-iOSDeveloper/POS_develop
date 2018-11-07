//
//  PD_BillDetailSkuCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/25.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "PD_BillDetailSkuCell.h"
#import "BillListModel.h"
@interface PD_BillDetailSkuCell ()
//sku 图片
@property (nonatomic, weak) UIImageView *skuImageView;
//sku name
@property (nonatomic, weak) UILabel *skuNameLabel;
//sku 价格
@property (nonatomic, weak) UILabel *skuPriceLabel;
//sku 数量
@property (nonatomic, weak) UILabel *skuCountLabel;

@end
@implementation PD_BillDetailSkuCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"PD_BillDetailSkuCell";
    PD_BillDetailSkuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PD_BillDetailSkuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    }
    return self;
}

- (void)initUI
{
    self.contentView.backgroundColor = WhiteColor;
    
    MJWeakSelf;
    //sku 图片
    UIImageView *skuImageView = [UIImageView new];
    //    skuImageView.image = ImageNamed(@"头像2");
    [self.contentView addSubview:skuImageView];
    self.skuImageView = skuImageView;
    [_skuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(10));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(50), AD_HEIGHT(43)));
    }];
    
    
    //sku name
    UILabel *skuNameLabel = [UILabel new];
    //    skuNameLabel.text = @"京东到家京东到家京东到家京东到家京东到家京东到家京东到家京东到家";
    skuNameLabel.textColor = C000000;
    skuNameLabel.font = F13;
    skuNameLabel.textAlignment = NSTextAlignmentLeft;
    skuNameLabel.numberOfLines = 2;
    [self.contentView addSubview:skuNameLabel];
    self.skuNameLabel = skuNameLabel;
    [_skuNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.skuImageView.mas_right).offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(12));
        make.right.offset(-AD_HEIGHT(15));
    }];
    
    //sku 价格
    UILabel *skuPriceLabel = [UILabel new];
    //    skuPriceLabel.text = @"￥123";
    skuPriceLabel.textColor = C000000;
    skuPriceLabel.font = F12;
    skuPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:skuPriceLabel];
    self.skuPriceLabel = skuPriceLabel;
    [_skuPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.skuNameLabel.mas_left);
        make.top.equalTo(weakSelf.skuNameLabel.mas_bottom).offset(AD_HEIGHT(13));
    }];
    
    
    //sku 数量
    UILabel *skuCountLabel = [UILabel new];
    //    skuCountLabel.text = @"x2";
    skuCountLabel.textColor = C989898;
    skuCountLabel.font = F12;
    skuCountLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:skuCountLabel];
    self.skuCountLabel = skuCountLabel;
    [_skuCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.offset(0);
    }];
    
    //line
    UIView *lineView = [UIView new];
    lineView.backgroundColor = CE6E2E2;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.height.mas_equalTo(1);
        make.bottom.offset(0);
    }];
}

- (void)setItemListM:(PackAgeChargeItemListModel *)itemListM
{
    if (itemListM) {
        _itemListM = itemListM;
        ProductDOModel *productM = [ProductDOModel mj_objectWithKeyValues:itemListM.productDO];
        self.skuPriceLabel.text = [NSString stringWithFormat:@"￥%@", productM.posPrice];
        self.skuCountLabel.text = [NSString stringWithFormat:@"x%@", itemListM.posCount];
        [self.skuImageView sd_setImageWithURL:[NSURL URLWithString:productM.productImg]];
        self.skuNameLabel.text = productM.posBrandName;
    }
}


- (void)setItemFreeListM:(PackAgeFreeItemListModel *)itemFreeListM
{
    if (itemFreeListM) {
        _itemFreeListM =itemFreeListM;
        ProductDOModel *productM = [ProductDOModel mj_objectWithKeyValues:itemFreeListM.productDO];
        self.skuPriceLabel.text = [NSString stringWithFormat:@"￥%@", productM.posPrice];
        self.skuCountLabel.text = [NSString stringWithFormat:@"x%@", itemFreeListM.posCount];
        [self.skuImageView sd_setImageWithURL:[NSURL URLWithString:productM.productImg]];
        self.skuNameLabel.text = productM.posBrandName;
    }
}

- (void)setDetaiM:(DetailDOModel *)detaiM
{
    if (detaiM) {
        _detaiM = detaiM;
        ItemObjModel *productM = [ItemObjModel mj_objectWithKeyValues:detaiM.itemObj];
        self.skuPriceLabel.text = [NSString stringWithFormat:@"￥%@", productM.posPrice];
        self.skuCountLabel.text = [NSString stringWithFormat:@"x%@", productM.posCount];
        [self.skuImageView sd_setImageWithURL:[NSURL URLWithString:productM.productImg]];
        self.skuNameLabel.text = productM.productName;
    }
}
@end
