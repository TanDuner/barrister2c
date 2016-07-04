//
//  OrderDetailCancelCell.h
//  barrister
//
//  Created by 徐书传 on 16/7/3.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BarristerOrderDetailModel.h"

typedef void(^CancelCellBtnBlock)(NSString *btnType);

@interface OrderDetailCancelCell : BaseTableViewCell

@property (nonatomic,copy) CancelCellBtnBlock block;
@property (nonatomic,strong) BarristerOrderDetailModel *model;

+(CGFloat)getCellHeight;
@end
