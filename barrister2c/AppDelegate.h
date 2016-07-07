//
//  AppDelegate.h
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabbarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,retain)  BaseTabbarController *tabBarCTL;

- (void)resetRootViewController:(UIViewController *)rootViewController WithBlock:(void(^)())block;

-(void)selectTabWithIndex:(NSInteger)index;

-(void)createTabbar;

@end

