//
//  BagWithdrawCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/27.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BagWithdrawListModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagWithdrawCell : UITableViewCell
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *contentStatusLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;


@property (nonatomic, strong) BagWithdrawListModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
