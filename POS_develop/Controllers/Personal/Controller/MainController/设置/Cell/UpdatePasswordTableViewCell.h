//
//  UpdatePasswordTableViewCell.h
//  POS_develop
//
//  Created by syn on 2018/9/15.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePasswordTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *getCodeBtn;

@property (nonatomic, copy) void (^getCodeBlock)(void);

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
