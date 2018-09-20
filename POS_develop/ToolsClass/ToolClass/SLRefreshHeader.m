//
//  SLRefreshHeader.m
//  Shopping2.0
//
//  Created by 邝子涵 on 2017/3/9.
//  Copyright © 2017年 HongHui(Shanghai)Information Technology Service Co.,Ltd. All rights reserved.
//

#import "SLRefreshHeader.h"

@implementation SLRefreshHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 自动改变透明度
        self.automaticallyChangeAlpha = YES;
        // 隐藏时间
//        self.lastUpdatedTimeLabel.hidden = YES;
        
        // 设置各种状态下的刷新文字
        [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
        [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        
        // 设置字体
        self.stateLabel.font = F12;
        self.lastUpdatedTimeLabel.font = F12;
        
        // 设置颜色
        self.stateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        self.lastUpdatedTimeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        
        //初始化时开始刷新
//        [self beginRefreshing];
    }
    return self;
}

@end
