//
//  PosTermTypeListModel.h
//  POS_develop
//
//  Created by syn on 2018/10/21.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PosTermTypeListModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *posTermTypeNo;
@property (nonatomic, copy) NSString *posTermTypeName;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@end
