//
//  LearnCenterModel.h
//  barrister
//
//  Created by 徐书传 on 16/4/6.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

@interface LearnCenterModel : BaseModel

//date = "2016-06-26 18:04:55";
//id = 16;
//tag = "<null>";
//thumb = "http://119.254.167.200:8080/upload/2016/06/26/1466935495558.jpg";
//title = "\U300a\U56db\U4e2d\U5168\U4f1a\U51b3\U8bae\U300b\U89e3\U8bfb";
//url = "http://www.flgw.com.cn/vod/hylist.asp?id=651";


@property (nonatomic,strong) NSString *thumb;

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *url;

@property (nonatomic,strong) NSString *date;

@property (nonatomic,strong) NSString *learnId;

@property (nonatomic,strong) NSString *tag;

@end
