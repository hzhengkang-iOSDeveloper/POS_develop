//
//  SLRefreshFooter.m
//  Shopping2.0
//
//  Created by soolife_mac_2 on 2017/9/22.
//  Copyright © 2017年 HongHui(Shanghai)Information Technology Service Co.,Ltd. All rights reserved.
//

#import "SLRefreshFooter.h"

@interface SLRefreshFooter()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *refreshImgView;

@end

@implementation SLRefreshFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    
    //设置控件的高度
    self.mj_h = AD_HEIGHT(50);
    //添加label
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = C989898;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = F12;
    [self addSubview:self.titleLabel];
    //添加图片
    self.refreshImgView = [[UIImageView alloc]init];
    self.refreshImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.refreshImgView];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
    self.refreshImgView.frame = CGRectMake(AD_WIDTH(172.5), 0, AD_WIDTH(30), AD_HEIGHT(30));
    self.refreshImgView.centerX = self.centerX;
    self.titleLabel.frame = CGRectMake(0, AD_HEIGHT(25), self.width, AD_HEIGHT(15));
}

-(void)startImageViewAnimation {
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:6];
    for (int i = 1; i < 7; i++) {
        [arrayM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"home_refresh%d",i]]];
    }
    //设置动画数组
    [self.refreshImgView setAnimationImages:arrayM];
    //设置动画播放次数
    [self.refreshImgView setAnimationRepeatCount:100];
    //设置动画播放时间
    [self.refreshImgView setAnimationDuration:0.5];
    //开始动画
    [self.refreshImgView startAnimating];
}

-(void)stopImageViewAnimation {
    if ([self.refreshImgView isAnimating]) {
        [self.refreshImgView stopAnimating];
    }
}

-(void)endRefreshing {
    [super endRefreshing];
    [self stopImageViewAnimation];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
        {
            self.titleLabel.hidden = YES;
            self.refreshImgView.image = ImageNamed(@"home_refresh1");
            [self stopImageViewAnimation];
        }
            break;
        case MJRefreshStateRefreshing:
        {
            self.titleLabel.hidden = YES;
            [self startImageViewAnimation];
        }
            break;
        case MJRefreshStateNoMoreData:
        {
            [self stopImageViewAnimation];
            self.refreshImgView.image = ImageNamed(@"home_end");
            self.titleLabel.hidden = NO;
            self.titleLabel.text = @"直到世界尽头";
        }
            break;
        default:
            break;
    }
}

@end
