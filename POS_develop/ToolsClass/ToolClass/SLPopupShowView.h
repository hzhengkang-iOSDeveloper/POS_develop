//
//  SLPopupShowView.h
//  Shopping2.0
//
//  Created by soolife_mac_2 on 2017/5/4.
//  Copyright © 2017年 HongHui(Shanghai)Information Technology Service Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLPopupShowView;

@interface SLPopupShowView : UIView

+(SLPopupShowView *)createPopupShowViewWithContentText:(NSString *)titleText buttons:(NSArray *)buttons buttonClick:(void(^)(int index))btnClick;

+(SLPopupShowView *)createPopupShowViewWithHeadingText:(NSString *)headingText ContentText:(NSString *)titleText knowBtnTitle:(NSString *)btnTitle IsShowCloseBtn:(BOOL)isShowCloseBtn IsShowKnowBtn:(BOOL)isShowKnowBtn buttonClick:(void(^)(int index))btnClick;

@end
