//
//  PopView.h
//  HePanDai2_0
//
//  Created by anajun on 15/5/6.
//  Copyright (c) 2015年 HePanDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopView : UIView

@property (nonatomic, assign) CGPoint vertexPoint;
@property (nonatomic, copy) NSString* text;
@property (nonatomic, retain) UIFont* textFont;

+ (instancetype)PopViewWithText:(NSString*)text vertexPoint:(CGPoint)point;

- (void)show;

@end
