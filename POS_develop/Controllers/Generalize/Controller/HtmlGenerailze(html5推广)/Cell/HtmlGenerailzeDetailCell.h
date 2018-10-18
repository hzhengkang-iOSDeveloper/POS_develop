//
//  HtmlGenerailzeDetailCell.h
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShareH5ReaderModel;
NS_ASSUME_NONNULL_BEGIN

@interface HtmlGenerailzeDetailCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *readTime;
@property (nonatomic, strong) ShareH5ReaderModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
