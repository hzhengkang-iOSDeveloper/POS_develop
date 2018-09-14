//
//  CustomImage.h
//  MeZoneB
//
//  Created by d2space on 14-8-6.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomImage : NSObject
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)changeImageColor:(UIImage *)sourceImage;
+ (UIImage *)imageWithView:(UIView *)view;

/**
 *  对image尺寸调整
 *
 *  @param image 原始image
 *  @param size  要调整的尺寸
 *
 *  @return 重新调整尺寸后的image对象
 */
+ (UIImage *)imageWithOrigin:(UIImage *)image size:(CGSize)size;

/**
 *  压缩图片(默认最大为500k Byte)
 *
 *  @param originImage 原始图片
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)compressImage:(UIImage *)originImage;

/**
 *  压缩图片
 *
 *  @param originImage 原始图片
 *  @param maxSize     最大字节数
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)compressImage:(UIImage *)originImage maxSize:(NSUInteger)maxSize;

/**
 *  压缩图片
 *
 *  @param originImage 原始图片
 *  @param maxSize     最大字节数
 *
 *  @return 压缩后的图片
 */
+ (NSData *)compress:(UIImage *)originImage maxSize:(NSUInteger)maxSize;

@end
