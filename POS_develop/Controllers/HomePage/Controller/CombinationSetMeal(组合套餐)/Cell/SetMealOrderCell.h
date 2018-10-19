//
//  SetMealOrderCell.h
//  POS_develop
//
//  Created by sunyn on 2018/10/9.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class packageChargeItemDOListModel;
NS_ASSUME_NONNULL_BEGIN

@interface SetMealOrderCell : UITableViewCell
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *purchasePrice;//采购价格
@property (nonatomic, strong) UILabel *activationCash;//激活返现金
@property (nonatomic, strong) UILabel *number;//订单数量
@property (nonatomic, strong) packageChargeItemDOListModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
