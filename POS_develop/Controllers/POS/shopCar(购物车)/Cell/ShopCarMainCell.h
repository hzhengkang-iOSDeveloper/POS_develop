//
//  ShopCarMainCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/22.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCar_PackageModel;
NS_ASSUME_NONNULL_BEGIN

@interface ShopCarMainCell : UITableViewCell
@property (nonatomic, strong) ShopCar_PackageModel *posRootViewM;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) void (^CaluteMoneyHandler)(void);
@end

NS_ASSUME_NONNULL_END
