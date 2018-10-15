//
//  MessageListModel.h
//  POS_develop
//
//  Created by sunyn on 2018/10/15.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageListModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *tbMsgCateId;
@property (nonatomic, copy) NSString *msgTitle;
@property (nonatomic, copy) NSString *msgSummary;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, copy) NSString *msgIcon;
@property (nonatomic, copy) NSString *msgIconUrl;
@property (nonatomic, copy) NSString *msgType;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createusername;
@property (nonatomic, copy) NSString *updateuserno;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *deleteflag;
@end

NS_ASSUME_NONNULL_END
