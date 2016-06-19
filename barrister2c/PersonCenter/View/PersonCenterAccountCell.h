//
//  PersonCenterAccountCell.h
//  barrister
//
//  Created by 徐书传 on 16/3/29.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYImage.h"
#import "PersonCenterModel.h"
#import "BaseTableViewCell.h"

@interface PersonCenterAccountCell : BaseTableViewCell

@property (nonatomic,strong) YYAnimatedImageView *headerImageView;

@property (nonatomic,strong) UILabel *unLoginTipLabel;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) PersonCenterModel *model;

+(CGFloat)getCellHeight;

@end
