//
//  MyFreeGetCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/23.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class POS_RootViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyFreeGetCell : UITableViewCell
@property (nonatomic, strong) POS_RootViewModel *posRootModel;
@property (nonatomic, copy) void (^clickChangeCountHandler)(BOOL isAdd);
+(instancetype)cellWithTableView:(UITableView *)tableView;

- (void)changeGoodCount;
@end

NS_ASSUME_NONNULL_END
