//
//  SingleShopCarMainCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/22.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleShopCarMainCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *dataArr;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) void (^clickCaluteMoney)(void);
@end

NS_ASSUME_NONNULL_END
