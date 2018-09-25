//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
typedef NS_ENUM(int, GradientType){
    GradientTypeHorizontal  =  1,   // 水平
    GradientTypeVertical            // 垂直
};
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

//颜色渐变
- (void)setBtnGradientStartColor:(UIColor *)startColor EndColor:(UIColor *)endColor GradientType:(GradientType)gradientType;

@end
