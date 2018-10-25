//
//  UpdatePhoneTableViewCell.h
//  POS_develop
//
//  Created by syn on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePhoneTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *getCodeBtn;

@property (nonatomic, copy) void (^getCodeBlock)(void);

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
