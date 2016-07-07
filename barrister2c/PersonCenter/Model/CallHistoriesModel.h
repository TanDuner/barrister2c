//
//  CallHistoriesModel.h
//  barrister
//
//  Created by 徐书传 on 16/7/3.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"
typedef void(^downloadBlock)(double precent);

@interface CallHistoriesModel : BaseModel


@property (nonatomic,strong) NSString *callId;
@property (nonatomic,strong) NSString *duration;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *recordUrl;
@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) NSString *fileName;

@property (nonatomic,strong) NSString *totalShowTimeStr;

//用于断点续传的data
@property (nonatomic, strong) NSData *resumeData;


-(void)downloadVoiceWithBlock:(downloadBlock)downloadBlock;

@property (nonatomic,assign) BOOL isDownloading;

@end
