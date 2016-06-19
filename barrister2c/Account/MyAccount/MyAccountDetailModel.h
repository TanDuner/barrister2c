//
//  MyAccountDetailModel.h
//  barrister
//
//  Created by 徐书传 on 16/5/29.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM (NSInteger,AccountHandleType)
{
    AccountHandleTypeSR,
    AccountHandleTypeTX
};

@interface MyAccountDetailModel : BaseModel

@property (nonatomic,strong) NSString *titleStr;

@property (nonatomic,strong) NSString * dateStr;

@property (nonatomic,strong) NSString *numStr;

@property (nonatomic,assign) AccountHandleType handleType;

@end
