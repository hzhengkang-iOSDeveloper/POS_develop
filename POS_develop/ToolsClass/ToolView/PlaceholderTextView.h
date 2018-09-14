//
//  PlaceholderTextView.h
//  XiaoMei
//
//  Created by PingTou on 15/11/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView


@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, strong) UIFont *placeholderFont;

@property (nonatomic, strong) UILabel *placeholderLabel;

@end
