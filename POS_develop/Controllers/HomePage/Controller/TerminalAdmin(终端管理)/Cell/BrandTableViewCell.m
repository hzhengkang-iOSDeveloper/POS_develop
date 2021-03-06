//
//  BrandTableViewCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/4.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BrandTableViewCell.h"

@implementation BrandTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"BrandTableViewCell";
    BrandTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BrandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.brandLabel = [[UILabel alloc] init];
    self.brandLabel.textColor = C000000;
    self.brandLabel.font = F13;
    self.brandLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.brandLabel];
    [self.brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(FITiPhone6(15));
        make.top.offset(FITiPhone6(15));
    }];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectBtn setImage:[UIImage imageNamed:@"图层4拷贝10"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    self.selectBtn.userInteractionEnabled = NO;
//        [self.selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(FITiPhone6(-15));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(18), FITiPhone6(18)));
    }];
    
    
    [UIView getViewWithColor:CF6F6F6 superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
}
@end
