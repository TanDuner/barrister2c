//
//  BaseAppointmentModel.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/24.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

/**
 *  2016-05-10 0,1,0,1,1,1,1,1,1,1
 */

typedef NS_ENUM(NSInteger ,AppointMentState)
{
    AppointMentStateUnSelect,
    AppointMentStateSelect,
    AppointMentStateUnSelectable,
};

@interface BaseAppointmentModel : BaseModel

@property (nonnull,strong) NSString *timeStr1; //0,1,0,1,1,1,1,1,1,1
@property (nonnull,strong) NSString *timeStr2;
@property (nonnull,strong) NSString *timeStr3;
@property (nonnull,strong) NSString *timeStr4;
@property (nonnull,strong) NSString *timeStr5;
@property (nonnull,strong) NSString *timeStr6;
@property (nonnull,strong) NSString *timeStr7;

@property (nonatomic,strong)  NSMutableArray * daysArray;


+ (nonnull instancetype)shareInstance;

-(void)setTimeSegmentWithIndex:(NSInteger)index State:(AppointMentState)state;




//-(nullable NSString *)getTime

// 将自己的几个属性（0，1，0，1，1）拼接每个
//-(nullable NSString *)appendTimeStrWithIndex:(NSString *);


-(nullable NSString *)dictionaryToJson:(nullable NSDictionary *)dict;





@end
