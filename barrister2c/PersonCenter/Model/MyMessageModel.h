//
//  MyMessageModel.h
//  barrister
//
//  Created by 徐书传 on 16/6/14.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

@interface MyMessageModel : BaseModel
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSString *subTitleStr;
@property (nonatomic,strong) NSString *timeStr;
@end
