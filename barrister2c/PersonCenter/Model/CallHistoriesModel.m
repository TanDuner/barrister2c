//
//  CallHistoriesModel.m
//  barrister
//
//  Created by 徐书传 on 16/7/3.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "CallHistoriesModel.h"
#import "DownloadVoiceManager.h"
#import "VolumePlayHelper.h"
#import "ESVoiceDownloader.h"
#import "ESDownloadVoiceManager.h"

@interface CallHistoriesModel ()<NSURLSessionDelegate,ESVoiceDownloadDelegate>

@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *task;

@property (nonatomic,copy) downloadBlock downloadingBlock;


/**
 *  新
 */

@property (nonatomic,strong) ESVoiceDownloader *downloader;

@end

@implementation CallHistoriesModel


-(void)handlePropretyWithDict:(NSDictionary *)dict
{
    
    
}

-(void)setDuration:(NSString *)duration
{
    _duration = duration;
    
    if (_duration.floatValue > 0) {
        NSInteger hour =  _duration.floatValue/3600;
        NSInteger min = _duration.floatValue/60 - hour *60;
        NSInteger seconds = _duration.floatValue - min *60 - hour *3600;
        if (hour == 0) {
            self.totalShowTimeStr = [NSString stringWithFormat:@"%@:%@",(hour>10?[NSString stringWithFormat:@"%ld",min]:[NSString stringWithFormat:@"0%ld",min]),(seconds>10?[NSString stringWithFormat:@"%ld",seconds]:[NSString stringWithFormat:@"0%ld",seconds])];
        }
        else
        {
            self.totalShowTimeStr = [NSString stringWithFormat:@"%@:%@:%@",(hour>10?[NSString stringWithFormat:@"%ld",hour]:[NSString stringWithFormat:@"0%ld",hour]),(min>10?[NSString stringWithFormat:@"%ld",min]:[NSString stringWithFormat:@"0%ld",min]),(seconds>10?[NSString stringWithFormat:@"%ld",seconds]:[NSString stringWithFormat:@"0%ld",seconds])];
        }
        
    }
    else
    {
        self.totalShowTimeStr = @"00:00";
    }

    
    
}


-(void)setIndex:(NSInteger)index
{
    _index = index;
    self.fileName = [[DownloadVoiceManager shareInstance] getFileNameWithOrderId:self.orderId index:_index];
//    self.fileName  = [ESDownloadVoiceManager getFileNameWithId:self.orderId index:_index];
}


-(void)downloadVoiceWithBlock:(downloadBlock)downloadBlock
{
//    if ([ESDownloadVoiceManager isExistFileDirectoryWithOrderId:self.orderId index:_index]) {
//        self.isDownloading = NO;
//        [[VolumePlayHelper PlayerHelper] playSound:self.fileName];
//        return;
//    }
// 
//    [self.downloader startWithDelegate:self];
    
    if (!self.recordUrl || self.isDownloading) {
        return;
    }
    
    if ([[DownloadVoiceManager shareInstance] isVoiceFileExistWithOrderId:self.orderId index:self.index]) {
        self.isDownloading = NO;

        [[VolumePlayHelper PlayerHelper] playSound:self.fileName];
        return;
    }
    
    _downloadingBlock = downloadBlock;
    
    self.isDownloading = YES;
    
    NSURL * downloadUrl = [NSURL URLWithString:self.recordUrl];
    
    if (self.resumeData != nil) {
        self.task = [self.session downloadTaskWithResumeData:self.resumeData];
        [self.task resume];
        self.resumeData = nil;

    }
    else
    {
        self.task = [self.session downloadTaskWithURL:downloadUrl];
        [self.task resume];
    }
}



//#pragma -mark ---ESDownloader Delegate Methods ----
//
//-(void)ESVoiceDownloadProgress:(float)progress Percentage:(NSInteger)percentage {
//    
//    if (self.downloadingBlock) {
//        self.downloadingBlock(progress/percentage);
//    }
//    
//}
//
//-(void)ESVoiceDownloadFinished:(NSData *)fileData {
//    
//    if ([ESDownloadVoiceManager writeFileDataWithOrderId:self.orderId index:_index data:fileData]) {
//        NSLog(@"写入成功");
//    };
//    
//}
//
//-(void)ESVOiceDownloadFailure:(NSError *)error {
//    
//    NSLog(@"下载失败");
//    [XuUItlity showFailedHint:@"下载失败" completionBlock:nil];
//    
//}



#pragma -mark 

//-(ESVoiceDownloader *)downloader
//{
//    if (!_downloader) {
//        _downloader = [[ESVoiceDownloader alloc] initWithURL:[NSURL URLWithString:self.recordUrl] timeout:30];
//        _downloader.delegate = self;
//    }
//    return _downloader;
//}


#pragma -mark ----download--------

-(NSURLSession *)session{
    
    if (!_session) {
        //获取session
        NSURLSessionConfiguration * cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}
#pragma mark --  NSURLSessionDownloadDelegate
/**
 *  下载完毕后调用
 *
 *  @param location     临时文件的路径（下载好的文件）
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{

    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr moveItemAtPath:location.path toPath:self.fileName error:nil];
    self.isDownloading = NO;
    if (self.downloadingBlock) {
        self.downloadingBlock(1.0);
    }
}
/**
 *  恢复下载时调用
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}
/**
 *  每当下载完（写完）一部分时就会调用（可能会被调用多次）
 *
 *  @param bytesWritten              这次调用写了多少
 *  @param totalBytesWritten         累计写了多少长度到沙盒中了
 *  @param totalBytesExpectedToWrite 文件的总长度
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    if (progress == 1) {
        progress = 0.99;
    }
    if (self.downloadingBlock) {
        self.downloadingBlock(progress);
    }
}


@end
