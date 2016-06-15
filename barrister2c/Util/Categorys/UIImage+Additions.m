//
//  UIImage+Additions.m
//  WXD
//
//  Created by Fantasy on 10/16/14.
//  Copyright (c) 2014 JD.COM. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)compressImageToSize:(NSInteger)fileSize
{
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSUInteger maxFileSize = fileSize * 1024;
    
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}

@end
