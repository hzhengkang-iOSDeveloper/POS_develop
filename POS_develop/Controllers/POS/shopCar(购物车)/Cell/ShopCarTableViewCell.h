//
//  ShopCarTableViewCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/21.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ShopCar_PackageChargeItemModel;
@interface ShopCarTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) ShopCar_PackageChargeItemModel *packageM;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
