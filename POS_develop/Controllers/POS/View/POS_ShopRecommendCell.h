//
//  POS_ShopRecommendCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/11.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PackageChargeListModel;
NS_ASSUME_NONNULL_BEGIN

@interface POS_ShopRecommendCell : UITableViewCell
@property (nonatomic, strong) PackageChargeListModel *posM;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
