//
//  LawerSelectContentViewController.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "AppointmentMoel.h"

@interface LawerSelectContentViewController : BaseViewController

@property (nonatomic,strong,nullable) AppointmentMoel *model;

@property (nonnull,strong, nonatomic) AppointmentMoel *commitModel;

-(nonnull instancetype)initWithArray:(nullable NSMutableArray *)statesArray;

@end
