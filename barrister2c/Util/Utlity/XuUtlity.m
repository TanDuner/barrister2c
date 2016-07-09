//
//  XuUtlity.m
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "XuUtlity.h"
#import <commoncrypto/CommonDigest.h>
#include <CommonCrypto/CommonCryptor.h>
#import <QuartzCore/QuartzCore.h>
#include <sys/sysctl.h>
#include <mach/mach.h>
#include <sys/param.h>
#include <sys/mount.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Reachability.h"
#import "UIImage+CommonAdd.h"

const NSUInteger kDefaultImageDataLength = 80000; //80k

typedef struct PhoneSate PhoneSate;

#define PI 3.1415926

#define Localizable_LF_Size_Bytes                                   @"%lld Bytes"
#define Localizable_LF_Size_K                                       @"%lld K"
#define Localizable_LF_Size_M                                       @"%lld.%lld M"
#define Localizable_LF_Size_G                                       @"%lld.%d G"
#define Localizable_LF_All_Size_M                                   @"%lld.%lld M"
#define Localizable_LF_All_Size_G                                   @"%lld.%lld G"


@implementation XuUtlity

/******************************************************************************
 函数名称 : + (NSString *)stringForAllFileSize:(UInt64)fileSize
 函数描述 : 格式话返回文件大小
 输入参数 : (UInt64)fileSize
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)stringForAllFileSize:(UInt64)fileSize
{
    if (fileSize<1024) {//Bytes/Byte
        if (fileSize>1) {
            return [NSString stringWithFormat:Localizable_LF_Size_Bytes,
                    fileSize];
        }else {//==1 Byte
            return [NSString stringWithFormat:Localizable_LF_Size_Bytes,
                    fileSize];
        }
    }
    if ((1024*1024)>(fileSize)&&(fileSize)>1024) {//K
        return [NSString stringWithFormat:Localizable_LF_Size_K,
                fileSize/1024];
    }
    
    if ((1024*1024*1024)>fileSize&&fileSize>(1024*1024)) {//M
        return [NSString stringWithFormat:Localizable_LF_All_Size_M,
                fileSize/(1024*1024),
                fileSize%(1024*1024)/(1024*102)];
    }
    if (fileSize>(1024*1024*1024)) {//G
        return [NSString stringWithFormat:Localizable_LF_All_Size_G,
                fileSize/(1024*1024*1024),
                fileSize%(1024*1024*1024)/(1024*1024*102)];
    }
    return nil;
}

+ (CGFloat)textHeightWithString:(NSString *)text withFont:(UIFont *)font sizeWidth:(float)width{
    if (width <= 0) {
        return 0;
    }
    
    CGSize size = CGSizeMake(width,2000.0);
    CGSize textsize = [text XuSizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    return textsize.height;
}


+ (CGFloat)textHeightWithString:(NSString *)text withFont:(UIFont *)font sizeWidth:(float)width WithLineSpace:(CGFloat)lineSpace
{
    if (width <= 0) {
        return 0;
    }
    
    NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
    mps.lineBreakMode = NSLineBreakByCharWrapping;
    mps.lineSpacing = lineSpace;
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:  NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : mps}
                                     context:nil].size;

    return size.height;
    
}



+ (CGFloat)textHeightWithStirng:(NSString *)inputString ShowFont:(UIFont *)font TitleFrame:(CGRect)frame
{
    CGSize size = CGSizeMake(frame.size.width,4000);
    CGSize labelsize = [inputString XuSizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    if(labelsize.height>frame.size.height)
    {
        return 	labelsize.height;
    }
    else
    {
        return frame.size.height;
    }
}

+ (CGFloat)textWidthWithStirng:(NSString *)inputString ShowFont:(UIFont *)font sizeHeight:(CGFloat)height
{
    CGSize size = CGSizeMake(4000,height);
    CGSize labelsize = [inputString XuSizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return labelsize.width;
}

+ (NSString*) cleanPhoneNumber:(NSString*)phoneNumber
{
    NSString* number = [NSString stringWithString:phoneNumber];
    NSString* number1 = [[[[number stringByReplacingOccurrencesOfString:@" " withString:@""]
                           stringByReplacingOccurrencesOfString:@"-" withString:@""]
                          stringByReplacingOccurrencesOfString:@"(" withString:@""]
                         stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    return number1;
}

+ (void) makeCall:(NSString *)phoneNumber
{
    //    NSString* numberAfterClear = [Utility cleanPhoneNumber:phoneNumber];
    //    //telprompt可以回调程序
    //    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", numberAfterClear]];
    ////    CardBagAppDelegate *appDelegate = (CardBagAppDelegate*)[[UIApplication sharedApplication] delegate];
    //    HXAppDelegate *appDelegate = (HXAppDelegate*)[[UIApplication sharedApplication] delegate];
    //    [[appDelegate defaultUIWebView] loadRequest:[NSURLRequest requestWithURL:phoneNumberURL]];
    
    NSString* numberAfterClear = [XuUtlity cleanPhoneNumber:phoneNumber];
    //telprompt可以回调程序
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", numberAfterClear]];
    [[UIApplication sharedApplication] openURL:phoneNumberURL];
    
}

+ (void) makeCallPrompt:(NSString *)phoneNumber
{
    NSString* numberAfterClear = [XuUtlity cleanPhoneNumber:phoneNumber];
    //telprompt可以回调程序
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", numberAfterClear]];
    [[UIApplication sharedApplication] openURL:phoneNumberURL];
}


//十进制转十六进制
+ (int) getIntegerFromString:(NSString *)str
{
    int nValue = 0;
    for (int i = 0; i < [str length]; i++)
    {
        int nLetterValue = 0;
        
        if ([str characterAtIndex:i] >='0' && [str characterAtIndex:i] <='9') {
            nLetterValue += ([str characterAtIndex:i] - '0');
        }
        else{
            switch ([str characterAtIndex:i])
            {
                case 'a':case 'A':
                    nLetterValue = 10;break;
                case 'b':case 'B':
                    nLetterValue = 11;break;
                case 'c': case 'C':
                    nLetterValue = 12;break;
                case 'd':case 'D':
                    nLetterValue = 13;break;
                case 'e': case 'E':
                    nLetterValue = 14;break;
                case 'f': case 'F':
                    nLetterValue = 15;break;
                default:nLetterValue = '0';
            }
        }
        
        nValue = nValue * 16 + nLetterValue; //16进制
    }
    return nValue;
}

+ (NSString*)md5:(NSString*)str {
    if (str == nil || [str length] == 0) {
        return str;
    }
    const char*cStr =[str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return[NSString stringWithFormat:
           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15]
           ];
}

#define CHUNK_SIZE 1024
+(NSString *)file_md5:(NSString*) path {
    NSFileHandle* handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if(handle == nil)
        return nil;
    
    CC_MD5_CTX md5_ctx;
    CC_MD5_Init(&md5_ctx);
    
    NSData* filedata;
    do {
        filedata = [handle readDataOfLength:CHUNK_SIZE];
        CC_MD5_Update(&md5_ctx, [filedata bytes], (unsigned int)[filedata length]);
    }
    while([filedata length]);
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(result, &md5_ctx);
    
    [handle closeFile];
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(NSData *)DesEncryptWithKey:(NSData *)key data:(NSData *)data{
    //NSString *key = @"71543729";
    //byte[] IV = { 0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF };
    
    //const void *vplainText;
    //size_t plainTextBufferSize;
    
    NSUInteger dataLength = [data length];
    //vplainText = (const void *) [str UTF8String];
    
    CCCryptorStatus cryptStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes;
    
    bufferPtrSize = dataLength + kCCBlockSizeDES;
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    
    //NSString *initVec = @"init Vec";
    const void *vkey = (const void *) [key bytes];
    //const void *vinitVec = (const void *) [initVec UTF8String];
    
    cryptStatus = CCCrypt(kCCEncrypt,
                          kCCAlgorithmDES,
                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                          vkey,
                          kCCKeySizeDES,
                          NULL,// vinitVec, //"init Vec", //iv,
                          [data bytes],
                          dataLength,
                          (void *)bufferPtr,
                          bufferPtrSize,
                          &movedBytes);
    
    if (cryptStatus == kCCSuccess) {
        //return [NSData dataWithBytes:(const void *)bufferPtr length:movedBytes];
        NSData *resultData = [NSData dataWithBytes:(const void *)bufferPtr length:movedBytes];
        free(bufferPtr); //free the buffer;
        return resultData;
    }
    
    free(bufferPtr); //free the buffer;
    return nil;
}

+(NSData *)DesDecryptWithKey:(NSData *)key data:(NSData *)data{
    
    const void *keyPtr = (const void *) [key bytes];
    
    NSUInteger dataLength = [data length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeDES;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionECBMode +kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeDES, // oorspronkelijk 256
                                          NULL /* initialization vector (optional) */,
                                          [data bytes],
                                          dataLength, /* input */
                                          buffer,
                                          bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
    
    
}


//判断字符串为空
+(BOOL)stringIsNull:(NSString *)str{
    if (str == nil || [str isEqualToString:@""]) {
        return YES;
    }
    else{
        return NO;
    }
}

//判断字符串长度（NSString类型字符串转换成类似ASCII编码的长度，如汉字2个字节，英文以及符号1个字节）
+ (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}

+(NSString *)reverseString:(NSString *)str{
    
    NSUInteger len = [str length];
    NSMutableString *reversedStr = [[NSMutableString alloc] initWithCapacity:len];
    
    while (len > 0)
    {
        [reversedStr appendString:[NSString stringWithFormat:@"%C", [str characterAtIndex:--len]]];
    }
    return reversedStr;
    
}

+(BOOL)ifInvolveStr:(NSString *)str orignString:(NSString*)orignString
{
    if (str) {
        return [orignString rangeOfString:str options:NSCaseInsensitiveSearch].length > 0;
    }
    return NO;
}

+ (NSString *)stringFromDate:(NSDate *)date  forDateFormatterStyle:(DateFormatterStyle)dateFormatterStyle
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    
    if (dateFormatterStyle == DateFormatterDateAndTime) {
        [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
    }
    else if (dateFormatterStyle == DateFormatterDate){
        [formatter setDateFormat:kDEFAULT_DATE_FORMAT];
    }
    else if (dateFormatterStyle == DateFormatterTime){
        [formatter setDateFormat:kDEFAULT_TIME_FORMAT];
    }
    else if (dateFormatterStyle == DateFormatterDateAndTime2){
        [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT2];
    }
    else if (dateFormatterStyle == DateFormatterDateAndTime3){
        [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT3];
    }
    else {
        [formatter setDateFormat:kDEFAULT_DATE_FORMAT];
    }
    
    return [formatter stringFromDate:date];
}

+ (NSNumber *)stringToNumber:(NSString *)string
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [numberFormatter numberFromString:string];
    return number;
}

+ (NSString *)numberToString:(NSNumber *)number{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *string = [numberFormatter stringFromNumber:number];
    return string;
}

+ (NSString *)numberToString:(NSNumber *)number fractionDigits:(NSInteger)fractionDigits{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:fractionDigits];
    [numberFormatter setMinimumFractionDigits:fractionDigits];
    [numberFormatter setMinimumIntegerDigits:1];
    NSString *string = [numberFormatter stringFromNumber:number];
    return string;
}

+(NSString *)changeFloat:(NSString *)stringFloat zeroLength:(NSInteger)len
{
    const char *floatChars = [stringFloat UTF8String];
    NSInteger length = [stringFloat length];
    NSInteger dotPos = 0;
    int i = 0;
    for(; i<length; i++)
    {
        if(floatChars[i] == '.'){
            dotPos = i;
            break;
        }
    }
    
    NSString *returnString;
    if (dotPos < length-len) {
        returnString = [stringFloat substringToIndex:dotPos+len+1];
    }
    else{
        if (dotPos==0) {
            returnString = [NSString stringWithFormat:@"%@.00",stringFloat];
        }
        else{
            NSInteger zoreCount = dotPos + len + 1 - length;
            NSMutableString *appString = [[NSMutableString alloc] initWithCapacity:zoreCount];
            for (int j=0; j<zoreCount; j++) {
                [appString appendString:@"0"];
            }
            returnString = [NSString stringWithFormat:@"%@%@",stringFloat,appString];
        }
    }
    return returnString;
}

+ (NSString *)generateTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *nowData = [NSDate date];
    return [formatter stringFromDate:nowData];
}

+ (NSDate *)NSStringDateToNSDate:(NSString *)string forDateFormatterStyle:(DateFormatterStyle)dateFormatterStyle{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    if (dateFormatterStyle == DateFormatterDateAndTime) {
        [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
    }
    else if (dateFormatterStyle == DateFormatterDate){
        [formatter setDateFormat:kDEFAULT_DATE_FORMAT];
    }
    else if (dateFormatterStyle == DateFormatterTime){
        [formatter setDateFormat:kDEFAULT_TIME_FORMAT];
    }
    else if (dateFormatterStyle == DateFormatterDateAndTime2){
        [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT2];
    }
    else if (dateFormatterStyle == DateFormatterDateAndTime3){
        [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT3];
    }
    else {
        [formatter setDateFormat:kDEFAULT_DATE_FORMAT];
    }
    
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+(NSString *)weekWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
                                          fromDate:date];
    //    NSInteger week = [comps week]; // 今年的第几周
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSString *weekName;
    switch (weekday) {
        case 1:
            weekName = @"星期日";
            break;
            
        case 2:
            weekName = @"星期一";
            break;
            
        case 3:
            weekName = @"星期二";
            break;
            
        case 4:
            weekName = @"星期三";
            break;
            
        case 5:
            weekName = @"星期四";
            break;
            
        case 6:
            weekName = @"星期五";
            break;
            
        case 7:
            weekName = @"星期六";
            break;
            
        default:
            weekName = @"星期日";
            break;
    }
    
    return weekName;
}


+ (NSString *)getMD5FromUrl:(NSString *)url {
    
    if ([XuUtlity stringIsNull:url]) {
        return @"";
    }
    NSArray *array1 = [url componentsSeparatedByString:@"/"];
    if ([array1 count] > 0) {
        NSArray *array2 = [[array1 lastObject] componentsSeparatedByString:@"."];
        
        if ([array2 count] > 0) {
            return [array2 objectAtIndex:0];
        }
    }
    else{
        NSArray *array2 = [url componentsSeparatedByString:@"."];
        
        if ([array2 count] > 0) {
            return [array2 objectAtIndex:0];
        }
    }
    
    return @"";
}

+ (NSString *) trimAllSpaceString:(NSString *)string {
    if (string == nil || [string isEqualToString: @""]) {
        return @"";
    }
    
    NSArray *arrayString = [string componentsSeparatedByString:@" "];
    if([arrayString count]>0){
        NSMutableString *mString = [[NSMutableString alloc] init];
        for (NSString *str in arrayString) {
            if (![string isEqualToString: @" "]) {
                [mString appendString:str];
            }
        }
        return mString;
    }
    else{
        return @"";
    }
}

+ (NSString *) trimLeftSpaceString:(NSString *)string {
    if (string == nil || [string isEqualToString: @""]) {
        return @"";
    }
    
    
    if([string length]>0){
        NSString *subString0 = [string substringToIndex:0];
        if ([subString0 isEqualToString:@" "]) {
            NSString *subString1 = [string substringFromIndex:1];
            return [XuUtlity trimLeftSpaceString:subString1];
        }
        else{
            return string;
        }
    }
    else{
        return @"";
    }
}

+ (NSString *) trimRightSpaceString:(NSString *)string {
    if (string == nil || [string isEqualToString: @""]) {
        return @"";
    }
    
    if([string length]>0){
        NSString *subString0 = [string substringFromIndex:[string length] - 2];
        if ([subString0 isEqualToString:@" "]) {
            NSString *subString1 = [string substringToIndex:[string length] - 2];
            return [XuUtlity trimRightSpaceString:subString1];
        }
        else{
            return string;
        }
    }
    else{
        return @"";
    }
}

+ (NSString *) subString:(NSString *)string length:(NSInteger)len {
    if (string == nil || [string isEqualToString: @""]) {
        return @"";
    }
    
    if([string length] > len){
        return [string substringToIndex:len];
    }
    else{
        return string;
    }
}

+ (NSString *) subStringWithRange:(NSString *)string range:(NSRange)range {
    if (string == nil || [string isEqualToString: @""]) {
        return @"";
    }
    
    if (string.length < range.location) {
        return @"";
    }
    else if([string length] < range.location + range.length){
        return [string substringFromIndex:range.location];
    }
    else{
        return [string substringWithRange:range];
    }
}

+ (NSString *) convertToString:(id)data {
    if (data == nil || data == [NSNull null]) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@", data];
}

+ (BOOL) convertToBool:(id)data {
    if (data == nil || data == [NSNull null]) {
        return NO;
    }
    
    return [data boolValue];
}

+ (NSNumber *) convertToNumber:(id)data {
    if (data == nil || data == [NSNull null]) {
        return 0;
    }
    
    @try {
        return (NSNumber*)data;
    }
    @catch (NSException * e) {
        return 0;
    }
    @finally {
        
    }
}

+ (NSNumber *) convertToNumber:(id)data defaultValue:(NSInteger)defaultValue {
    if (data == nil || data == [NSNull null]) {
        return [NSNumber numberWithInteger:defaultValue];
    }
    
    @try {
        return (NSNumber*)data;
    }
    @catch (NSException * e) {
        return [NSNumber numberWithInteger:defaultValue];
    }
    @finally {
        
    }
}

+ (NSDate *) convertToDate:(id)data {
    if (data==nil) {
        return nil;
    }
    @try {
        NSString *strOrgValue = [XuUtlity convertToString:data];
        
        NSString *strValue = nil;
        NSInteger strLength = [strOrgValue length];
        
        if (strLength >= 8) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            //			[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
            [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];//CTS
            if (strLength >= 16) {
                strValue = strOrgValue;
                [formatter setDateFormat:kDEFAULT_DATE_TIME_FORMAT];
            }
            else if (strLength == 14) {
                strValue = strOrgValue;
                [formatter setDateFormat:@"yyyyMMddHHmmss"];
            }else if (strLength == 10) {
                strValue = strOrgValue;
                [formatter setDateFormat:@"yyyy-MM-dd"];
            } else {
                strValue = [strOrgValue substringToIndex:8];
                [formatter setDateFormat:@"yyyyMMdd"];
            }
            
            NSDate *date = [formatter dateFromString:strValue];
            return date;
        }
        else {
            return [NSDate date];
        }
    }
    @catch (NSException * e) {
        return [NSDate date];
    }
    @finally {
        
    }
}

+ (NSDate *) convertToDate:(id)data forDateFormatter:(NSString *)dateFormatter{
    if (data==nil) {
        return nil;
    }
    @try {
        NSString *strOrgValue = [XuUtlity convertToString:data];
        NSString *strValue = nil;
        if (strOrgValue.length >= dateFormatter.length) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
            strValue = [XuUtlity subString:strOrgValue length:dateFormatter.length];
            [formatter setDateFormat:dateFormatter];
            
            
            NSDate *date = [formatter dateFromString:strValue];
            return date;
        }
        else {
            return [NSDate date];
        }
    }
    @catch (NSException * e) {
        return [NSDate date];
    }
    @finally {
        
    }
}

+ (UIImage *) grayImage:(UIImage *)source
{
    int width = source.size.width;
    int height = source.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  kCGBitmapByteOrderDefault);
    
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), source.CGImage);
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    CGContextRelease(context);
    
    return grayImage;
}

+ (UIImage*)scaleToSize:(UIImage*)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (BOOL) removeSqliteFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *storePath = [documentDirectory stringByAppendingPathComponent:@"CardBag.sqlite"];
    NSError *error = nil;
    
    if ([fileManager fileExistsAtPath:storePath]) {
        if ([fileManager removeItemAtPath:storePath error:&error]){
            NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"CardBag" ofType:@"sqlite"];
            if (defaultStorePath) {
                return [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
            }
        }
    }
    
    return NO;
}

+ (double)getLantAndLongDist:(double)lon1 lat:(double)lat1 lon:(double)lon2 lat:(double)lat2
{
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    return dist;
}

+ (UIImage *)getImageFronSource:(NSString *)imgName Type:(NSString *)imgType
{
    NSString *imgString = [[NSBundle mainBundle] pathForResource:imgName ofType:imgType];
    return [UIImage imageWithContentsOfFile:imgString];
}

+ (BOOL)validateMobile:(NSString *)mobileNum
{
#if 1
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
#else
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
#endif // #if 1
}


+ (BOOL)validateBangBangMobile:(NSString *)mobileNum
{
    NSString * BBPhoneExp = @"(^(0\\d{2,3})?-?([2-9]\\d{6,7})(-\\d{1,5})?$)|(^((\(\\d{3}\))|(\\d{0}))?(13|14|15|17|18)\\d{9}$)|(^(400|800)\\d{7}(-\\d{1,6})?$)|(^(95013)\\d{6,8}$)";
    
    NSPredicate *regextestbb = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BBPhoneExp];
    if ([regextestbb evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }else{
        return NO;
    }
}


+ (NSString*)getMobileOriginalModel
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    return platform;
}

+ (NSString*)getMobileModelCode
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString*)getMobileModel
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([platform isEqualToString:@"iPod6,1"])      return @"iPod Touch (6 Gen)";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch (6 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi 32NM)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (WiFi+4GFDD)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (4GTD)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (WiFi+4GFDD)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2 (4GTD)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (WiFi+4GFDD)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (4GTD)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro (WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro";
    
    if ([platform isEqualToString:@"i386"])         return @"iPhone 5";//@"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"iPhone 5";//@"Simulator";
    return platform;
}

+ (NSString *)appUID
{
    NSString * defaultUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"zp-appUUID"];
    
    if (defaultUID == nil) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        //        defaultUID = [(NSString *) CFUUIDCreateString(NULL, uuid) autorelease];
        defaultUID = CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
        CFRelease(uuid);
        
        //存放到NSUserdefault
        [[NSUserDefaults standardUserDefaults] setObject:defaultUID forKey:@"zp-appUUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return defaultUID == nil ? @"" : defaultUID;
}

// 获取IOS版本信息
+ (NSString*)getIOSVersion
{
    //return [NSString stringWithFormat:@"%@%@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    return [NSString stringWithFormat:@"%@", [[UIDevice currentDevice] systemVersion]];
}

// 获取手机容量
+ (float)getMobileStroageSize
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    struct statfs tStats;
    statfs([[paths lastObject] cString], &tStats);
    float totalSpace = (float)(tStats.f_blocks * tStats.f_bsize);
    
    return totalSpace / 1024 / 1024 / 1024;
}

// 获取手机屏幕分辨率
+ (NSString*)getMobileScreenPixelString
{
    return [NSString stringWithFormat:@"%dx%d", (int)[[UIScreen mainScreen] currentMode].size.width, (int)[[UIScreen mainScreen] currentMode].size.height];
}

+ (BOOL)validateEmail:(NSString *)candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

//获取设备唯一ID
+ (NSString *)getDeviceUid
{
    NSMutableString * result = [[NSMutableString alloc] initWithCapacity:0];
    NSString *macAddress = [self macaddress];
    NSString *boundle = [[NSBundle mainBundle] bundleIdentifier];
    
    [result appendString:macAddress];
    [result appendString:boundle];
    
    return [XuUtlity md5:result];
}

//获得旧时间与当前时差
+ (NSString *)intervalTimeAgo:(NSString *)theDate
{
    if ([XuUtlity stringIsNull:theDate] || theDate.length < 14)
    {
        return @"";
    }
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *d=[date dateFromString:[theDate substringWithRange:NSMakeRange(0, 14)]];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha = now - late;
    
    if (cha < 0)
    {
        return @"0分钟前";
    }
    if (cha/3600 < 1) {
        int mm = cha/60;
        timeString=[NSString stringWithFormat:@"%d分钟前", mm];
        
    }
    if (cha/3600 >= 1 && cha/86400 < 1) {
        int hh = cha/3600;
        //        int mm = (cha-hh*3600)/60;
        //        if (mm > 0)
        //        {
        //            timeString=[NSString stringWithFormat:@"%d小时%d分钟", hh, mm];
        //        }
        //        else
        //        {
        //            timeString=[NSString stringWithFormat:@"%d小时", hh];
        //        }
        timeString=[NSString stringWithFormat:@"%d小时前", hh];
    }
    if (cha/86400 >= 1 && cha/31536000 < 1)
    {
        int dd = cha/86400;
        //        int hh = (cha-dd*86400)/3600;
        //        if (hh > 0)
        //        {
        //            timeString=[NSString stringWithFormat:@"%d天%d小时", dd, hh];
        //        }
        //        else
        //        {
        //            timeString=[NSString stringWithFormat:@"%d天", dd];
        //        }
        timeString=[NSString stringWithFormat:@"%d天前", dd];
    }
    if (cha/31536000 >= 1)
    {
        int yy = cha/31536000;
        timeString=[NSString stringWithFormat:@"%d年前", yy];
    }
    return timeString;
}

+ (NSString *)intervalSinceNow:(NSString *) theDate
{
    if (!theDate || theDate.length < 14)
    {
        return @"";
    }
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *d=[date dateFromString:[theDate substringWithRange:NSMakeRange(0, 14)]];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha = late - now;
    
    if (cha < 0)
    {
        return @"0分钟";
    }
    if (cha/3600<1) {
        int mm = cha/60;
        timeString=[NSString stringWithFormat:@"%d分钟", mm];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        int hh = cha/3600;
        int mm = (cha-hh*3600)/60;
        if (mm > 0)
        {
            timeString=[NSString stringWithFormat:@"%d小时%d分钟", hh, mm];
        }
        else
        {
            timeString=[NSString stringWithFormat:@"%d小时", hh];
        }
    }
    if (cha/86400>1)
    {
        int dd = cha/86400;
        int hh = (cha-dd*86400)/3600;
        if (hh > 0)
        {
            timeString=[NSString stringWithFormat:@"%d天%d小时", dd, hh];
        }
        else
        {
            timeString=[NSString stringWithFormat:@"%d天", dd];
        }
        
    }
    return timeString;
}

+ (BOOL)isToday:(NSDate *)theDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得theDate的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:theDate];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

+ (BOOL)thisYear:(NSDate *)theDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得theDate的年
    NSDateComponents *selfCmps = [calendar components:unit fromDate:theDate];
    
    return (selfCmps.year == nowCmps.year);
}


//获得日期或时间显示用字符串（当天显示时间：15:58，非当天显示日期）
+ (NSString *)formatDateOrTime:(NSDate *)theDate
{
    if ([XuUtlity isToday:theDate])
    {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        
        fmt.dateFormat = @"HH:mm";
        
        NSString *retStr = [fmt stringFromDate:theDate];
        
        return retStr;
    }
    else if ([XuUtlity thisYear:theDate])
    {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        
        fmt.dateFormat = @"MM-dd";
        
        NSString *retStr = [fmt stringFromDate:theDate];
        
        return retStr;
    }
    else
    {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        
        fmt.dateFormat = @"yyyy-MM-dd";
        
        NSString *retStr = [fmt stringFromDate:theDate];
        
        return retStr;
    }
}

+ (NSString*)URLEncode:(NSString *)originalString// stringEncoding:(NSStringEncoding)stringEncoding
{
    
    NSString* escapedUrlString= (NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                      (CFStringRef)originalString,
                                                                                                      NULL,
                                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                      kCFStringEncodingUTF8));
    return escapedUrlString;
}


+ (NSString *)hexStrFromBytes:(NSData *)aData
{
    Byte *bytes = (Byte *)[aData bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[aData length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+(NSData *)hexStrToBytes:(NSString *)hexString { //
    
    NSUInteger length = [hexString length] / 2 + 1;
    char *myBuffer = (char *)malloc((int)length);
    bzero(myBuffer, length);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSData * retData = [NSData dataWithBytes:myBuffer length:length];
    free(myBuffer);
    return retData;
}



#pragma mark -
#pragma mark MAC
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
+ (NSString *) macaddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
    
}

// 去除字符串首位的空格
+ (NSString *)trimSpace:(NSString *)srcStr
{
    return [srcStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (void)playSoundForResource:(NSString *)aFileName type:(NSString *)aType
{
    SystemSoundID soundIDTest;
    NSString * path = [[NSBundle mainBundle] pathForResource:aFileName ofType:aType];
    if (path && path.length>0)
    {
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest );
        AudioServicesPlaySystemSound(soundIDTest);
    }
}

+ (void)addLocalNotificationByName:(NSString *)name alertContent:(NSString *)content afterDelay:(NSTimeInterval)delay
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now = [NSDate date];
        //从现在开始，10秒以后通知
        notification.fireDate = [now dateByAddingTimeInterval:delay];
        //使用本地时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.alertBody = content;
        //通知提示音 使用默认的
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertAction = NSLocalizedString(@"new_localnotification_msg", nil);
        //这个通知到时间时，你的应用程序右上角显示的数字。
        notification.applicationIconBadgeNumber = 0;
        
        if (![XuUtlity stringIsNull:name])
        {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:name, @"imLocalNotification", nil];
            [notification setUserInfo:dict];
        }
        //启动这个通知
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
    }
}

+ (void)removeNotificationByName:(NSString *)name
{
    NSArray *narry = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSUInteger acount = [narry count];
    if (acount < 1)
    {
        return;
    }
    for (int i=0; i<acount; i++)
    {
        UILocalNotification *myUILocalNotification = [narry objectAtIndex:i];
        NSDictionary *userInfo = myUILocalNotification.userInfo;
        NSString *obj = [userInfo objectForKey:@"imLocalNotification"];
        
        if ([name isEqualToString:obj])
        {
            [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
        }
    }
}

+ (NSInteger)judgeNetWorkState
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [r currentReachabilityStatus];
    return status;
}

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (id)parseStringToNumber:(NSString *)sourceStr
{
    if ([XuUtlity isPureFloat:sourceStr] || [XuUtlity isPureInt:sourceStr])
    {
        return [XuUtlity stringToNumber:sourceStr];
    }
    else
    {
        return sourceStr;
    }
}

+ (BOOL)isCallPhone
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType  isEqualToString:@"iPhone"]){
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)trimStringByWidth:(CGFloat)width font:(UIFont *)font string:(NSString *)string
{
    NSString * retStr = @"...";
    NSDictionary *dic = @{NSFontAttributeName: font};
    
    int length = 1;
    while (YES)
    {
        NSMutableString * subStr = [[NSMutableString alloc] initWithCapacity:length + 3];
        [subStr appendString:[string substringToIndex:length]];
        [subStr appendString:@"..."];
        
        CGSize size;
        if (IS_IOS7)
        {
            size = [subStr boundingRectWithSize:CGSizeMake(SCREENWIDTH, 0)
                                        options:(NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                     attributes:dic context:nil].size;
        }
        else
        {
            size = [subStr sizeWithFont:font constrainedToSize:CGSizeMake(SCREENWIDTH, 0)];
        }
        
        if (size.width > width || length >= string.length)
        {
            if (length >= string.length)
            {
                retStr = string;
            }
            break;
        }
        else
        {
            retStr = subStr;
            length++;
        }
    }
    
    return retStr;
}

+ (void)notifySoundOrVibrate
{
    PhoneSate phoneState = [[BaseDataSingleton shareInstance] currentPhoneState];
    if (phoneState.isopensound) {
        [XuUtlity playSoundForResource:@"msg" type:@"mp3"];
    }
    if (phoneState.isopenvibrate) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

+ (BOOL)pushNotifyIsOpened
{
    if (IS_IOS8)
    {
        UIUserNotificationType types = [[[UIApplication sharedApplication] currentUserNotificationSettings] types];
        if (types == UIUserNotificationTypeNone)
        {
            return NO;
        }
        else
        {
            return YES;
        }
        //BOOL ret = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
        //return ret;
    }
    else
    {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        
        if (type == UIRemoteNotificationTypeNone)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
}


+(BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


+(BOOL)isValidArray:(id)object
{
    if ([object isKindOfClass:[NSArray class]] ||[object isKindOfClass:[NSMutableArray class]]) {
        return YES;
    }
    else
    {
        return NO;
    }
}


/**
 *  上传图片之前的压缩
 *
 *  @param soruceImage
 *
 *  @return
 */
+ (NSData *)p_compressImage:(UIImage *)soruceImage
{
    NSData *imageData = UIImageJPEGRepresentation(soruceImage, 1.0);
    
    if (imageData.length <= kDefaultImageDataLength) {
        
        return imageData;
    }
    
    CGSize scaleSize = ({
        
        CGFloat targetWidth = 480;
        CGFloat targetHeight = (targetWidth / soruceImage.size.width) * soruceImage.size.height;
        
        CGSizeMake(targetWidth, targetHeight);
    });
    
    UIImage *zipImage = [soruceImage imageByResizeToSize:scaleSize];
    
    return [zipImage zipImageToLength:kDefaultImageDataLength];

}


@end
