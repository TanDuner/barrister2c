//
//  AppointmentMoel.h
//  barrister
//
//  Created by 徐书传 on 16/6/30.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

@interface AppointmentMoel : BaseModel

@property (nonatomic,strong) NSString *date;

@property (nonatomic,strong) NSString *settings;

@property (nonatomic,strong) NSMutableArray *settingArray;

/**
 *  用于下单接口
 *
 *  @param model
 *
 *  @return
 */

+(AppointmentMoel *)getEmptyModelWithInitDateWithModel:(AppointmentMoel *)model;


/**
 *  筛选出model 的全部为2 的 字段拼出来 时间段的字符串
 *
 *  @param model
 *
 *  @return
 */
+(NSString *)getStringWithModel:(AppointmentMoel *)model;



/**
 *  把获得的当天的model 的当前时间之前的 全部设置为2
 */

-(void)setCurrentOrEailerDateUnSelected;

@end
