//
//  BrandIntroductionModel.h
//  POS_develop
//
//  Created by sunyn on 2018/10/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrandIntroductionModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *posBrandNo;
@property (nonatomic, copy) NSString *posBrandName;
@property (nonatomic, copy) NSString *posBrandDesc;
@property (nonatomic, copy) NSString *sortIndex;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@end

NS_ASSUME_NONNULL_END
