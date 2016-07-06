//
//  RewardSelectViewController.h
//  barrister2c
//
//  Created by 徐书传 on 16/7/5.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "BarristerOrderDetailModel.h"


@interface RewardSelectViewController : BaseViewController


@property (nonatomic,strong) BarristerOrderDetailModel *detailModel;


-(void)show;


-(void)dismiss;

@end
