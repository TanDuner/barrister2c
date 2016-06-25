//
//  OrderDetailCallRecordCell.h
//  barrister
//
//  Created by 徐书传 on 16/6/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BarristerOrderModel.h"

@interface OrderDetailCallRecordCell : BaseTableViewCell
@property (nonatomic,strong) BarristerOrderModel *model;

+(CGFloat)getHeightWithModel:(BarristerOrderModel *)model;

@end
