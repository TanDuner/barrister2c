//
//  OrderDetailMarkCell.h
//  barrister
//
//  Created by 徐书传 on 16/6/12.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BarristerOrderDetailModel.h"

@interface OrderDetailMarkCell : BaseTableViewCell

+(CGFloat)getCellHeightWithModel:(BarristerOrderDetailModel *)model;

@property (nonatomic,strong) BarristerOrderDetailModel *model;

@end
