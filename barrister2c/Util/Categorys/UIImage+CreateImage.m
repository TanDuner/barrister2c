//
//  UIImage+CreateImage.m
//  BeiAi
//
//  Created by Apple on 14-3-11.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UIImage+CreateImage.h"

@implementation UIImage (CreateImage)

+ (UIImage *)addImage:(UIImage *)image1 andImage:(UIImage *)image2
{
	UIGraphicsBeginImageContextWithOptions(image1.size, NO, 0.0f);
    
	// Draw image1
	[image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
	// Draw image2
	[image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
	return resultingImage;
}

+ (UIImage *)snapshotView:(UIView *)theView frame:(CGRect)frame
{
	UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, 0.0f);
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	[theView.layer renderInContext:context];
    
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
	return image;
}

+ (UIImage *)getImageFromImage:(UIImage *)sourceImage frame:(CGRect)frame
{
	CGImageRef	imageRef	= sourceImage.CGImage;
	CGImageRef	subImageRef = CGImageCreateWithImageInRect(imageRef, frame);
	CGSize		size		= frame.size;
    
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextDrawImage(context, frame, subImageRef);
	UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
	UIGraphicsEndImageContext();
	CGImageRelease(subImageRef);
	return smallImage;
}

+ (UIImage *)imageFromImage:(UIImage *)theImage atFrame:(CGRect)rect
{
    CGSize subImageSize = CGSizeMake(rect.size.width * [UIScreen mainScreen].scale, rect.size.height * [UIScreen mainScreen].scale);
    CGRect subRect = CGRectMake(rect.origin.x * [UIScreen mainScreen].scale, rect.origin.y * [UIScreen mainScreen].scale, rect.size.width * [UIScreen mainScreen].scale, rect.size.height * [UIScreen mainScreen].scale);
    // 定义裁剪的区域相对于原图片的位置
    CGImageRef imageRef = theImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect/*subRect*/);
    UIGraphicsBeginImageContextWithOptions(subImageSize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subRect, subImageRef);
    UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    // 返回裁剪的部分图像
    return subImage;
}

+ (UIImage *)imageFromView:(UIView *)theView
{
	// draw a view's contents into an image context
	UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, 0.0);
	CGContextRef context = UIGraphicsGetCurrentContext();
	[theView.layer renderInContext:context];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end
