//
//  ZLFGXSearchListCell.h
//  barrister2c
//
//  Created by 徐书传 on 17/5/6.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YingShowUserModel.h"
#import "YingShowDetailBottomCell.h"


@interface ZLFGXSearchListCell : BaseTableViewCell


@property (nonatomic,strong) YingShowUserModel *model;

@property (nonatomic,assign) BOOL isCreadit;

+(CGFloat)getCellHeightWithModel:(YingShowUserModel *)model;


@end
