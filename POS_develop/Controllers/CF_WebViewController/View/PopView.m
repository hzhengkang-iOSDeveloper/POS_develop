//
//  PopView.m
//  HePanDai2_0
//
//  Created by anajun on 15/5/6.
//  Copyright (c) 2015年 HePanDai. All rights reserved.
//

#import "PopView.h"

@implementation PopView



+ (instancetype)PopViewWithText:(NSString*)text vertexPoint:(CGPoint)point
{
    PopView *popView = [[PopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    popView.text = text;
    popView.vertexPoint = point;
    
    return popView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.textFont = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self initPopView];
}

- (void)initPopView
{
    CGRect contentRect = [self.text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName: self.textFont} context:nil];
    float originX = self.vertexPoint.x - 100;
    if (originX < 20)
    {
        originX = 20;
    }
    
    if (originX + 200 > ScreenWidth)
    {
        originX = ScreenWidth - 220;
    }
    
    UIImage *image = [UIImage imageNamed:@"arrow_icon@2x"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(self.vertexPoint.x, self.vertexPoint.y, 20, 20);
    [self addSubview:imageView];
    
    CGRect rect;
    rect.origin = CGPointMake(originX, self.vertexPoint.y + 15);
    rect.size = CGSizeMake(210, contentRect.size.height + 20);
    UIView *backView = [[UIView alloc]initWithFrame:rect];
    backView.backgroundColor = UIHexColor(0x5b5c5d);
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake((rect.size.width-contentRect.size.width)/2, 10, contentRect.size.width, contentRect.size.height)];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.numberOfLines = 0;
    textLabel.font = self.textFont;
    textLabel.text = self.text;
    [backView addSubview:textLabel];
    
    [self addSubview:backView];
    
    UITapGestureRecognizer *popViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popViewTap:)];
    [self addGestureRecognizer:popViewTap];
}


- (void)popViewTap:(UIGestureRecognizer*)recognizer
{
    [self removeFromSuperview];
}

- (void)show
{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}


@end
