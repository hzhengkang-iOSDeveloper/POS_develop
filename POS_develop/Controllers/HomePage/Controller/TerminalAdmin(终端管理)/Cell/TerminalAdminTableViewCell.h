//
//  TerminalAdminTableViewCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/2.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TerminalAdminTableViewCell : UITableViewCell
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *delegateName;
@property (nonatomic, strong) UILabel *delegateAccount;
@property (nonatomic, copy) void (^clickSelectBtnHandler)(void);
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
