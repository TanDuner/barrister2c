//
//  PersonInfoCustomCell.h
//  barrister
//
//  Created by 徐书传 on 16/4/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PersonCenterModel.h"

@interface PersonInfoCustomCell : BaseTableViewCell

@property (nonatomic,strong) PersonCenterModel *model;

+(CGFloat)getCellHeightWithModel:(PersonCenterModel *)model;

@end
