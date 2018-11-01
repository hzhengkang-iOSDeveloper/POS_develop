//
//  BaseSonViewController.h
//  ZNSuperWallet
//
//  Created by 孙亚男 on 2016/10/13.
//  Copyright © 2016年 孙亚男. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseSonViewController : UIViewController

@property (nonatomic, copy) NSString *navigationItemTitle;

@property (nonatomic, copy) NSString *bgimgName;

@property (nonatomic, strong) UIImageView *img;

@property (strong , nonatomic) void (^backHandler)(void);

@property (nonatomic, assign) BOOL isPop;
/**
 *  先pop掉当前VC 然后Push
 *  push ~ 带动画
 */
- (void)baseVC_popOldVCToPushWithVC:(id)VC;
@end
