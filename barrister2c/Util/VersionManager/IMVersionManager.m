//
//  IMCheckUpdataManager.m
//  imbangbang
//
//  Created by 申超 on 14/9/15.
//  Copyright (c) 2014年 com.58. All rights reserved.
//

#import "IMVersionManager.h"

#define APP_ID @"1135399869"
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
        [self checkNetworkVersion];
    }
    return self;
}

//获取网络版本
- (void) checkNetworkVersion
{
//    NSString *checkVersion = [NSString stringWithFormat:AppstoreUrl,APP_ID];
//    __weak typeof(*&self) weakSelf = self;
//    [XuNetWorking requestWithNoBaseUrl:checkVersion httpMedth:2 params:nil progress:nil success:^(id response) {
//        NSDictionary *dict = (NSDictionary *)response;
//        NSString *netVersion = [[[dict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"version"];
//        _appStoreVersion = netVersion;
//        [weakSelf judgeIsNeedUpdate];
//        
//    } fail:^(NSError *error) {
//        
//    }];
    NSString *url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",APP_ID];
    [self Postpath:url];

    
}



#pragma mark -- 获取数据
-(void)Postpath:(NSString *)path
{
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
        if (data) {
            
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
                
                [receiveStatusDic setValue:@"1" forKey:@"status"];
                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
            }else{
                
                [receiveStatusDic setValue:@"-1" forKey:@"status"];
            }
        }else{
            [receiveStatusDic setValue:@"-1" forKey:@"status"];
        }
        
        [self performSelectorOnMainThread:@selector(receiveData:) withObject:receiveStatusDic waitUntilDone:NO];
    }];
    
}
-(void)receiveData:(id)sender
{
    NSDictionary *dict = (NSDictionary *)sender;
    _appStoreVersion = [dict objectForKey:@"version"];
    [self judgeIsNeedUpdate];
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
                NSString *checkUrl = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",APP_ID];
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
