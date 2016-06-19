//
//  PersonCenterCustomCell.h
//  barrister
//
//  Created by 徐书传 on 16/3/29.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonCenterModel.h"
#import "BaseTableViewCell.h"

@interface PersonCenterCustomCell : BaseTableViewCell

@property (nonatomic,strong) PersonCenterModel *model;

+(CGFloat)getCellHeight;

@end
