//
//  BaseButton.h
//  TripCredit
//
//  Created by sunyanan on 2017/6/17.
//  Copyright © 2017年 sunyanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseButton : UIButton
- (instancetype)initFrameWith:(CGRect)frame  Title:(NSString *)title  Target:(nullable id)target action:(SEL)action;
+ (instancetype)initFrameWith:(CGRect)frame  Title:(NSString *)title  Target:(nullable id)target action:(SEL)action;
@end
