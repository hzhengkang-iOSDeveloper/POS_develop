//
//  ActivationMoneyCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/29.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "ActivationMoneyCell.h"
#import "ActivationRebateListModel.h"

@interface ActivationMoneyCell ()
//激活数量
@property (nonatomic, weak) UILabel  *activationCountLabel;
//返现金额
@property (nonatomic, weak) UILabel   *returnMoneyLabel;
//姓名
@property (nonatomic, weak) UILabel    *nameLabel;

@end
@implementation ActivationMoneyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"ActivationMoneyCell";
    ActivationMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ActivationMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.contentView.backgroundColor = WhiteColor;
    
    MJWeakSelf;
    //激活数量
    UIImageView *activationImage = [[UIImageView alloc]init];
    activationImage.contentMode = UIViewContentModeScaleAspectFit;
    activationImage.image = ImageNamed(@"激活数量");
    [self.contentView addSubview:activationImage];
    [activationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(22));
    }];
    
    
    UILabel  *activationCountLabel = [UILabel getLabelWithFont:F12 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(activationImage.mas_right).offset(AD_HEIGHT(10));
        make.top.equalTo(activationImage.mas_top);
        
//        view.text = @"激活数量:98";
        view.textAlignment = NSTextAlignmentLeft;
    }];
    self.activationCountLabel = activationCountLabel;
    
    
    
    
    UILabel   *returnMoneyLabel = [UILabel getLabelWithFont:F12 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.activationCountLabel.mas_left);
        make.bottom.offset(-AD_HEIGHT(22));
//        view.text = @"返现金额:4029.12";
        view.textAlignment = NSTextAlignmentLeft;
    }];
    self.returnMoneyLabel = returnMoneyLabel;
    
    //返现金额
    UIImageView *returnMoneyImage = [[UIImageView alloc]init];
    returnMoneyImage.contentMode = UIViewContentModeScaleAspectFit;
    returnMoneyImage.image = ImageNamed(@"返现金");
    [self.contentView addSubview:returnMoneyImage];
    [returnMoneyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.equalTo(returnMoneyLabel.mas_centerY);
    }];
    //姓名
    UILabel    *nameLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(20));
        
        view.textAlignment = NSTextAlignmentRight;
//        view.text = @"高先生";
    }];
    self.nameLabel = nameLabel;
    
    
    //日期
    UILabel *dateLabel = [UILabel getLabelWithFont:F10 textColor:C989898 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.bottom.offset(-AD_HEIGHT(22));
        
        view.textAlignment = NSTextAlignmentRight;
//        view.text = @"交易日期2018/09/21-2019/01/23";
    }];
    self.dateLabel = dateLabel;
    
    [UIView getViewWithColor:CF6F6F6 superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.bottom.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
}

- (void)setModel:(ActivationRebateListModel *)model {
    if (model) {
        _model = model;
        self.activationCountLabel.text = [NSString stringWithFormat:@"激活数量:%@", model.totalNumber];
        self.returnMoneyLabel.text = [NSString stringWithFormat:@"返现金额:%@元", model.totalARAmount];
        self.nameLabel.text = model.agentName;
        
    }
}

@end

















