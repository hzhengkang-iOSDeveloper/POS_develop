//
//  POSRootCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/10.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class POS_RootViewModel;
NS_ASSUME_NONNULL_BEGIN

@interface POSRootCell : UITableViewCell
@property (nonatomic, strong) POS_RootViewModel *posRootModel;
@property (nonatomic, copy) void (^addShopCarHandler)(void);


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
