//
//  CustomImage.m
//  MeZoneB
//
//  Created by d2space on 14-8-6.
//  Copyright (c) 2014年 d2space. All rights reserved.
//

#import "CustomImage.h"

@implementation CustomImage
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    @autoreleasepool
    {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return img;
    }
}
+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)changeImageColor:(UIImage *)sourceImage
{
    NSInteger width = sourceImage.size.width;
    NSInteger height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL)
    {
        return  nil;
    }
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), sourceImage.CGImage);
//    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    UIImage *grayImage = CFBridgingRelease(CGBitmapContextCreateImage(context));
    CGContextRelease(context);
    return grayImage;
}

+ (UIImage *)imageWithOrigin:(UIImage *)image size:(CGSize)size {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, size.width * 8, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context,
                       CGRectMake(0, 0, size.width, size.height),
                       image.CGImage);
    CGImageRef shrunken = CGBitmapContextCreateImage(context);
    UIImage *final = [UIImage imageWithCGImage:shrunken];
    
    CGContextRelease(context);
    CGImageRelease(shrunken);
    
    return final;
}

+ (UIImage *)compressImage:(UIImage *)originImage {
    return [self compressImage:originImage maxSize:1000*1024]; // Byte字节
}

+ (UIImage *)compressImage:(UIImage *)originImage maxSize:(NSUInteger)maxSize {
    NSData *imageData = UIImageJPEGRepresentation(originImage, 1.0);
    CGFloat compress = 1.0; // 压缩比例
    if (imageData.length <= maxSize || maxSize == 0) {
        return originImage;
    } else {
        UIImage *targetImage = [[UIImage alloc] initWithData:imageData];
        while (imageData.length > maxSize) {
            imageData = UIImageJPEGRepresentation(targetImage, (compress = compress - 0.1));
        }
        targetImage = [[UIImage alloc] initWithData:imageData];
        return targetImage;
    }
}

+ (NSData *)compress:(UIImage *)originImage maxSize:(NSUInteger)maxSize{
    NSData *imageData = UIImageJPEGRepresentation(originImage, 1.0);
    CGFloat compress = 1.0; // 压缩比例
    if (imageData.length <= maxSize || maxSize == 0) {
        return imageData;
    } else {
        UIImage *targetImage = [[UIImage alloc] initWithData:imageData];
        while (imageData.length > maxSize) {
            imageData = UIImageJPEGRepresentation(targetImage, (compress = compress - 0.1));
        }
        return imageData;
    }
}
@end
