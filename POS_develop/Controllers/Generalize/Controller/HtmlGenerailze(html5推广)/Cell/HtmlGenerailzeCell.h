//
//  HtmlGenerailzeCell.h
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HtmlGenerailzeCell : UITableViewCell
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *seeDetailBtn;
@property (nonatomic, copy) void(^seeDetailBlock)(void);
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
