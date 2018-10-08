//
//  ZZActionButton.m
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/2/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import "ZZActionButton.h"

@implementation ZZActionButton

// http://stackoverflow.com/questions/8282288/is-willmovetosuperview-called-with-nil-when-removing-a-view-from-a-hierarchy
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        return;
    }
    [super willMoveToSuperview:newSuperview];
    [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click:(ZZActionButton *)button {
    self.clickHandler(); // 回调block
}

+ (instancetype)actionButtonWithType:(UIButtonType)type frame:(CGRect)frame title:(NSString *)title image:(NSString *)imageName clickHandler:(ZZActionButtonClickBlockType)clickHandler {
    CGRect newFrame = frame;
    ZZActionButton *actionButton = [ZZActionButton buttonWithType:type];
    if (imageName) {
        UIImage *image               = [UIImage imageNamed:imageName];
        [actionButton setImage:image forState:UIControlStateNormal];
        
        newFrame = CGRectEqualToRect(frame, CGRectZero) ? CGRectMake(0, 0, image.size.width, image.size.height) : frame;
    }
    
    actionButton.frame = newFrame;
    
    // actionButton.frame        = frame;
    actionButton.clickHandler    = clickHandler;
    [actionButton setTitle:title forState:UIControlStateNormal];
    actionButton.titleLabel.font = F12;
    return actionButton;
}

@end
