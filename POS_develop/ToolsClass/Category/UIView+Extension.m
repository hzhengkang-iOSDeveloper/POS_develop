//
//  UIView+Extension.m
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGSize)size
{
    return self.frame.size;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
-(CGPoint)origin
{
    return self.frame.origin;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

-(CGFloat)centerX
{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

-(CGFloat)centerY
{
    return self.center.y;
}


//MARK:view快速布局
+(UIView *)getViewWithColor:(UIColor *)color
                  superView:(UIView *)superView
                 masonrySet:(void (^)(UIView *view,MASConstraintMaker *make))block {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(view,make);
        }
    }];
    return view;
}

- (void)setBtnGradientStartColor:(UIColor *)startColor EndColor:(UIColor *)endColor GradientType:(GradientType)gradientType {
    //渐变
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,  (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0, @1.0];
    switch (gradientType) {
        case GradientTypeHorizontal:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1.0, 0);
            break;
        case GradientTypeVertical:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1.0);
            break;
    }
    
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
}
@end
