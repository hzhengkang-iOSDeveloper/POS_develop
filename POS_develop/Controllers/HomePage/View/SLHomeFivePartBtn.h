//
//  SLHomeFivePartBtn.h
//  Shopping2.0
//
//  Created by chenpeng on 2018/4/16.
//  Copyright © 2018年 HongHui(Shanghai)Information Technology Service Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selfClick) ();

@class SLAdvModel;

@interface SLHomeFivePartBtn : UIControl

@property (nonatomic, strong) SLAdvModel *model;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, weak) UIImage *holdImage;

@property (nonatomic, copy) selfClick selfClickEcho;

@end
