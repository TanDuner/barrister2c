//
//  LawBooksModel.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/17.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"
//desc = "\U82f1\U6587\U6cd5\U5f8b";
//icon = "http://119.254.167.200:8080/upload/2016/06/29/1467214734190.png";
//id = 27;
//name = "\U82f1\U6587\U6cd5\U5f8b";
//url = "http://sjtj.flgw.com.cn/ywfl/default.asp";

@interface LawBooksModel : BaseModel

@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *booksId;


@end
