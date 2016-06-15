//
//  UIImage+CompressImage.h
//  BeiAi
//
//  Created by Apple on 14-3-11.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CompressImage)

// 压缩
+ (UIImage *)compressImageWith:(UIImage *)image width:(float)width height:(float)height;

+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

- (UIImage *)compressedImage;

- (NSData *)compressedData;

- (CGFloat)compressionQuality;

//指定压缩比例
- (NSData *)compressedDataWithQuality:(float)quality;

//指定压缩后的大小
- (NSData *)compressedDataWithLength:(float)length;

- (NSData *)compressedData:(CGFloat)compressionQuality;

@end
