//
//  HomeTypeCell.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BussinessTypeModel.h"

@interface HomeTypeCell : BaseTableViewCell


@property (nonatomic,strong) NSMutableArray *items;

/**
 *  创建itemView
 */
-(void)createTypeDatas;

+(CGFloat)getCellHeightWithArray:(NSMutableArray *)array;

@end
