//
//  YingShowDetailBottomCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "YingShowUserModel.h"

@interface YingShowDetailBottomCell : BaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isBuy:(BOOL)isBuy;

@property (nonatomic,strong) YingShowUserModel *model;

@property (nonatomic,assign) BOOL isCreadit;

+(CGFloat)getCellHeightWithModel:(YingShowUserModel *)model;

@end
