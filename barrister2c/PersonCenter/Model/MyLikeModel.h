//
//  MyLikeModel.h
//  barrister2c
//
//  Created by 徐书传 on 16/7/3.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"


//addTime = "2016-07-02 16:23:53";
//desc = "\U6211\U662f\U4e00\U4e2a\U5f8b\U5e08";
//id = 5;
//thumb = "http://119.254.167.200:8080/upload/2016/06/26/1466942987875userIcon";
//title = "\U53d9\U8ff0\U7a7f";
//type = lawyer;
//url = "<null>";

@interface MyLikeModel : BaseModel

@property (nonatomic,strong) NSString *lawerId;

@property (nonatomic,strong) NSString *thumb;//收藏的律师头像

@property (nonatomic,strong) NSString *addTime;//添加时间

@property (nonatomic,strong) NSString *desc; //律师简介

@property (nonatomic,strong) NSString *title;//律师名字

@property (nonatomic,strong) NSString *url;

@end
