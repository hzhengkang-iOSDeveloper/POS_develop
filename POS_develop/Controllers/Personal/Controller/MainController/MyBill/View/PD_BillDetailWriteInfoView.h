//
//  PD_BillDetailWriteInfoView.h
//  POS_develop
//
//  Created by 胡正康 on 2018/11/6.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PD_BillDetailWriteInfoView : UIView
@property (nonatomic, weak) UITextField  *nameTF;
@property (nonatomic, weak) UITextField *orderNoTF;
- (void)hideView;
- (void)showView;
@end

NS_ASSUME_NONNULL_END
