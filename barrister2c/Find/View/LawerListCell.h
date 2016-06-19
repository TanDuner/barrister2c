//
//  LawerListCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BarristerLawerModel.h"


@interface LawerListCell : BaseTableViewCell

@property (nonatomic,strong) BarristerLawerModel *model;

+(CGFloat)getCellHeight;

@end
