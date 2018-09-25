//
//  ToastView.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "ToastView.h"
#import "NSString+Drawing.h"

#define kFontSize 15.0

#define kRadius 30
@implementation ToastView

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        CGFloat maxWidth = ScreenWidth - 40 * 2;
        CGSize textSize = [text sizeForFont:F12 size:CGSizeMake(maxWidth, 12 * 3)];
        CGFloat height = textSize.height + 30;
        self.frame = CGRectMake(0, 0, textSize.width + 30 * 2, height);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, textSize.width, height)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.numberOfLines = 0;
        textLabel.font = F12;
        textLabel.text = text;
        textLabel.textColor = [UIColor whiteColor];
        [self addSubview:textLabel];
    }
    return self;
}


/**
 You need to create a new UIView subclass and override its intrinsicContentSize method
 
 固有大小。顾名思义，在AutoLayout中，它作为UIView的属性，意思就是说我知道自己的大小，如果你没有为我指定大小，我就按照这个大小来
 
 @return size
 */

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}


@end
