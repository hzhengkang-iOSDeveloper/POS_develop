//
//  MyAddressTableViewCell.h
//  POS_develop
//
//  Created by sunyn on 2018/9/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAddressTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *telephoneLabel;
@property (nonatomic, strong) UIButton *defaultAddressBtn;
@property (nonatomic, strong) UIButton *editAddressBtn;
@property (nonatomic, strong) UIButton *deleteAddressBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
