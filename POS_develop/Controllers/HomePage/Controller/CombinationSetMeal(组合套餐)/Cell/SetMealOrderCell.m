//
//  SetMealOrderCell.m
//  POS_develop
//
//  Created by sunyn on 2018/10/9.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SetMealOrderCell.h"
#import "PackageChargeListModel.h"

@implementation SetMealOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"SetMealOrderCell";
    SetMealOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SetMealOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}


- (void)initUI{
    self.myImageView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.myImageView];
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(8));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(80), AD_HEIGHT(69)));
    }];
    
    self.titleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.myImageView.mas_right).offset(AD_HEIGHT(26));
        make.top.equalTo(self.myImageView.mas_top);
        
        view.textAlignment = NSTextAlignmentLeft;
//        view.text = @"创立包（立刷999）";
    }];
    
    self.purchasePrice = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(AD_HEIGHT(7));
        
        
        view.textAlignment = NSTextAlignmentLeft;
        
    }];
    self.activationCash = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.purchasePrice.mas_bottom).offset(AD_HEIGHT(7));
        
        view.textAlignment = NSTextAlignmentLeft;
//        view.text = @"激活返现金：160.00元/台";
        
    }];
    self.number = [UILabel getLabelWithFont:F12 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.offset(AD_HEIGHT(-16));
        make.top.offset(AD_HEIGHT(8));
        
        view.textAlignment = NSTextAlignmentRight;
//        view.text = @"x2";
    }];
    [UIView getViewWithColor:CE6E2E2 superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(0.5));
    }];
}


- (void)setModel:(packageChargeItemDOListModel *)model {
    _model = model;
    
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:[model.productDO objectForKey:@"productImg"]]];
    self.titleLabel.text = [model.productDO objectForKey:@"posBrandName"];
    
    self.purchasePrice.text = [NSString stringWithFormat:@"采购价格：%@元/%@台", [model.productDO objectForKey:@"posPrice"], model.posCount];
    self.activationCash.text = [NSString stringWithFormat:@"激活返现金：%@元/台", [model.productDO objectForKey:@"posRebatePrice"]];
    self.number.text = [NSString stringWithFormat:@"x%@", [model.productDO objectForKey:@"posCount"]];
    
}

@end












