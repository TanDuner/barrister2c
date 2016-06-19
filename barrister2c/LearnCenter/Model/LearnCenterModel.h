//
//  LearnCenterModel.h
//  barrister
//
//  Created by 徐书传 on 16/4/6.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

@interface LearnCenterModel : BaseModel

@property (nonatomic,strong) NSString *imageUrl;

@property (nonatomic,strong) NSString *learnTitle;

@property (nonatomic,strong) NSString *learnSubtitle;

@property (nonatomic,strong) NSString *publishTime;


@end
