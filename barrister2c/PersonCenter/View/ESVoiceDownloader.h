//
//  ESVoiceDownloader.h
//  ThriftShop
//
//  Created by JDMAC on 15/6/23.
//  Copyright (c) 2015年 蒋博男. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ESVoiceDownloadProgressBlock)(float progressValue,NSInteger percentage);
typedef void (^ESVoiceDownloadFinishedBlock)(NSData* fileData);
typedef void (^ESVoiceDownloadFailureBlock)(NSError*error);


@protocol ESVoiceDownloadDelegate <NSObject>
@optional
-(void)ESVoiceDownloadProgress:(float)progress Percentage:(NSInteger)percentage;
-(void)ESVoiceDownloadFinished:(NSData*)fileData;
-(void)ESVOiceDownloadFailure:(NSError*)error;

@end


@interface ESVoiceDownloader : NSObject

@property (nonatomic,readonly) NSMutableData* receiveData;
@property (nonatomic,readonly) NSInteger downloadedPercentage;
@property (nonatomic,readonly) float progress;

@property (nonatomic,strong) id<ESVoiceDownloadDelegate>delegate;
@property (nonatomic,strong) NSURLConnection *connection;


-(id)initWithURL:(NSURL *)fileURL timeout:(NSInteger)timeout;

-(void)startWithDownloading:(ESVoiceDownloadProgressBlock)progressBlock onFinished:(ESVoiceDownloadFinishedBlock)finishedBlock onFail:(ESVoiceDownloadFailureBlock)failBlock;

-(void)startWithDelegate:(id<ESVoiceDownloadDelegate>)delegate;
-(void)cancel;


@end
