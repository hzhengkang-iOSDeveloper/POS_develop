//
//  PersonalTableViewCell.h
//  POS_develop
//
//  Created by sunyn on 2018/9/13.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
