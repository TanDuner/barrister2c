//
//  AppointmentManager.h
//  barrister
//
//  Created by 徐书传 on 16/6/30.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppointmentMoel.h"

typedef NS_ENUM(NSInteger ,AppointMentState)
{
    AppointMentStateUnSelect,
    AppointMentStateSelect,
    AppointMentStateUnSelectable,
};


//律师预约状态“0”：不接单，“1”：可接单，“2”：已被预约（不可接单）

@interface AppointmentManager : NSObject


@property (nonatomic,strong,nonnull) NSArray *commonTimeArray;

@property (nonatomic,strong,nonnull) NSMutableArray *modelArray;

//@property (nonatomic,strong,nonnull) NSMutableArray *commitArray;


/**
 *  重置Model 数组
 */
-(void)resetData;

/**
 *  单例方法
 *
 *  @return <#return value description#>
 */
+ (nonnull instancetype)shareInstance;

/**
 *  获得某一个日期之后的所有日期字符串
 *
 *  @param date 从这个日期开始
 *
 *  @return 返回数组
 */

-(nonnull NSMutableArray *)getDateStrArraySinceDate:(nullable NSDate *)date;


/**
 *  获得七个零一组成的预约设置字符串 初始化全部为0
 *
 *  @return
 */

-(nonnull NSMutableArray *)getDateSettingStrArray;



/**
 *  为某个选项设定setting 字符串
 *
 *  @param index
 *  @param settingStr
 */

-(void)setTimeSegmentWithIndex:(NSInteger)index settingString:(nullable NSString *)settingStr;


/**
 *  对象转化成json
 *
 *  @param dict
 *
 *  @return
 */
-(nullable NSString *)objectToJsonStr:(nullable id )object;





@end
