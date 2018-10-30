//
//  SingleShopCarCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/21.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ShopCar_ProductModel;
NS_ASSUME_NONNULL_BEGIN

@interface SingleShopCarCell : UITableViewCell
@property (nonatomic, strong) ShopCar_ProductModel *productM;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) void (^clickSelectedBtn)(void);

@end

NS_ASSUME_NONNULL_END
