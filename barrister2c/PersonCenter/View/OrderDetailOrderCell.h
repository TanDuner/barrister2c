//
//  OrderDetailOrderCell.h
//  barrister
//
//  Created by 徐书传 on 16/6/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BarristerOrderModel.h"

@interface OrderDetailOrderCell : BaseTableViewCell

+(CGFloat)getHeightWithModel:(BarristerOrderModel *)model;

@property (nonatomic,strong) BarristerOrderModel *model;

@end
