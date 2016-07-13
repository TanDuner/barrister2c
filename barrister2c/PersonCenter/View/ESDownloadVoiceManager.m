//
//  ESDownloadVoiceManager.m
//  ThriftShop
//
//  Created by JDMAC on 15/6/23.
//  Copyright (c) 2015年 蒋博男. All rights reserved.
//

#import "ESDownloadVoiceManager.h"

@implementation ESDownloadVoiceManager

+(BOOL)writeFileDataWithOrderId:(NSString *)orderId index:(NSInteger)index data:(NSData *)fileData
{
    NSString *fileDir = [ESDownloadVoiceManager getFileDirWithOrderId:orderId];
    NSString *fileName = [ESDownloadVoiceManager getFileNameWithId:orderId index:index];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if ([fileData writeToFile:fileName atomically:YES]) {
        NSLog(@"写入成功");
        return YES;
    }
    return NO;
}

+(NSString *)getFileNameWithId:(NSString *)OrderId index:(NSInteger)index
{
    return  [[ESDownloadVoiceManager getFileDirWithOrderId:[NSString stringWithFormat:@"%@",OrderId]] stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld.wav",index]];

}


//根据id获得文件的目录路径
+(NSString *)getFileDirWithOrderId:(NSString *)orderId
{
    NSString *dirPath = [ESDownloadVoiceManager voiceDirPath];
    NSString * voiceFilePath = [dirPath stringByAppendingPathComponent:orderId];
    return voiceFilePath;
}


//判断是否存在传入Id的 录音文件的文件夹
+(BOOL )isExistFileDirectoryWithOrderId:(NSString *)orderId index:(NSInteger)index
{
    NSString *voiceDirPath = [ESDownloadVoiceManager getFileNameWithId:orderId index:index];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:voiceDirPath]) {
        return YES;
    }
    return NO;
}


+(NSString *)voiceDirPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"VoiceFiles"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dirPath]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;

}


@end
