//
//  WithdrawCashTableViewCell.h
//  POS_develop
//
//  Created by syn on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawCashTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, strong) UIButton *citySelectBtn;
@property (nonatomic, strong) UIButton *totalWithdrawBtn;//全部提现

@property (nonatomic, copy) void(^totalWithdrawClickBlock)(void);
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
