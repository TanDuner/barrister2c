//
//  DownloadVoiceManager.m
//  barrister2c
//
//  Created by 徐书传 on 16/7/5.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "DownloadVoiceManager.h"
#import "SandboxFile.h"

@interface DownloadVoiceManager ()<NSURLSessionDelegate>

@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic,strong) NSString *downloadUrlStr;
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
-(void)downloadVoiceWithUrl:(NSString *)url WithfileName:(NSString *)fileName block:(ServiceCallBlock)aBlock
{
    
//    self.downloadUrlStr = url;
//    NSURL * downloadUrl = [NSURL URLWithString:url];
//    self.task = [self.session downloadTaskWithURL:downloadUrl];
//    [self.task resume];

//    NSString *fileName = [NSString stringWithFormat:@"%@",[self getFileNameWithOrderId:orderId index:index]];
    
//    [XuNetWorking downloadWithUrl:url saveToPath:fileName progress:^(int64_t bytesRead, int64_t totalBytesRead) {
//        float precent = bytesRead/totalBytesRead;
//        
//        aBlock(@(precent),YES);
//        
//    } success:^(id response) {
//        
//        aBlock(@(1),YES);
//        
//        
//    } failure:^(NSError *error) {
//        
//        aBlock(@(-1),NO);
//        
//    }];
//    
    
    /**
     *  AFN3.0 下载
     */
    
        //1.创建管理者对象
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //2.确定请求的URL地址
    
        //3.创建请求对象
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        //下载任务
        NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            //打印下下载进度

            NSLog(@"进度");
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            //下载地址

            NSLog(@"下载地址");
            //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
            return [NSURL URLWithString:fileName];
            
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            //下载完成调用的方法
            NSLog(@"下载完成");
            aBlock(@(1),YES);
            
        }];
        
        //开始启动任务
        [task resume];
    
    

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
    NSString *fileName = [NSString stringWithFormat:@"%@_%@_%ld.wav",[BaseDataSingleton shareInstance].userModel.userId,orderId,index];
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
    // location : 临时文件的路径（下载好的文件）
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
    
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    // 将临时文件剪切或者复制Caches文件夹
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // AtPath : 剪切前的文件路径
    // ToPath : 剪切后的文件路径
    [mgr moveItemAtPath:location.path toPath:file error:nil];
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
}


/**
 *  看不到下载进度
 */
-(void)downLoadTask{
    
    //1.得到session对象
    NSURLSession * session = [NSURLSession sharedSession];
    //2.创建一个下载
    NSURL * url = [NSURL URLWithString:self.downloadUrlStr];
    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // location : 临时文件的路径（下载好的文件）
        
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
        NSString *file = [caches stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@",file);
        // 将临时文件剪切或者复制Caches文件夹
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        // AtPath : 剪切前的文件路径
        // ToPath : 剪切后的文件路径
        [mgr moveItemAtPath:location.path toPath:file error:nil];
    }];
    //3.开始任务
    [task resume];
    
}




@end
