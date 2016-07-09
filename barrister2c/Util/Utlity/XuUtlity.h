//
//  XuUtlity.h
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd HH:mm:ss")
#define kDEFAULT_DATE_FORMAT (@"yyyy-MM-dd")
#define kDEFAULT_TIME_FORMAT (@"HH:mm")
#define kDEFAULT_DATE_TIME_FORMAT2 (@"yyyyMMddHHmmss")
#define kDEFAULT_DATE_TIME_FORMAT3 (@"yyyy-MM-dd HH:mm")


typedef enum {
    DateFormatterDateAndTime,
    DateFormatterDate,
    DateFormatterTime,
    DateFormatterDateAndTime2,
    DateFormatterDateAndTime3
} DateFormatterStyle;

//网络类型状态 3g wifi
typedef enum
{
    NET_WIFI = 1,       //wifi网络
    NET_3G,             //3g网路
    NET_NONE            //无网络
}NetWorkType;


@interface XuUtlity : NSObject

//格式话返回文件大小
+ (NSString *)stringForAllFileSize:(UInt64)fileSize;

+ (CGFloat)textHeightWithString:(NSString *)text withFont:(UIFont *)font sizeWidth:(float)width;
+ (CGFloat)textHeightWithString:(NSString *)text withFont:(UIFont *)font sizeWidth:(float)width WithLineSpace:(CGFloat)lineSpace;
+ (CGFloat)textHeightWithStirng:(NSString *)inputString ShowFont:(UIFont *)font TitleFrame:(CGRect)frame;
+ (CGFloat)textWidthWithStirng:(NSString *)inputString ShowFont:(UIFont *)font sizeHeight:(CGFloat)height;

//清除电话号码中无用字符
+ (NSString*) cleanPhoneNumber:(NSString*)phoneNumber;
//拨打电话
+ (void) makeCall:(NSString *)phoneNumber;
//telprompt可以回调原程序
+ (void) makeCallPrompt:(NSString *)phoneNumber;
//十进制转十六进制
+ (int) getIntegerFromString:(NSString *)str;
//生成字符串的MD5字符串
+ (NSString*)md5:(NSString*)str;
//生成文件的md5值
+(NSString *)file_md5:(NSString*) path;
//des加密
+(NSData *)DesEncryptWithKey:(NSData *)key data:(NSData *)data;
//des解密
+(NSData *)DesDecryptWithKey:(NSData *)key data:(NSData *)data;

//判断字符串为空
+(BOOL)stringIsNull:(NSString *)str;
//判断字符串长度（NSString类型字符串转换成类似ASCII编码的长度，如汉字2个字节，英文以及符号1个字节）
+ (int)convertToInt:(NSString*)strtemp;
//反转字符串  "123" -->"321"
+(NSString *)reverseString:(NSString *)str;
//格式化时间
+ (NSString *)stringFromDate:(NSDate *)date forDateFormatterStyle:(DateFormatterStyle)dateFormatterStyle;
//字符串转数字
+ (NSNumber *)stringToNumber:(NSString *)string;
//数字转字符串
+ (NSString *)numberToString:(NSNumber *)number;
////数字转字符串,保留有效小数位
+ (NSString *)numberToString:(NSNumber *)number fractionDigits:(NSInteger)fractionDigits;
//float后面无效的0
+(NSString *)changeFloat:(NSString *)stringFloat zeroLength:(NSInteger)len;
//获取时间戳
+ (NSString *)generateTimestamp;\
//字符串转日期
+(NSDate *)NSStringDateToNSDate:(NSString *)string  forDateFormatterStyle:(DateFormatterStyle)dateFormatterStyle;
//获得星期几
+(NSString *)weekWithDate:(NSDate *)date;
//是否包含字符串
+(BOOL)ifInvolveStr:(NSString *)str orignString:(NSString*)orignString;
//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;
//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string;
/**
 *  将字符串转换为NSNumber，若字符串不是纯数字，则返回字符串本身
 *
 *  @param sourceStr 字符串
 *
 *  @return NSNumber or NSString
 */
+ (id)parseStringToNumber:(NSString *)sourceStr;
/**
 * 判断当前设备是否能拨打电话
 **/
+ (BOOL)isCallPhone;
//根据文件名获取MD5
+ (NSString *) getMD5FromUrl:(NSString *)url;
//去掉字符串中所有空格
+ (NSString *) trimAllSpaceString:(NSString *)string;


+ (NSString *) trimLeftSpaceString:(NSString *)string;
+ (NSString *) trimRightSpaceString:(NSString *)string;

+ (NSString *) subString:(NSString *)string length:(NSInteger)len;
+ (NSString *) subStringWithRange:(NSString *)string range:(NSRange)range;
//
+ (NSString *) convertToString:(id)data;
+ (NSNumber *) convertToNumber:(id)data;
+ (NSNumber *) convertToNumber:(id)data defaultValue:(NSInteger)defaultValue;
+ (NSDate *) convertToDate:(id)data;
+ (NSDate *) convertToDate:(id)data forDateFormatter:(NSString *)dateFormatter;
+ (BOOL) convertToBool:(id)data;

// Remove CoreData Sqlite File
+ (BOOL) removeSqliteFile;

+ (UIImage *) grayImage:(UIImage *)source;
+ (UIImage*)scaleToSize:(UIImage*)img size:(CGSize)size;
//地图两点之间距离
+ (double)getLantAndLongDist:(double)lon1 lat:(double)lat1 lon:(double)lon2 lat:(double)lat2;

// 判断手机号是否合法
+ (BOOL)validateMobile:(NSString *)mobileNum;

+ (BOOL)validateBangBangMobile:(NSString *)mobileNum;

// 判断邮箱是否合法
+ (BOOL)validateEmail:(NSString *)candidate;

// 获取手机型号
+ (NSString*)getMobileOriginalModel;

+ (NSString*)getMobileModelCode;

+ (NSString*)getMobileModel;

// 获取设备UID
+ (NSString *)appUID;

// 获取IOS版本信息
+ (NSString*)getIOSVersion;

// 获取手机容量
+ (float)getMobileStroageSize;

// 获取手机屏幕分辨率
+ (NSString*)getMobileScreenPixelString;

//获取设备唯一ID
+ (NSString *)getDeviceUid;

//获得旧时间与当前时差
+ (NSString *)intervalTimeAgo:(NSString *)theDate;

//获得将来时间与当前时间差
+ (NSString *)intervalSinceNow:(NSString *) theDate;

//获得日期或时间显示用字符串（当天显示时间：15:58，非当天显示日期）
+ (NSString *)formatDateOrTime:(NSDate *)theDate;

//URLEncode with UTF-8
+ (NSString*)URLEncode:(NSString *)originalString;

// Return the local MAC addy
+ (NSString *) macaddress;

// 去除字符串首位的空格
+ (NSString *)trimSpace:(NSString *)srcStr;

/*
 * author: chixk
 * 播放声音： <30秒
 * aFileName：文件名，不含路径   aType：mp3,wav,....
 */
+ (void)playSoundForResource:(NSString *)aFileName type:(NSString *)aType;

/**
 *  添加本地通知
 *
 *  @param name    通知名字（取消通知时使用）
 *  @param content 通知内容
 *  @param delay   通知延时的秒数
 */
+ (void)addLocalNotificationByName:(NSString *)name alertContent:(NSString *)content afterDelay:(NSTimeInterval)delay;

/**
 *  取消未触发的本地通知
 *
 *  @param name 通知名字
 */
+ (void)removeNotificationByName:(NSString *)name;

/**
 *
 *  判断当前网络类型
 **/

+ (NSInteger)judgeNetWorkState;

/**
 *  根据区域宽度和字体截断字符串并添加省略号
 *
 *  @param width  区域宽度
 *  @param font   字体
 *  @param string 源字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)trimStringByWidth:(CGFloat)width font:(UIFont *)font string:(NSString *)string;

/**
 *  二进制转换成16进制
 *
 *  @param aData 二进制数据
 *
 *  @return 十六进制返回值
 */
+ (NSString *)hexStrFromBytes:(NSData *)aData;

/**
 *  十六进制转换成二进制数据
 *
 *  @param hexString 十六进制数据
 *
 *  @return 二进制数据返回值
 */
+ (NSData *)hexStrToBytes:(NSString *)hexString;

/**
 *  播放声音或震动提醒
 */
+ (void)notifySoundOrVibrate;

/**
 *  检查推送功能是否开启
 *
 *  @return 开启时返回YES，否则返回NO
 */
+ (BOOL)pushNotifyIsOpened;


/**
 *  检测是否是数字
 */

+(BOOL)validateNumber:(NSString*)number;


/**
 *  判断是否是有效的数组
 *
 *  @param object
 *
 *  @return 
 */
+(BOOL)isValidArray:(id)object;



/**
 *  上传图片之前的压缩
 *
 *  @param soruceImage
 *
 *  @return
 */
+ (NSData *)p_compressImage:(UIImage *)soruceImage;


@end
