//
//  UIImage+Additions.h
//  WXD
//
//  Created by Fantasy on 10/16/14.
//  Copyright (c) 2014 JD.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage (Additions)

+ (UIImage *)createImageWithColor:(UIColor *)color;
- (UIImage *)compressImageToSize:(NSInteger)fileSize;

@end
