//
//  PD_BillDetailDanDianCell.h
//  POS_develop
//
//  Created by syn on 2018/10/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PD_BillDetailDanDianCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *productArr;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
