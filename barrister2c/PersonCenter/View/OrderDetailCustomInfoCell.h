//
//  OrderDetailCustomInfoCell.h
//  barrister
//
//  Created by 徐书传 on 16/6/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BarristerOrderDetailModel.h"

@interface OrderDetailCustomInfoCell : BaseTableViewCell

@property (nonatomic,strong) UIButton *callButton;

+(CGFloat)getHeightWithModel:(BarristerOrderDetailModel *)model;

@property (nonatomic,strong) BarristerOrderDetailModel *model;

@end
