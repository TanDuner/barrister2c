//
//  BaseModel.h
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BaseModelValueForUndefineKey        @"JobCircleValueForUndefinedKey"

@interface BaseModel : NSObject

- (id)initWithDictionary:(NSDictionary *)jsonObject;

/**
 *  将数据Model转换为字典
 *
 *  @return 返回转换后的字典对象
 */
- (NSDictionary *)modelToDictionary;


- (void)objectFromDictionary:(NSDictionary*)dict;

/*
 * 返回obj所有keypath   字符串数组
 */
- (NSArray *)allKeys;


@end
