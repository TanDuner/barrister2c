//
//  BaseTableViewCell.h
//  barrister
//
//  Created by 徐书传 on 16/4/6.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTableViewCell;

typedef void(^CellActionBlock)(id object , BaseTableViewCell *cell);

@interface BaseTableViewCell : UITableViewCell

/**
 *  cell 上的操作的 block
 */

@property (nonatomic,copy) CellActionBlock ActionBlock;

/**
 *  layoutSubViews 自动会调用的 数据填充方法
 */
-(void)configData;

/**
 *  获得一根分割线
 *
 *  @param rect
 *
 *  @return 返回一个指定rect的视图
 */
-(UIView *)getLineViewWithRect:(CGRect)rect;

@end
