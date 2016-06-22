//
//  HomeAreaCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface HomeAreaCell : BaseTableViewCell

@property (nonatomic,strong) NSMutableArray *items;

-(void)createAreaViews;

+(CGFloat)getCellHeightWithArray:(NSMutableArray *)array;

@end
