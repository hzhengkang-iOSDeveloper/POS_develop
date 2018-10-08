//
//  BrandIntroductionCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/7.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrandIntroductionCell : UITableViewCell
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGFloat)getCellHeight;
@end

NS_ASSUME_NONNULL_END
