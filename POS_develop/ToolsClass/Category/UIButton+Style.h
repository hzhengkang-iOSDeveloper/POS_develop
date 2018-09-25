//
//  UIButton+Style.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Style)
/**
 按钮布局
 */
+(UIButton *)getButtonWithImageName:(NSString *)imageName
                          titleText:(NSString *)titleStr
                          superView:(UIView *)superView
                         masonrySet:(void (^)(UIButton *btn,MASConstraintMaker *make))block;
@end

NS_ASSUME_NONNULL_END
