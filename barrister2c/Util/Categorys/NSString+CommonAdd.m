//
//  NSString+CommonAdd.m
//  peipei
//
//  Created by thinker on 5/5/16.
//  Copyright © 2016 com.58. All rights reserved.
//

#import "NSString+CommonAdd.h"

@implementation NSString(CommonAdd)

- (BOOL)containsString:(NSString *)string {
    
    if (![string isKindOfClass:[NSString class]]) return NO;
    
    if (string == nil) return NO;
    
    return [self rangeOfString:string].location != NSNotFound;
}
+ (NSString *)stringOrNilWithObject:(id)obj {

    return IS_NOT_EMPTY(obj) ? obj: nil;
}

- (NSData *)dataValue {
    
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    
    // 向上取整
    result.height = ceil(result.height);
    result.width = ceil(result.width);
    
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return ceil(size.width);
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return ceil(size.height);
}

+ (NSString *)formatObject:(id)obj {
    
    return [NSString stringWithFormat:@"%@", obj];
}


#pragma mark - Separate
- (NSDictionary *)dicOfcomponentsSeparatedByString:(NSString *)separator {
    
    if (!IS_NOT_EMPTY(separator)) {
        
        return nil;
    }
    
    NSMutableArray <NSString *> *components = [[self componentsSeparatedByString:separator] mutableCopy];
    
    if (components.count >= 2) {
        
        [components enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx > 1) {
                
                components[1] = [NSString stringWithFormat:@"%@=%@", components[1], components[idx]];
            }
        }];
        
        NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        if (IS_NOT_EMPTY([components firstObject])) {
            
            resultDic[[NSString stringWithFormat:@"%@", [components firstObject]]] = [NSString stringWithFormat:@"%@", components[1]];
        }
        
        return resultDic;
    }
    
    return nil;
}

// 适用于charset为utf-8的情况
- (NSString *)URLEncode
{
    NSString *newString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes
                                             (kCFAllocatorDefault,
                                              (CFStringRef)self,
                                              NULL,
                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),
                                              CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    if (newString)
    {
        return newString;
    }
    return @"";
}
@end
