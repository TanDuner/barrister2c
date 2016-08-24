//
//  OnlineWaitPayCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/8/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BarristerOrderDetailModel.h"

typedef void(^waitPayCellBlock)();


@interface OnlineWaitPayCell : BaseTableViewCell

@property (nonatomic,copy) waitPayCellBlock block;

@property (nonatomic,strong) BarristerOrderDetailModel *model;

@end
