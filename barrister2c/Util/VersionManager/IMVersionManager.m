//
//  IMCheckUpdataManager.m
//  imbangbang
//
//  Created by 申超 on 14/9/15.
//  Copyright (c) 2014年 com.58. All rights reserved.
//

#import "IMVersionManager.h"

#define APP_ID @"1135272961"
#import "XuNetWorking.h"


//设置页-检查版本号服务地址
#define AppstoreUrl     @"http://itunes.apple.com/cn/lookup?id=%@"

@interface IMVersionManager ()

@property (nonatomic,strong) NSString * appStoreVersion;
@property (nonatomic,strong) NSString * nativeVersion;

@end

@implementation IMVersionManager

+ (IMVersionManager *)shareInstance
{
    static IMVersionManager * instance ;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[IMVersionManager alloc] init];
    });
    return instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self checkNativeVersion];
    }
    return self;
}

//获取网络版本
- (void) checkNetworkVersion
{
    NSString *checkVersion = [NSString stringWithFormat:AppstoreUrl,APP_ID];
    __weak typeof(*&self) weakSelf = self;
    [XuNetWorking requestWithNoBaseUrl:checkVersion httpMedth:2 params:nil progress:nil success:^(id response) {
        NSDictionary *dict = (NSDictionary *)response;
        NSString *netVersion = [[[dict objectForKey:@"results"]  safeObjectAtIndex:0] objectForKey:@"version"];
        _appStoreVersion = netVersion;
        [weakSelf judgeIsNeedUpdate];
        
    } fail:^(NSError *error) {
        
    }];
    
}



- (void) judgeIsNeedUpdate
{

    BOOL isneed = NO;
    if ([IMVersionManager shareInstance].appStoreVersion) {
        isneed = [[IMVersionManager shareInstance].nativeVersion compare:[IMVersionManager shareInstance].appStoreVersion] == -1;
    }
    
    if (isneed) {
        [XuUItlity showYesOrNoAlertView:@"更新" noText:@"以后再说" title:@"提示" mesage:@"有新版本可以更新" callback:^(NSInteger buttonIndex, NSString *inputString) {
            //确定
            if(buttonIndex == 1)
            {
                NSString *checkUrl = [NSString stringWithFormat:AppstoreUrl,APP_ID];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:checkUrl]];
            }
        }];
        
    }
    
   
}


- (void) checkNativeVersion
{
    NSDictionary *mainPlist = [[NSBundle mainBundle] infoDictionary];
    _nativeVersion = [mainPlist objectForKey:@"CFBundleShortVersionString"];
}

@end
