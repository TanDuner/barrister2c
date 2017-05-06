//
//  ShareCosumeListCell.h
//  barrister2c
//
//  Created by 徐书传 on 17/5/6.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ShareCosumeModel.h"

@interface ShareCosumeListCell : BaseTableViewCell

@property (nonatomic,strong) ShareCosumeModel *model;

+(CGFloat)getCellHeightWithModel:(ShareCosumeModel *)model;
@end
