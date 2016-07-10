//
//  LawerDetailMidCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BarristerLawerModel.h"

typedef void(^ClickBlock)(BarristerLawerModel *model);
typedef void(^ShowAllBlock)(BarristerLawerModel *model);

@interface LawerDetailMidCell : BaseTableViewCell

@property (nonatomic,copy) ClickBlock block;

@property (nonatomic,copy) ShowAllBlock showAllBlock;

@property (nonatomic,strong) BarristerLawerModel *model;

+(CGFloat)getCellHeightWithModel:(BarristerLawerModel *)model;

@end
