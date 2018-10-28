//
//  UITableView+Extension.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/28.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Extension)
/**
 *  数据为0 或加载失败显示无数据样式(文字)
 *
 *  @param rowCount TableView 的 组／行 数
 */
- (void)tableViewNoDataOrNewworkFailShowTitleWithRowCount:(NSInteger)rowCount;
@end

NS_ASSUME_NONNULL_END
