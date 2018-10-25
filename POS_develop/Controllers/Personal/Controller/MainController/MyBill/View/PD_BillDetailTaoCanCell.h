//
//  PD_BillDetailTaoCanCell.h
//  POS_develop
//
//  Created by syn on 2018/10/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailDOModel;
@interface PD_BillDetailTaoCanCell : UITableViewCell
@property (nonatomic, strong) DetailDOModel *detailDoM;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
