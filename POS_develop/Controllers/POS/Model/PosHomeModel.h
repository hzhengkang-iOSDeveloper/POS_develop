//
//  PosHomeModel.h
//  POS_develop
//
//  Created by 胡正康 on 2018/11/3.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 activationType = 0;
 chargeType = 0;
 createtime = "2018-10-02 11:04:04";
 createusername = "<null>";
 deleteflag = 0;
 id = 3;
 posBrandName = "\U6d4b\U8bd5\U4f7f\U7528";
 posBrandNo = testa1;
 posCount = 1;
 posPrice = 500;
 posRebatePrice = 50;
 posSnNo = 00000003;
 posTermModel = testing1;
 posTermType = "\U5927\U578b";
 productImg = "/files/5050fdc5-7547-42e1-b0e0-add42b8a05b2.jpg";
 productName = "";
 updatetime = "2018-11-03 22:07:22";
 updateuserno = "<null>";
 */


NS_ASSUME_NONNULL_BEGIN

@interface PosHomeModel : NSObject
@property (nonatomic, copy) NSString *activationType;
@property (nonatomic, copy) NSString *chargeType;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *posBrandName;
@property (nonatomic, copy) NSString *posBrandNo;
@property (nonatomic, copy) NSString *posCount;
@end

NS_ASSUME_NONNULL_END
