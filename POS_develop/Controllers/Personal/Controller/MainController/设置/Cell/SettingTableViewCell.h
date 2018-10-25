//
//  SettingTableViewCell.h
//  POS_develop
//
//  Created by syn on 2018/9/15.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
