//
//  DownloadVoiceManager.m
//  barrister2c
//
//  Created by 徐书传 on 16/7/5.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "DownloadVoiceManager.h"
#import "OrderProxy.h"
#import "SandboxFile.h"

@interface DownloadVoiceManager ()

@property (nonatomic,strong) OrderProxy *proxy;
@end

@implementation DownloadVoiceManager

+ (instancetype)shareInstance
{
    static DownloadVoiceManager *dataSingleTon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSingleTon = [[self alloc] init];
    });
    
    return dataSingleTon;
}

/**
 *  下载录音文件
 *
 *  @param url     文件url
 *  @param orderId 订单id
 *  @param index   每个订单url 组的编号 index
 */
-(void)downloadVoiceWithUrl:(NSString *)url WithOrderId:(NSString *)orderId index:(NSInteger)index
{
    NSString *fileName = [self getFileNameWithOrderId:orderId index:index];
    [self.proxy downloadVoiceWithUrl:url savePath:fileName Block:^(id returnData, BOOL success) {
        if (success) {
            [XuUItlity showSucceedHint:@"下载成功" completionBlock:nil];
        }
        else
        {
            
        }
    }];
    

}

/**
 * 根据订单号和userId 获取文件的名字
 *
 *  @param orderId 订单号
 */

-(NSString *)getFileNameWithOrderId:(NSString *)orderId index:(NSInteger )index
{
    NSString *documentPath = [SandboxFile GetDocumentPath];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"VoiceFile"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@_%@_%ld",[BaseDataSingleton shareInstance].userModel.userId,orderId,index];
    NSString *fileTotalPath = [filePath stringByAppendingFormat:@"/%@",fileName];
    
    return fileTotalPath;

}

/**
 *  判断某个订单的某个录音文件是否存在
 *
 *  @param orderId
 *  @param index
 *
 *  @return
 */

-(BOOL)isVoiceFileExistWithOrderId:(NSString *)orderId index:(NSInteger )index
{
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSString *filePath = [self getFileNameWithOrderId:orderId index:index];
    BOOL fileExists = [manager fileExistsAtPath:filePath isDirectory:NO];

    return fileExists;
}

#pragma -mark ---Getter---

-(OrderProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[OrderProxy alloc] init];
    }
    return _proxy;
}


@end
