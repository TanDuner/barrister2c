//
//  UIImage+CreateImage.h
//  BeiAi
//
//  Created by Apple on 14-3-11.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CreateImage)

+ (UIImage *)addImage:(UIImage *)image1 andImage:(UIImage *)image2;
+ (UIImage *)snapshotView:(UIView *)theView frame:(CGRect)frame;
+ (UIImage *)getImageFromImage:(UIImage *)sourceImage frame:(CGRect)frame;
+ (UIImage *)imageFromImage:(UIImage *)theImage atFrame:(CGRect)rect;
+ (UIImage *)imageFromView:(UIView *)theView;

@end
