//
//  MyMessageModel.h
//  barrister
//
//  Created by 徐书传 on 16/6/14.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

@interface MyMessageModel : BaseModel
//content = "<null>";
//contentId = 206;
//date = "2016-07-11 23:53:58";
//icon = "<null>";
//id = 27;
//title = "\U5f90\U4e66\U4f20\U5ba2\U6237\U9884\U7ea6\U4e86\U60a82016-07-13 09:30:00\U52302016-07-13 10:00:00\U7684\U54a8\U8be2\U8bf7\U53ca\U65f6\U56de\U590d\U54e6";
//type = "type.order.new";

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *contentId;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *messageId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type;

@property (nonatomic,assign) CGFloat contentHeight;

@property (nonatomic,assign) CGFloat titleHeight;
@end
