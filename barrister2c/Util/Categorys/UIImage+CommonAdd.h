//
//  UIImage+CommonAdd.h
//  peipei
//
//  Created by thinker on 5/6/16.
//  Copyright © 2016 com.58. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(CommonAdd)

+ (UIImage *)safeImageWithData:(NSData *)data;

- (UIImage *)imageByResizeToSize:(CGSize)size;
/**
 *  图片压缩
 */
- (NSData *)zipImageToLength:(NSUInteger)length;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  获取图片特定区域
 */
- (UIImage *)imageByCropToRect:(CGRect)rect;
/**
 *  获取图片中心区域
 */
- (UIImage *)imageResizeByCenter;
@end
