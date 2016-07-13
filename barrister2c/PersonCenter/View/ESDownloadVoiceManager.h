//
//  ESDownloadVoiceManager.h
//  ThriftShop
//
//  Created by JDMAC on 15/6/23.
//  Copyright (c) 2015年 蒋博男. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESDownloadVoiceManager : NSObject

//+(void)downLoadVoiceFileWithFileUrl:(NSString *)url;

//根据Id获得 文件名
+(NSString *)getFileNameWithId:(NSString *)OrderId index:(NSInteger)index;



/**
 *  根据id 获取目录路劲
 *
 *  @param orderId
 *
 *  @return
 */
+(NSString *)getFileDirWithOrderId:(NSString *)orderId;


+(BOOL )isExistFileDirectoryWithOrderId:(NSString *)orderId index:(NSInteger)index;


/**
 *  写文件到本地
 *
 *  @param orderId
 *  @param index
 *  @param fileData
 *
 *  @return
 */

+(BOOL)writeFileDataWithOrderId:(NSString *)orderId index:(NSInteger)index data:(NSData *)fileData;

@end
