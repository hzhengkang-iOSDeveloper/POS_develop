//
//  TransactionDetailCell.h
//  POS_develop
//
//  Created by sunyn on 2018/9/19.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionDetailCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *statusLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
