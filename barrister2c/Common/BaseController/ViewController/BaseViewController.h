//
//  BaseViewController.h
//  barrister
//
//  Created by 徐书传 on 16/3/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "BaseDataSingleton.h"

@interface BaseViewController : UIViewController<MBProgressHUDDelegate>
{
    @private
    MBProgressHUD *_HUD;
    UIView *_noContentView;
    UIImageView *_noContentImageView;
    UILabel *_noContentLabel;
    UIView *_loadingView;
    UILabel *_loadingLabel;
    UIActivityIndicatorView *_loadingActivityIndicatorView;
    BaseDataSingleton *_dataSingleton;
    
}

@property (nonatomic, copy) NSString *noContentString;
@property (nonatomic, copy) NSString *loadingString;

/*
 * controller的back回退键处理，子类可重载
 */
- (void)backAction:(id)sender;

/**
 *  在非Root界面导航栏上添加返回按钮
 */
- (void)addBackButton;

/**
 *  在Root导航栏上添加返回按钮
 *
 *  @param target 回调Target
 *  @param action 回调Action
 */
- (void)addBackButtonOnRootWithTarget:(id)target action:(SEL)action;

/**
 *  在Root导航栏上添加返回按钮
 *
 *  @param target  回调Target
 *  @param action  回调Action
 *  @param btnText 返回按钮文字
 */
- (void)addBackButtonOnRootWithTarget:(id)target action:(SEL)action btnText:(NSString *)btnText;

/**
 *  初始化导航栏右侧文字按钮
 *
 *  @param btnText 按钮文字
 *  @param action  回调方法
 */
- (void)initNavigationRightTextButton:(NSString *)btnText action:(SEL)action;
/**
 *  初始化导航栏右侧文字按钮和处理对象
 *
 *  @param btnText 按钮文字
 *  @param action  回调方法
 *  @target target 实现方法的对象
 */
- (void)initNavigationRightTextButton:(NSString *)btnText action:(SEL)action target:(id)target;

- (void)hideNavigationBar;
- (void)showNavigationBar;
- (void)showLoadingHUD;
- (void)showLoadingHUDWithLabel:(NSString *)label;
- (void)hideHUD;
- (void)makeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration;
- (void)showErrorMessage:(NSError *)error;
- (void)showNoContentView;
- (void)hideNoContentView;
- (void)showLoadingView;
- (void)hideLoadingView;

- (CGFloat)subviewTopY;


-(void)showTabbar:(BOOL)isShowTabbar;

-(UIView *)getLineViewWithFrame:(CGRect )rect;


@end
