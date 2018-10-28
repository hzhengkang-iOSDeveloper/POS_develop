//
//  TerminalAlreadyDistributionCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/4.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalAlreadyDistributionCell.h"

@implementation TerminalAlreadyDistributionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"TerminalAlreadyDistributionCell";
    TerminalAlreadyDistributionCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TerminalAlreadyDistributionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    [self addSubview:self.brandLabel];
    [self.brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self).offset(FITiPhone6(11));
    }];
    self.snLabel = [[UILabel alloc] init];
    self.snLabel.textColor = C000000;
    self.snLabel.font = F13;
    self.snLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.snLabel];
    [self.snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.brandLabel.mas_left);
        make.bottom.equalTo(self).offset(FITiPhone6(-13));
    }];
    self.bindStateLabel = [[UILabel alloc] init];
    self.bindStateLabel.textColor = RGB(248, 27, 28);
    self.bindStateLabel.font = F13;
    self.bindStateLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.bindStateLabel];
    [self.bindStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-16));
        make.centerY.equalTo(self.snLabel.mas_top);
    }];
    [UIView getViewWithColor:CF6F6F6 superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
}
@end
