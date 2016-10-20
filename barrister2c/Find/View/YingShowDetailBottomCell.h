//
//  YingShowDetailBottomCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YingShowInfoModel.h"


@interface YingShowDetailBottomCell : BaseTableViewCell

@property (nonatomic,strong) YingShowInfoModel *model;

+(CGFloat)getCellHeightWithModel:(YingShowInfoModel *)model;

@end
