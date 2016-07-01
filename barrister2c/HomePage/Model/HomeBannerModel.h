//
//  HomeBannerModel.h
//  barrister
//
//  Created by 徐书传 on 16/6/27.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

@interface HomeBannerModel : BaseModel

@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *url;

@end
