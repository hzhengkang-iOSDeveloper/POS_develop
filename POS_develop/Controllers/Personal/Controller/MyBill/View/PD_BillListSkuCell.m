//
//  PD_BillListSkuCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/20.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillListSkuCell.h"
@interface PD_BillListSkuCell ()
//sku 图片
@property (nonatomic, weak) UIImageView *skuImageView;
//sku name
@property (nonatomic, weak) UILabel *skuNameLabel;
//sku 价格
@property (nonatomic, weak) UILabel *skuPriceLabel;
//sku 数量
@property (nonatomic, weak) UILabel *skuCountLabel;
@end
@implementation PD_BillListSkuCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"PD_BillListSkuCell";
    PD_BillListSkuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PD_BillListSkuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    skuImageView.contentMode = UIViewContentModeScaleAspectFit;
    skuImageView.image = ImageNamed(@"头像2");
    [self.contentView addSubview:skuImageView];
    self.skuImageView = skuImageView;
    [_skuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(10));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(86), AD_HEIGHT(74)));
    }];
    
    
    //sku name
    UILabel *skuNameLabel = [UILabel new];
    skuNameLabel.text = @"京东到家京东到家京东到家京东到家京东到家京东到家京东到家京东到家";
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
    skuPriceLabel.text = @"￥123";
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
    skuCountLabel.text = @"x2";
    skuCountLabel.textColor = C989898;
    skuCountLabel.font = F12;
    skuCountLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:skuCountLabel];
    self.skuCountLabel = skuCountLabel;
    [_skuCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.top.equalTo(weakSelf.skuPriceLabel.mas_top);
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

@end
