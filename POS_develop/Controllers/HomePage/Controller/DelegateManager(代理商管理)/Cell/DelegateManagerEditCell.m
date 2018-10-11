//
//  DelegateManagerEditCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/7.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "DelegateManagerEditCell.h"

@implementation DelegateManagerEditCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"DelegateManagerEditCell";
    DelegateManagerEditCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DelegateManagerEditCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.titleLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
    }];
    self.contentTF = [[UITextField alloc] init];
    self.contentTF.borderStyle = UITextBorderStyleNone;
    self.contentTF.font = F13;
    self.contentTF.textColor = C000000;
    [self.contentView addSubview:self.contentTF];
    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(112));
        make.centerY.offset(0);
    }];
    [UIView getViewWithColor:CE6E2E2 superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.bottom.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
    self.vipGradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.vipGradeBtn setTitle:@"V3" forState:UIControlStateNormal];
    [self.vipGradeBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [self.vipGradeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:FITiPhone6(5)];
    [self.vipGradeBtn setImage:[UIImage imageNamed:@"更多"] forState:normal];
    self.vipGradeBtn.titleLabel.font = F13;
    self.vipGradeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.vipGradeBtn];
    [self.vipGradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(AD_HEIGHT(-15));
        make.centerY.offset(0);
    }];
}
@end
