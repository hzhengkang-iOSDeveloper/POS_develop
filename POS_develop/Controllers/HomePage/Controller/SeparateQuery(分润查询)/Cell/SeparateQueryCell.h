//
//  SeparateQueryCell.h
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShareBenefitListModel;
NS_ASSUME_NONNULL_BEGIN

@interface SeparateQueryCell : UITableViewCell
@property (nonatomic, strong) UILabel *totalAmount;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIButton *totalPenNumber;
@property (nonatomic, strong) UIButton *totalShareProfit;
@property (nonatomic, strong) ShareBenefitListModel *model;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
