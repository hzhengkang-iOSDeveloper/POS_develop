//
//  MyBillTableViewCell.h
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BagLogListModel;
@interface MyBillTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *contentStatusLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *totalAmountLabel;
@property (nonatomic, strong) BagLogListModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
