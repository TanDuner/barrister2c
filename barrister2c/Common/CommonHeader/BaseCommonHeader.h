//
//  BaseCommonHeader.h
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.

// View Tag
#import <Foundation/Foundation.h>
#import "UIColorAdditions.h"
#import "UIView+Addition.h"
#import "NSString+Addition.h"
#import "BaseDataSingleton.h"
#import "XuUtlity.h"
#import "XuUItlity.h"
#import "NSArray+CommonAdd.h"
#import "CommonMacros.h"


//#define BaseUrl  @"http://192.168.1.25:8080/clientservice/"

#define BaseUrl  @"http://119.254.167.200:8080/clientservice/"


#define kLoadingViewTag 100000      // LoadingView tag
#define kNetworkErrorViewTag 100001 // NetworkErrorView.xib tag
#define kMainTabbarBgViewTag 100002 // 主tabbar tag
#define kFuncTabbarBgViewTag 100003 // 虚拟tabbar tag


#define IS_NOT_EMPTY(string) (string != nil && [string isKindOfClass:[NSString class]] && ![string isKindOfClass:[NSNull class]] && ![@"" isEqualToString:string] && ![@"NULL" isEqualToString:[string uppercaseString]] && ![@"null" isEqualToString:string] && ![@"(null)" isEqualToString:string])

#define IS_EMPTY(string) !((string != nil && [string isKindOfClass:[NSString class]] && ![string isKindOfClass:[NSNull class]] && ![@"" isEqualToString:string] && ![@"NULL" isEqualToString:[string uppercaseString]] && ![@"null" isEqualToString:string] && ![@"(null)" isEqualToString:string]))

#define S(x) (x ? x : @"")

#define TRY_1ST(e) ([e respondsToSelector:@selector(count)] && [(NSArray *)e count] ? e[0] : nil)


//通用屏幕相关
#define SCREEN_IPHONE5    (([[UIScreen mainScreen] bounds].size.height) >= 568)

#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
#define IS_IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f)

#define SYSTEM_MAIN_VERSION_7 (7)
//about app:
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]

#define DAY_SECOND 86400

#define STATUSBAR_HIGHT  (20)
#define NAVBAR_HIGHTIOS_7 (44 + 20)
#define NAVBAR_DEFAULT_HEIGHT  ((IS_IOS7) ? (NAVBAR_HIGHTIOS_7) : (44))
#define STATUSBAR_DEFAULT_HEIGHT  ((IS_IOS7) ? (0) : (STATUSBAR_HIGHT))
#define TABBAR_HEIGHT 49

#define LeftPadding 10

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height


#define RGBACOLOR(r, g, b, a)  [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha: (a)]
#define RGBCOLOR(r, g, b)     RGBACOLOR(r, g, b, 1)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define SystemFont(fontSize)  [UIFont systemFontOfSize:fontSize]

#define RECT(x, y, w, h) (CGRectMake((x), (y), (w), (h)))
#define SIZE(w, h) (CGSizeMake((w), (h)))

#define USERDEFAULTS   [NSUserDefaults standardUserDefaults]
#define USERNOTICENTER [NSNotificationCenter defaultCenter]


//通用颜色

#pragma mark -
#pragma mark - 导航栏

#define kNavigationBarColor     RGBCOLOR(27, 162, 232)
#define kNavigationTitleColor   UIColorFromRGB(0xFFFFFFFF)
#define kBaseViewBackgroundColor    UIColorFromRGB(0xFFF2F2F2)

#define kButtonColor1Normal         UIColorFromRGB(0x1c84db)
#define kButtonColor1Highlight      RGBCOLOR(73, 156, 226)


#define kSeparatorColor         UIColorFromRGB(0xFFCCCCCC)
#define kFormBackgroundColor    UIColorFromRGB(0xFFFFFFFF)
#define kFormTextColor    UIColorFromRGB(0xFF222222)


#define kTableCellBackgroundColor    UIColorFromRGB(0xFFF8F8F8)


#define kFontColorNormalJump    UIColorFromRGB(0xFF000000)
#define kFontColorNormal        UIColorFromRGB(0xFF666666)
#define kFontColorWeak          UIColorFromRGB(0xFFA3A3A3)
#define kFontColorStrong        UIColorFromRGB(0xFFE02428)
#define kFontColorButton        UIColorFromRGB(0xFFFFFFFF)

#define KColorGray999          UIColorFromRGB(0xFF999999)
#define KColorGray666          UIColorFromRGB(0xFF666666)
#define KColorGray333          UIColorFromRGB(0xFF333333)
#define KColorGray222          UIColorFromRGB(0xFF222222)


static NSString * const kNetworkProtocolErrorNotification = @"kNetworkProtocolErrorNotification";                   // 协议错误，错误码-1
static NSString * const kNetworkDidNotLoggedNotification = @"kNetworkDidNotLoggedNotification";                     // 未登录，错误码1
static NSString * const kNetworkInvalidJSONDataNotification = @"kNetworkInvalidJSONDataNotification";               // 返回的数据无法解析为JSON
static NSString * const kNetworkLoginInterfaceErrorNotification = @"kNetworkLoginInterfaceErrorNotification";       // 登录接口调用异常，错误码10000
static NSString * const kNetworkParametersErrorNotification = @"kNetworkParametersErrorNotification";               // 参数异常，错误码10008
static NSString * const kNetworkPermissionDeniedNotification = @"kNetworkPermissionDeniedNotification";             // 没有权限调用该接口，错误码10015

static NSString * const kApplicationDidReceiveRemoteNotification = @"kApplicationDidReceiveRemoteNotification";     // 从推送消息中启动

#define kNetworkPageNum 20



#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]



