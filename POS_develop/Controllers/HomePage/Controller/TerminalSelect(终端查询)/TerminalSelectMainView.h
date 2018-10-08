//
//  TerminalSelectMainView.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TerminalSelectMainView : UIView
@property (weak, nonatomic) IBOutlet UILabel *isActivationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UITextField *delegateNameTF;//代理商名字
@property (weak, nonatomic) IBOutlet UITextField *platformAccountTF;//平台账号
@property (weak, nonatomic) IBOutlet UITextField *snStartTF;
@property (weak, nonatomic) IBOutlet UITextField *snEndTF;
@property (weak, nonatomic) IBOutlet UITextField *activationEndTF;
@property (weak, nonatomic) IBOutlet UITextField *activationStartTF;

@property (nonatomic, copy) void (^brandBlock)(NSString *selectedStr);//机器品牌
@property (nonatomic, copy) void (^typeBlock)(NSString *selectedStr);//机器类型
@property (nonatomic, copy) void (^modelBlock)(NSString *selectedStr);//机器型号
@property (nonatomic, copy) void (^isActivationBlock)(NSString *selectedStr);//是否激活
@end

NS_ASSUME_NONNULL_END
