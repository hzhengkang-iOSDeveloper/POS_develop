//
//  ActivationMoneyCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/29.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActivationRebateListModel;
NS_ASSUME_NONNULL_BEGIN

@interface ActivationMoneyCell : UITableViewCell
//日期
@property (nonatomic, weak) UILabel     *dateLabel;

@property (nonatomic, strong) ActivationRebateListModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
