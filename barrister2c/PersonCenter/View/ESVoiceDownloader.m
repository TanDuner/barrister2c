//
//  ESVoiceDownloader.m
//  ThriftShop
//
//  Created by JDMAC on 15/6/23.
//  Copyright (c) 2015年 蒋博男. All rights reserved.
//

#import "ESVoiceDownloader.h"

@interface ESVoiceDownloader ()
@property (nonatomic,assign) float receiveBytes;
@property (nonatomic,assign) float exceptedBytes;
@property (nonatomic,strong) NSURLRequest *request;

// block
@property (nonatomic,strong) ESVoiceDownloadProgressBlock progressDownloadBlock;
@property (nonatomic,strong) ESVoiceDownloadFinishedBlock progressFinishBlock;
@property (nonatomic,strong) ESVoiceDownloadFailureBlock progressFailBlock;

@end


@implementation ESVoiceDownloader

@synthesize receiveData = _receiveData;
@synthesize request = _request;
@synthesize connection = _connection;
@synthesize downloadedPercentage = _downloadedPercentage;
@synthesize receiveBytes;
@synthesize exceptedBytes;
@synthesize progress = _progress;
@synthesize progressFailBlock = _progressFailBlock;
@synthesize progressDownloadBlock = _progressDownloadBlock;
@synthesize progressFinishBlock = _progressFinishBlock;
@synthesize delegate = _delegate;


-(id)initWithURL:(NSURL *)fileURL timeout:(NSInteger)timeout{
    
    
    self = [super init];
    
    if(self)
    {
        self.receiveBytes = 0;
        self.exceptedBytes = 0;
        _receiveData = [[NSMutableData alloc] initWithLength:0];
        _downloadedPercentage = 0.0f;
        self.request = [[NSURLRequest alloc] initWithURL:fileURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:timeout];
        
        self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
        
        
        
    }
    
    return self;
}


#pragma mark - NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receiveData appendData:data];
    
    NSInteger len = [data length];
    receiveBytes = receiveBytes + len;
    
    if(exceptedBytes != NSURLResponseUnknownLength) {
        _progress = ((receiveBytes/(float)exceptedBytes) * 100)/100;
        _downloadedPercentage = _progress * 100;
        
        if([_delegate respondsToSelector:@selector(ESVoiceDownloadProgress:Percentage:)])
        {
            [_delegate ESVoiceDownloadProgress:_progress  Percentage:_downloadedPercentage];
        }
        else {
            if(_progressDownloadBlock) {
                _progressDownloadBlock(_progress,_downloadedPercentage);
            }
        }
    }
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //return back error
    if([_delegate respondsToSelector:@selector(ESVOiceDownloadFailure:)])
    {
        [_delegate ESVOiceDownloadFailure:error];
    }
    else {
        if(_progressFailBlock) {
            _progressFailBlock(error);
        }
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    exceptedBytes = [response expectedContentLength];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.connection = nil;
    
    if([_delegate respondsToSelector:@selector(ESVoiceDownloadFinished:)])
    {
        [_delegate ESVoiceDownloadFinished:_receiveData];
    }
    else {
        if(_progressFinishBlock) {
            _progressFinishBlock(_receiveData);
        }
    }
}


#pragma mark - properties
-(void)startWithDelegate:(id<ESVoiceDownloadDelegate>)delegate {
    _delegate = delegate;
    if(self.connection) {
        [self.connection start];
        _progressDownloadBlock= nil;
        _progressFinishBlock = nil;
        _progressFailBlock = nil;
    }
}
-(void)startWithDownloading:(ESVoiceDownloadProgressBlock)progressBlock onFinished:(ESVoiceDownloadFinishedBlock)finishedBlock onFail:(ESVoiceDownloadFailureBlock)failBlock {
    if(self.connection) {
        [self.connection start];
        _delegate = nil; //clear delegate
        _progressDownloadBlock = [progressBlock copy];
        _progressFinishBlock = [finishedBlock copy];
        _progressFailBlock = [failBlock copy];
    }
    
}
-(void)cancel {
    if(self.connection) {
        [self.connection cancel];
    }
}

@end
