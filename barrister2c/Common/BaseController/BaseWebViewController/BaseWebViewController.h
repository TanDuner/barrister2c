//
//  BaseWebViewController.h
//  barrister2c
//
//  Created by 徐书传 on 16/6/30.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController

@property (nonatomic,strong, nullable) NSString *showTitle;

@property (nonatomic,strong, nullable) NSString *url;

-(void)loadWebViewRequest;

@end
