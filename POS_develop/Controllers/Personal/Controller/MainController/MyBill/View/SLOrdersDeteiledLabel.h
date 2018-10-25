//
//  SLOrdersDeteiledLabel.h
//  Shopping
//
//  Created by chenpeng on 16/5/9.
//  Copyright © 2016年 鸿惠(上海)信息技术服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLOrdersDeteiledLabel : UILabel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *textStr;


@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *textStrLabel;


@property (nonatomic, strong) UIColor *titleStrColor;
@end
