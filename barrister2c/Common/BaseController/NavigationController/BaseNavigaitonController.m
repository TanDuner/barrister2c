//
//  BaseNavigaitonController.m
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNavigaitonController.h"
#import "UIImage+Additions.h"

@interface BaseNavigaitonController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation BaseNavigaitonController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[UINavigationBar appearanceWhenContainedIn:[BaseNavigaitonController class], nil] setBackgroundImage:[UIImage createImageWithColor:kNavigationBarColor] forBarMetrics:UIBarMetricsDefault];
        
        [[UINavigationBar appearanceWhenContainedIn:[BaseNavigaitonController class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kNavigationTitleColor, NSForegroundColorAttributeName, nil]];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // Hijack the push method to disable the gesture
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

// 优化
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //if ([[navigationController.viewControllers firstObject] isEqual:viewController]) {
        if ([navigationController.viewControllers count] == 1) {
            // Disable the interactive pop gesture in the rootViewController of navigationController
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        } else {
            // Enable the interactive pop gesture
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

@end
