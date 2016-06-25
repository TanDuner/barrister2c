//
//  LawerDetailMidCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BarristerLawerModel.h"


@interface LawerDetailMidCell : BaseTableViewCell

@property (nonatomic,strong) BarristerLawerModel *model;

+(CGFloat)getCellHeightWithModel:(BarristerLawerModel *)model;

@end
