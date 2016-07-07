//
//  XuPushManager.h
//  barrister
//
//  Created by 徐书传 on 16/7/7.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XuPushManager : NSObject

@property (nonatomic,strong) NSMutableDictionary            * delegateMap;

@property (nonatomic,strong) NSDictionary                   * closePushMsg;

@property (nonatomic,strong) NSDictionary                   * backGroundPushMsg;


/**
 *  获取推送管理实例
 *
 *  @return 推送管理对象
 */
+ (XuPushManager *) shareInstance;


/**
 *  设置极光推送的别名和 tag
 *
 *  @param tag   tag
 *  @param alias 别名
 */
-(void)setJPushTags:(NSSet *)tags Alias:(NSString *)alias;


/**
 *  接收到在线push
 *
 *  @param userInfo 在线消息
 */
- (void) receivePushMsgByActive:(NSDictionary *)userInfo;

/**
 *  接受离线消息push
 *
 *  @param userInfo 离线push
 */
- (void) receivePushMsgByUnActive:(NSDictionary *)userInfo;

/**
 *  离线消息处理
 *
 */
- (void)handleUnActiveMsg;


@end
