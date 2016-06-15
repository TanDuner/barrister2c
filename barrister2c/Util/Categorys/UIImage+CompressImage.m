//
//  UIImage+CompressImage.m
//  BeiAi
//
//  Created by Apple on 14-3-11.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UIImage+CompressImage.h"

#define MAX_IMAGEPIX           200.0          // max pix 200.0px
#define MAX_IMAGEPIX_WIDTH     640.0          // max pix 200.0px
#define MAX_IMAGEPIX_HEIGHT    960.0          // max pix 200.0px
#define MAX_IMAGEDATA_LEN      204800        // max data length 200K

@implementation UIImage (CompressImage)

+ (UIImage *)compressImageWith:(UIImage *)image width:(float)width height:(float)height
{
	float	imageWidth	= image.size.width;
	float	imageHeight = image.size.height;
    
	float	widthScale	= imageWidth / width;
	float	heightScale = imageHeight / height;
    
	// 创建一个bitmap的context
	// 并把它设置成为当前正在使用的context
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0.0f);
    
	if (widthScale > heightScale) {
		[image drawInRect:CGRectMake(0, 0, imageWidth / heightScale, height)];
	} else {
		[image drawInRect:CGRectMake(0, 0, width, imageHeight / widthScale)];
	}
    
	// 从当前context中创建一个改变大小后的图片
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	// 使当前的context出堆栈
	UIGraphicsEndImageContext();
    
	return newImage;
}

+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
	UIImage *newImage		= nil;
	CGSize	imageSize		= sourceImage.size;
	CGFloat width			= imageSize.width;
	CGFloat height			= imageSize.height;
	CGFloat targetWidth		= defineWidth;
	CGFloat targetHeight	= height / (width / targetWidth);
	CGSize	size			= CGSizeMake(targetWidth, targetHeight);
	CGFloat scaleFactor		= 0.0;
	CGFloat scaledWidth		= targetWidth;
	CGFloat scaledHeight	= targetHeight;
	CGPoint thumbnailPoint	= CGPointMake(0.0, 0.0);
    
	if (CGSizeEqualToSize(imageSize, size) == NO) {
		CGFloat widthFactor		= targetWidth / width;
		CGFloat heightFactor	= targetHeight / height;
        
		if (widthFactor > heightFactor) {
			scaleFactor = widthFactor;
		} else {
			scaleFactor = heightFactor;
		}
        
		scaledWidth = width * scaleFactor;
        
		scaledHeight = height * scaleFactor;
        
		if (widthFactor > heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		} else if (widthFactor < heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
    
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin		= thumbnailPoint;
	thumbnailRect.size.width	= scaledWidth;
	thumbnailRect.size.height	= scaledHeight;
    
	[sourceImage drawInRect:thumbnailRect];
    
	newImage = UIGraphicsGetImageFromCurrentImageContext();
    
	if (newImage == nil) {
		NSLog(@"scale image fail");
	}
    
	UIGraphicsEndImageContext();
	return newImage;
}

- (UIImage *)compressedImage
{
    CGSize imageSize = self.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    if (width <= MAX_IMAGEPIX_WIDTH && height <= MAX_IMAGEPIX_HEIGHT)
    {
        // no need to compress.
        return self;
    }
    
    if (width == 0 || height == 0)
    {
        // void zero exception
        return self;
    }
    
    UIImage *newImage = nil;
    CGFloat widthFactor = MAX_IMAGEPIX_WIDTH / width;
    CGFloat heightFactor = MAX_IMAGEPIX_HEIGHT / height;
    CGFloat scaleFactor = 0.0;
    
    if (widthFactor > heightFactor)
        scaleFactor = heightFactor; // scale to fit height
    else
        scaleFactor = widthFactor; // scale to fit width
    
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0f); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (NSData *)compressedData:(CGFloat)compressionQuality
{
    assert(compressionQuality <= 1.0 && compressionQuality >= 0);
    
    return UIImageJPEGRepresentation(self, compressionQuality);
}

- (CGFloat)compressionQuality
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    NSUInteger dataLength = [data length];
    
    if(dataLength > MAX_IMAGEDATA_LEN)
    {
        return MAX_IMAGEDATA_LEN / dataLength;
    } else
    {
        return 1.0;
    }
}

- (NSData *)compressedData
{
    CGFloat quality = [self compressionQuality];
    
    return [self compressedData:quality];
}

- (NSData *)compressedDataWithQuality:(float)quality
{
    return [self compressedData:quality];
}

- (NSData *)compressedDataWithLength:(float)length
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    NSUInteger dataLength = [data length];
    CGFloat quality = 1.0f;
    
    if(dataLength > length)
    {
        quality =  length / dataLength;
    }
    
    return [self compressedData:quality];
}

@end
