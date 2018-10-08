//
//  BrandTableViewCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/4.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrandTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *brandLabel;
@property (nonatomic, strong) UIButton *selectBtn;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
