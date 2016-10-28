//
//  HomeMonenyCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"


typedef void(^ClickBlock)(NSString *type);

@interface HomeMonenyCell : BaseTableViewCell


+(CGFloat)getCellHeight;

@property (nonatomic,strong) UIButton *jishiButton;

@property (nonatomic,strong) UIButton *yuyueButton;

@property (nonatomic,strong) UIButton *zhuanjiaButton;

@property (nonatomic,copy) ClickBlock clickBlock;

@end
