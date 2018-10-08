//
//  TerminalAlreadyDistributionCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/4.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TerminalAlreadyDistributionCell : UITableViewCell
@property (nonatomic, strong) UILabel *brandLabel;
@property (nonatomic, strong) UILabel *snLabel;
@property (nonatomic, strong) UILabel *bindStateLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
