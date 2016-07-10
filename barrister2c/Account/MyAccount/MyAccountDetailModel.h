//
//  MyAccountDetailModel.h
//  barrister
//
//  Created by 徐书传 on 16/5/29.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"



@interface MyAccountDetailModel : BaseModel

@property (nonatomic,strong) NSString *money;

@property (nonatomic,strong) NSString * date;

@property (nonatomic,strong) NSString *detailId;


@property (nonatomic,strong) NSString *serialNum;

@property (nonatomic,strong) NSString * type;

@end
