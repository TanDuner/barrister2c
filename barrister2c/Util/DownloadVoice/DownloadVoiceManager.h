//
//  DownloadVoiceManager.h
//  barrister2c
//
//  Created by 徐书传 on 16/7/5.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetProxy.h"

@interface DownloadVoiceManager : NSObject

+ (instancetype)shareInstance;

/**
 *  下载录音文件
 *
 *  @param url     文件url
 *  @param orderId 订单id
 *  @param index   每个订单url 组的编号 index
 */
-(void)downloadVoiceWithUrl:(NSString *)url WithfileName:(NSString *)fileName block:(ServiceCallBlock)aBlock;

/**
 * 根据订单号和userId 获取文件的名字
 *
 *  @param orderId 订单号
 */
-(NSString *)getFileNameWithOrderId:(NSString *)orderId index:(NSInteger )index;


/**
 *  判断某个订单的某个录音文件是否存在
 *
 *  @param orderId
 *  @param index
 *
 *  @return
 */
-(BOOL)isVoiceFileExistWithOrderId:(NSString *)orderId index:(NSInteger )index;

@end
