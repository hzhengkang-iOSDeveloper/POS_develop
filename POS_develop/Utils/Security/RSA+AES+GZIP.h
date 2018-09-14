//
//  RSA+AES+GZIP.h
//  HePanDai2_0
//
//  Created by 123 on 2017/3/20.
//  Copyright © 2017年 HePanDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSA_AES_GZIP : NSObject
- (NSString *)returnencryptStringtoString:(NSString *)paramStr andisEncrypt:(NSString *)isEncrypt andisCompress:(NSString *)isCompress;
- (NSString *)returndecryptStringtoString:(NSString *)paramStr andisEncrypt:(BOOL)isEncrypt andisCompress:(BOOL)isCompress;
@end
