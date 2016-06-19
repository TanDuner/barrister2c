//
//  MyAccountDetailCell.h
//  barrister
//
//  Created by 徐书传 on 16/5/29.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyAccountDetailModel.h"

@interface MyAccountDetailCell : BaseTableViewCell

@property (nonatomic,strong) MyAccountDetailModel *model;


/**
 *  返回行高
 *
 *  @return 
 */
+(CGFloat)getCellHeight;


@end
