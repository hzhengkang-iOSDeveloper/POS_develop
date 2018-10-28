//
//  BagWithdrawCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/27.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BagWithdrawCell.h"
#import "BagWithdrawListModel.h"

@implementation BagWithdrawCell



+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"BagWithdrawCell";
    BagWithdrawCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BagWithdrawCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}


-(void)initUI{
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = C000000;
    self.contentLabel.font = F13;
    self.contentLabel.text = @"提现";
    self.contentLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self).offset(FITiPhone6(18));
        make.height.mas_equalTo(FITiPhone6(14));
    }];
    self.contentStatusLabel = [[UILabel alloc] init];
    //    self.contentStatusLabel.textColor = C1E95F9;
    self.contentStatusLabel.font = F13;
    self.contentStatusLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.contentStatusLabel];
    [self.contentStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel.mas_right).offset(FITiPhone6(5));
        make.top.equalTo(self).offset(FITiPhone6(18));
        make.height.mas_equalTo(FITiPhone6(14));
    }];
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = C989898;
    self.timeLabel.font = F10;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.contentLabel.mas_bottom).offset(FITiPhone6(11));
        make.height.mas_equalTo(FITiPhone6(10));
    }];
    self.amountLabel = [[UILabel alloc] init];
    self.amountLabel.textColor = C000000;
    self.amountLabel.font = F13;
    self.amountLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(FITiPhone6(-15));
        make.top.equalTo(self).offset(FITiPhone6(10));
        make.height.mas_equalTo(FITiPhone6(10));
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = CE6E2E2;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FITiPhone6(15));
        make.top.equalTo(self.mas_bottom);
        make.size.sizeOffset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(0.5)));
    }];
}

- (void)setModel:(BagWithdrawListModel *)model {
    if (model) {
        _model = model;
        self.timeLabel.text = [model.createtime substringToIndex:16];
        self.amountLabel.text = model.amount;
        if ([model.withdrawStatus isEqualToString:@"0"]) {
            self.contentStatusLabel.text = @"提现审核中";
            self.contentStatusLabel.textColor = RGB(22, 161, 191);
        }else if ([model.withdrawStatus isEqualToString:@"1"]) {
            self.contentStatusLabel.text = @"提现成功";
            self.contentStatusLabel.textColor = C1E95F9;
        }else {
            self.contentStatusLabel.text = @"提现失败";
            self.contentStatusLabel.textColor = RGB(245, 37, 66);
        }
    }
}

@end
