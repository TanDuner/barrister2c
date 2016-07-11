//
//  MyMessgeCell.h
//  barrister
//
//  Created by 徐书传 on 16/6/14.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyMessageModel.h"

@interface MyMessgeCell : BaseTableViewCell

@property (nonatomic,strong) MyMessageModel *model;

+(CGFloat)getCellHeightWithModel:(MyMessageModel *)model;

@end
