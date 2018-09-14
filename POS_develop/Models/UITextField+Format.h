//
//  UITextField+Format.h
//  HePanDai2_0
//
//  Created by 123 on 2017/9/2.
//  Copyright © 2017年 HePanDai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HBTextFieldFormatType) {
    kHBTextFieldTypeFormatUnkown = 0, // 未知
    kHBTextFieldTypeFormatBankCard,   // 银行卡号格式
    kHBTextFieldTypeFormatPhoneNO,    // 手机号码格式
    kHBTextFieldTypeFormatIDNO,       // 身份证号码格式
};
@interface UITextField (Format)

@property (nonatomic, assign) HBTextFieldFormatType textFormatType;

- (NSString *)textContainsNoCharset;
@end
