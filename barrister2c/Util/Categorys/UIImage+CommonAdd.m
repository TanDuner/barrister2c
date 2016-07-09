//
//  UIImage+CommonAdd.m
//  peipei
//
//  Created by thinker on 5/6/16.
//  Copyright © 2016 com.58. All rights reserved.
//

#import "UIImage+CommonAdd.h"

@implementation UIImage(CommonAdd)

+ (UIImage *)safeImageWithData:(NSData *)data {
    UIImage* image = nil;
    static dispatch_once_t onceToken;
    static NSLock* imageLock = nil;
    dispatch_once(&onceToken, ^{
        imageLock = [[NSLock alloc] init];
    });
    
    [imageLock lock];
    image = [UIImage imageWithData:data];
    [imageLock unlock];
    return image;
}

- (UIImage *)imageByResizeToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSData *)zipImageToLength:(NSUInteger)length {
    
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    
    while ([imageData length] > length && compression > maxCompression) {
        
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    
    return imageData;;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageByCropToRect:(CGRect)rect {
    
    rect.origin.x *= self.scale;
    rect.origin.y *= self.scale;
    rect.size.width *= self.scale;
    rect.size.height *= self.scale;
    if (rect.size.width <= 0 || rect.size.height <= 0) return nil;
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return image;
}

- (UIImage *)imageResizeByCenter {
    
    CGSize imageSize = self.size;
    
    CGRect rect = ({
        
        CGFloat resultImgSize = (imageSize.height > imageSize.width) ? imageSize.width: imageSize.height;
        
        CGRectMake((imageSize.width - resultImgSize) / 2, (imageSize.height - resultImgSize) / 2, resultImgSize, resultImgSize);
    });
    
    return [self imageByCropToRect:rect];
}


@end
