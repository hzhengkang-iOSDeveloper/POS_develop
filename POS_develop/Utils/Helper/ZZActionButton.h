//
//  ZZActionButton.h
//  MeZoneB_Bate
//
//  Created by 刘威振 on 12/2/15.
//  Copyright © 2015 Lianbi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZActionButton;

typedef void (^ZZActionButtonClickBlockType)();

@interface ZZActionButton : UIButton

@property (nonatomic, copy) ZZActionButtonClickBlockType clickHandler;
// @property (nonatomic, copy) void (^clickHandler)(ZZActionButton *button);

/**
 *  方便创建ZZActionButton对象
 *
 *  @param type         Button类型
 *  @param frame        Button frame
 *  @param title        title
 *  @param image        图片名字
 *  @param clickHandler 点击回调
 *
 *  @return ZZActionButton对象
 */
+ (instancetype)actionButtonWithType:(UIButtonType)type frame:(CGRect)frame title:(NSString *)title image:(NSString *)imageName clickHandler:(ZZActionButtonClickBlockType)clickHandler;

@end
