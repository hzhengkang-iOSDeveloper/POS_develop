//
//  HomeTableViewCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/22.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
@property (nonatomic, strong)  UIImageView *bgImg;
@property (nonatomic, strong)  UILabel *label;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
