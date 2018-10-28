//
//  UITableView+Extension.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/28.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)
/**
 *  数据为0 或加载失败显示无数据样式(文字)
 *
 *  @param rowCount TableView 的 组／行 数
 */
- (void)tableViewNoDataOrNewworkFailShowTitleWithRowCount:(NSInteger)rowCount {
    
    if (rowCount == 0) {
        UILabel *bgLab = [[UILabel alloc] init];
        bgLab.text = @"暂时没有历史记录";
        bgLab.textColor = [UIColor colorWithHexString:@"#666666"];
        bgLab.font = F19;
        bgLab.textAlignment = NSTextAlignmentCenter;
        self.backgroundView = bgLab;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else {
        self.backgroundView = nil;
    }
}
@end
