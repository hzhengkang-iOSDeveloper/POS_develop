//
//  MJChiBaoZiHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJChiBaoZiHeader.h"

@implementation MJChiBaoZiHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    self.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    self.stateLabel.hidden = YES;
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=20; i++) {
//       // UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"帧-%ld", i]];
//        
//        [idleImages addObject:image];
//    }
     //[self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%ld", i]];
        [refreshingImages addObject:image];
    }
    //[self setImages:refreshingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    //[self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    [self setImages:refreshingImages duration:0.6 forState:MJRefreshStateRefreshing];

}

//gif 转数组、
-(NSMutableArray *)praseGIFDataToImageArray:(NSData *)data;
{
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    CGFloat animationTime = 0.f;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        frames = [NSMutableArray arrayWithCapacity:l];
        for (size_t i = 0; i < l; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (img) {
                [frames addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    return frames;
}
@end
