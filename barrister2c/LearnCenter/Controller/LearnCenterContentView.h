//
//  LearnCenterContentView.h
//  barrister
//
//  Created by 徐书传 on 16/6/28.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"

@class LearnCenterModel;

typedef void(^cellClickBlock)(LearnCenterModel *model);
@interface LearnCenterContentView : BaseViewController


@property (nonatomic,copy) cellClickBlock cellBlock;

@property (nonatomic,strong) NSString *chanelId;

@property (nonatomic,strong) NSMutableArray *items;

@end
