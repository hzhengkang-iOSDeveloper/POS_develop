//
//  HDMessageManager.h
//  POS_develop
//
//  Created by 胡正康 on 2018/11/9.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDMessageManager : NSObject
+(instancetype)shareManager;

- (void)LoginHDWithVc:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
