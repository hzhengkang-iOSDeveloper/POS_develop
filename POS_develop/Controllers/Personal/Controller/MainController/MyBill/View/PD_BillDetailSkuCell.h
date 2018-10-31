//
//  PD_BillDetailSkuCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/25.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PackAgeChargeItemListModel;
@class DetailDOModel;
NS_ASSUME_NONNULL_BEGIN

@interface PD_BillDetailSkuCell : UITableViewCell
@property (nonatomic, strong) PackAgeChargeItemListModel *itemListM;
@property (nonatomic, strong) DetailDOModel *detaiM;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
