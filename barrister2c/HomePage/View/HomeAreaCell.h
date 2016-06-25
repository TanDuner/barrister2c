//
//  HomeAreaCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef void(^ClickBtnBlock)(NSInteger index);

@interface HomeAreaCell : BaseTableViewCell

@property (nonatomic,strong) NSMutableArray *items;

@property (nonatomic,copy) ClickBtnBlock block;


-(void)createAreaViews;

+(CGFloat)getCellHeightWithArray:(NSMutableArray *)array;

@end
