//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@interface UIView (Extension)
@property(nonatomic, assign)CGFloat x;
@property(nonatomic, assign)CGFloat y;
@property(nonatomic, assign)CGFloat width;
@property(nonatomic, assign)CGFloat height;
@property(nonatomic, assign)CGSize size;
@property(nonatomic, assign)CGPoint origin;
@property(nonatomic, assign)CGFloat centerX;
@property(nonatomic, assign)CGFloat centerY;

/**
 布局
 */
+(UIView *)getViewWithColor:(UIColor *)color
                  superView:(UIView *)superView
                 masonrySet:(void (^)(UIView *view,MASConstraintMaker *make))block;
@end
