//
//  BaseDataSingleton.m
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseDataSingleton.h"

@implementation BaseDataSingleton

+ (instancetype)shareInstance
{
    static BaseDataSingleton *dataSingleTon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSingleTon = [[self alloc] init];
    });
    
    return dataSingleTon;
}

-(instancetype)init
{
    if (self = [super init]) {
        self.remainingBalance = @"300";
        self.totalIncome = @"0";
    }
    return self;
}

@end
