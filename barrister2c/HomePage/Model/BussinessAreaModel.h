//
//  BussinessAreaModel.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"


//desc = "\U65b0\U4e09\U677f\U4e0e\U4e0a\U5e02";
//icon = "http://119.254.167.200:8080/upload/2016/06/29/1467169924440.png";
//id = 17;
//name = "\U65b0\U4e09\U677f\U4e0e\U4e0a\U5e02";


@interface BussinessAreaModel : BaseModel

@property (nonatomic,strong) NSString *desc;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *areaId;

@property (nonatomic,strong) NSString *icon;


@end
