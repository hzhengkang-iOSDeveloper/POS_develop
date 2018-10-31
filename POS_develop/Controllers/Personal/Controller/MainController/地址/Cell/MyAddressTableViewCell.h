//
//  MyAddressTableViewCell.h
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyAddressViewModel;
@interface MyAddressTableViewCell : UITableViewCell
@property (nonatomic, strong) MyAddressViewModel *addressM;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *telephoneLabel;
@property (nonatomic, strong) UIButton *defaultAddressBtn;
@property (nonatomic, strong) UIButton *editAddressBtn;
@property (nonatomic, strong) UIButton *deleteAddressBtn;
@property (nonatomic, copy) void(^clickDefaultAddBlock)(void);
@property (nonatomic, copy) void(^clickEditAddBlock)(void);
@property (nonatomic, copy) void(^clickDeleteAddBlock)(void);
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
