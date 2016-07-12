//
//  LawerDetailViewController.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BarristerLawerModel.h"

@interface LawerDetailViewController : BaseTableViewController

@property (nonatomic,strong) NSString *bussinesAreaStr;
@property (nonatomic,strong) BarristerLawerModel *model;

@property (nonatomic,strong) NSString *lawyerId;

@end
