//
//  OnlineServiceCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/8/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "OnlineServiceListModel.h"

@interface OnlineServiceCell : BaseTableViewCell

@property (nonatomic,strong) OnlineServiceListModel *model;

+(CGFloat)getCellHeightWithModel:(OnlineServiceListModel *)model;

@end
