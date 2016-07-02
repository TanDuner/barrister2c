//
//  MyLikeListCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/7/3.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyLikeModel.h"

@interface MyLikeListCell : BaseTableViewCell
@property (nonatomic,strong) MyLikeModel *model;

+(CGFloat)getCellHeight;
@end
