//
//  MyFreeGetCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/23.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyFreeGetCell : UITableViewCell
@property (nonatomic, copy) void (^clickMaxCountHandler)(BOOL isMax);
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
