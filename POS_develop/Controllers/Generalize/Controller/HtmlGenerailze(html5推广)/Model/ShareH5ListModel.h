//
//  ShareH5ListModel.h
//  POS_develop
//
//  Created by sunyn on 2018/10/17.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareH5ListModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *sharePic;
@property (nonatomic, copy) NSString *shareLink;
@property (nonatomic, copy) NSString *shareContent;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@end

NS_ASSUME_NONNULL_END
