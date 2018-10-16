//
//  PackageChargeListModel.h
//  POS_develop
//
//  Created by sunyn on 2018/10/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackageChargeListModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *packageName;
@property (nonatomic, copy) NSString *packagePrice;
@property (nonatomic, copy) NSString *packagePic;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@property (nonatomic, strong) NSArray *packageChargeItemDOList;
@end

NS_ASSUME_NONNULL_END
