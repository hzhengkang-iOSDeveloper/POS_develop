//
//  PD_BillDetailUnCheckView.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/28.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayDOModel;
NS_ASSUME_NONNULL_BEGIN

@interface PD_BillDetailUnCheckView : UIView
@property (nonatomic, strong) PayDOModel *payDoM;
@property (nonatomic, copy) void (^comfirSaveInfoHandler)(NSDictionary *dict);
@end

NS_ASSUME_NONNULL_END
