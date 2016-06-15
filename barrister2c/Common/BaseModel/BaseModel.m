//
//  BaseModel.m
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel


-(id)initWithDictionary:(NSDictionary *)jsonObject
{
    if(self= [super init])
    {
        [self objectFromDictionary:jsonObject];
    }
    return self;
}

-(NSString *) className
{
    return NSStringFromClass([self class]);
}

- (void)objectFromDictionary:(NSDictionary*)dict
{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]])
    {
        return;
    }
    
    unsigned int propCount, i;
    objc_property_t* properties = class_copyPropertyList([self class], &propCount);
    
    for (i = 0; i < propCount; i++)
    {
        objc_property_t prop = properties[i];
        const char *propName = property_getName(prop);
        if(propName)
        {
            NSString *name = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            id obj = [dict objectForKey:name];
            //NSString *objClassName = [obj className];
            if (!obj)
                continue;
            if ([[obj className] isEqualToString:@"__NSCFString"]
                || [[obj className] isEqualToString:@"__NSCFConstantString"]
                || [[obj className] isEqualToString:@"NSTaggedPointerString"]
                || [[obj className] isEqualToString:@"__NSCFNumber"]
                || [[obj className] isEqualToString:@"__NSCFBoolean"]
                || [[obj className] isEqualToString:@"__NSCFArray"]
                || [obj isKindOfClass:[NSString class]]
                || [obj isKindOfClass:[NSArray class]]
                || [obj isKindOfClass:[NSNumber class]]
                )
                //                || [[obj className] isEqualToString:@"NSDecimalNumber"])
            {
                [self setValue:obj forKeyPath:name];
            }
            else if ([obj isKindOfClass:[NSDictionary class]])
            {
                id subObj = [self valueForKey:name];
                if (subObj)
                    [subObj objectFromDictionary:obj];
            }
        }
    }
    free(properties);
}

- (NSArray *)allKeys
{
    
    unsigned int propCount, i;
    objc_property_t* properties = class_copyPropertyList([self class], &propCount);
    NSMutableArray * keyArr = [NSMutableArray arrayWithCapacity:propCount];
    for (i = 0; i < propCount; i++)
    {
        objc_property_t prop = properties[i];
        const char *propName = property_getName(prop);
        if(propName)
        {
            NSString *name = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            [keyArr addObject:name];
        }
    }
    free(properties);
    return keyArr;
}

- (NSDictionary *)modelToDictionary
{
    unsigned int propCount, i;
    objc_property_t* properties = class_copyPropertyList([self class], &propCount);
    NSMutableDictionary * retDic;
    
    for (i = 0; i < propCount; i++)
    {
        if (!retDic)
        {
            retDic = [[NSMutableDictionary alloc] initWithCapacity:propCount];
        }
        objc_property_t prop = properties[i];
        const char *propName = property_getName(prop);
        if(propName)
        {
            NSString *name = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            id obj = [self valueForKey:name];
            if (!obj)
                continue;
            if ([[obj className] isEqualToString:@"__NSCFString"]
                || [[obj className] isEqualToString:@"__NSCFConstantString"]
                || [[obj className] isEqualToString:@"NSTaggedPointerString"]
                || [[obj className] isEqualToString:@"__NSCFNumber"]
                || [[obj className] isEqualToString:@"__NSCFBoolean"]
                || [[obj className] isEqualToString:@"__NSCFArray"]
                || [obj isKindOfClass:[NSString class]]
                || [obj isKindOfClass:[NSArray class]]
                || [obj isKindOfClass:[NSNumber class]])
            {
                [retDic setObject:obj forKey:name];
            }
            
        }
    }
    free(properties);
    
    return retDic;
}

- (id) valueForUndefinedKey:(NSString *)key
{
    return BaseModelValueForUndefineKey;
}


@end
