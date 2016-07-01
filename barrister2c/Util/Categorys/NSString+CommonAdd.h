//
//  NSString+CommonAdd.h
//  peipei
//
//  Created by thinker on 5/5/16.
//  Copyright © 2016 com.58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(CommonAdd)
/**
 *  格式化对象
 *
 *  @param obj id
 *
 *  @return return NSString
 */
+ (NSString *)formatObject:(id)obj;

+ (NSString *)stringOrNilWithObject:(id)obj;
/**
 *  target 是否包含传参
 *
 *  @param string string description
 *
 *  @return return YES if 包含
 */
- (BOOL)containsString:(NSString *)string;
/**
 *  NSString -> NSData
 *
 *  @return Returns an NSData using UTF-8 encoding
 */
- (NSData *)dataValue;

#pragma mark - Drawing
/**
 *  NSString Size
 *
 *  @param font          UIFont
 *  @param size          CGSize
 *  @param lineBreakMode NSLineBreakMode
 *
 *  @return return CGSize
 */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;
/**
 *  return width of the string with its font
 *
 *  @param font The font to use for computing the string size.
 *
 *  @return return CGFloat
 */
- (CGFloat)widthForFont:(UIFont *)font;
/**
 *  return height of the string height its font
 *
 *  @param font The font to use for computing the string size.
 *  @param width of font
 *
 *  @return return CGFloat
 */
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;


#pragma mark - Separate
/**
 *  格式化字符串 -> 字典 (多个separator时 默认使用首次出现)
 *
 *  @param separator eg =
 *
 *  @return return key value
 */
- (NSDictionary *)dicOfcomponentsSeparatedByString:(NSString *)separator;

#pragma mark - encode
- (NSString *)URLEncode;

@end
