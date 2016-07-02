//
//  LawerListViewController.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "BussinessAreaModel.h"
#import "BussinessTypeModel.h"

@interface LawerListViewController : BaseViewController

/**
 *  请求的type 是预约还是即时
 */
@property (nonatomic,strong) NSString *type;

/**
 *  业务类型
 */
@property (nonatomic,strong) BussinessTypeModel *bussinessTypeModel;

/**
 *  案件类型
 */
@property (nonatomic,strong) BussinessAreaModel *bussinessAreaModel;



@end

