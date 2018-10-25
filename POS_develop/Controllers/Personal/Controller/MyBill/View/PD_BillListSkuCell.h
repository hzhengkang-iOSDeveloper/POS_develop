//
//  PD_BillListSkuCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/20.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailDOModel;

NS_ASSUME_NONNULL_BEGIN

@interface PD_BillListSkuCell : UITableViewCell

@property (nonatomic, strong) DetailDOModel *orderModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
