//
//  NSDate+PosTool.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/26.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (PosTool)
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger year;
@end

NS_ASSUME_NONNULL_END
