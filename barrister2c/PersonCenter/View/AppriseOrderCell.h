//
//  AppriseOrderCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/7/4.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BarristerOrderDetailModel.h"

typedef void(^AppriseOrderBlock)();

@interface AppriseOrderCell : BaseTableViewCell

@property (nonatomic,copy) AppriseOrderBlock block;
@property (nonatomic,strong) BarristerOrderDetailModel *model;

+(CGFloat)getCellHeight;
@end
