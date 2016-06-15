//
//  NSString+Addition.m
//  BeiAi
//
//  Created by Apple on 14-3-11.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

+ (NSString *)randomStringWithLength:(int)length
{
    char codeList[] = "0123456789abcdefghijklmnopqrstuvwxyz";
    NSMutableString *randomString = [[NSMutableString alloc] init];
    for (int i = 0; i < length; i++) {
        char codeIndex = arc4random() % 26;
        [randomString appendString:[NSString stringWithFormat:@"%c", codeList[codeIndex]]];
    }
    
    return randomString;
}

// 字符串转换成十六进制
+ (NSString *)stringToHex:(const char *)key len:(NSUInteger)len
{
    static char hex[1024];
    char buffer[8];
    for(unsigned n=0; n < len ; ++n) {
        sprintf(buffer, "%02x", (unsigned char)key[n]);
        hex[2*n]=buffer[0];
        hex[2*n+1]=buffer[1];
    }
    hex[len*2]='\0';
    
    return [NSString stringWithUTF8String:hex];
}

+ (NSString *)stringWithOutSpace:(NSString *)str  //去除两边的空格
{
    if(!str)
        return nil;
        
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)isInt:(NSString *)str
{
    NSScanner* scan = [NSScanner scannerWithString:str];
    int iVal;
    return[scan scanInt:&iVal] && [scan isAtEnd];
}

+ (BOOL)isFloat:(NSString *)str
{
    NSScanner* scan = [NSScanner scannerWithString:str];
    float fVal;
    return[scan scanFloat:&fVal] && [scan isAtEnd];
}

+ (BOOL)isEmptyOrNull:(NSString *)str
{
	if (!str) {
		return YES;
	} else {
		NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
		if ([trimedString length] == 0) {
			// empty string
			return YES;
		} else {
			// is neither empty nor null
			return NO;
		}
	}
}

+ (NSString *)getPromptStringWithCode:(long)aCode
{
	NSNumberFormatter	*numberFormatter	= [[NSNumberFormatter alloc] init];
	NSNumber			*num				= [[NSNumber alloc] initWithLong:aCode];
	NSString			*numberString		= [numberFormatter stringFromNumber:num];
    
	NSString *string = NSLocalizedString(numberString, nil);
	return string;
}

+ (NSString *)getPromptStringWithNumber:(NSNumber *)aNumber
{
	if (!aNumber) {
		return @"error";
	}
    
	NSNumberFormatter	*numberFormatter	= [[NSNumberFormatter alloc] init];
	NSString			*numberString		= [numberFormatter stringFromNumber:aNumber];
    
	NSString *string = NSLocalizedString(numberString, nil);
	return string;
}

+ (NSString *)getStringWithString:(NSString *)aString
{
	NSString *string = NSLocalizedString(aString, nil);
    
	return string;
}

- (NSData*)hexToBytes {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
-(NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (CGSize)XuSizeWithFont:(UIFont *)font
{
    CGSize textSize = CGSizeZero;
    if (IS_IOS7)
    {
        textSize = [self sizeWithAttributes:@{ NSFontAttributeName : font }];
    }else{
        textSize = [self sizeWithFont:font];
    }
    return textSize;
}

- (CGSize)XuSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize textSize = CGSizeZero;
    if (IS_IOS7)
    {
        textSize = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : font } context:nil].size;
    }else{
        textSize = [self sizeWithFont:font constrainedToSize:size];
    }
    //textSize = [self sizeWithFont:font constrainedToSize:size];
    return textSize;
}

- (CGSize)XuSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize textSize = CGSizeZero;
    if (IS_IOS7)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        textSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
        textSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
    }
    
    return textSize;
}

- (CGSize)imSizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self XuSizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:lineBreakMode];
}


@end
