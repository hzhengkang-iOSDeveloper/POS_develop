//
//  TransactionListCell.h
//  POS_develop
//
//  Created by sunyn on 2018/9/19.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TransactionListModel;
@interface TransactionListCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *snLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UIButton *seeDetail;
@property (nonatomic, copy) void(^seeDetailBlock)(void);

@property (nonatomic, strong) TransactionListModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
