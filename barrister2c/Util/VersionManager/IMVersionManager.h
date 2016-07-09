//
//  IMCheckUpdataManager.h
//  imbangbang
//
//  Created by 申超 on 14/9/15.
//  Copyright (c) 2014年 com.58. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol IMVersionDelegate;

@interface IMVersionManager : NSObject

//获取itunes版本
@property (nonatomic,strong,readonly) NSString * appStoreVersion;
//获取本地版本 ！warning 版本号取错了。。。
@property (nonatomic,strong,readonly) NSString * nativeVersion;


+ (IMVersionManager *)shareInstance;

@end
