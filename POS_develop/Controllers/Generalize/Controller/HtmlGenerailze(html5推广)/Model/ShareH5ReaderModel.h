//
//  ShareH5ReaderModel.h
//  POS_develop
//
//  Created by syn on 2018/10/18.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareH5ReaderModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *tbShareH5Id;
@property (nonatomic, copy) NSString *readerNickname;
@property (nonatomic, copy) NSString *readerIcon;
@property (nonatomic, copy) NSString *readerTime;
@property (nonatomic, copy) NSString *readerOpenid;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@end
