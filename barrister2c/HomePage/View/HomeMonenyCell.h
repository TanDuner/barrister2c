//
//  HomeMonenyCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface HomeMonenyCell : BaseTableViewCell

@property (nonatomic,strong) UILabel *remainTipLabel;

@property (nonatomic,strong) UILabel *remainLabel;

@property (nonatomic,strong) UILabel *costTipLabel;

@property (nonatomic,strong) UILabel *costLabel;

+(CGFloat)getCellHeight;
@end
