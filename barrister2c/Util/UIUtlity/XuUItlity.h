//
//  XuUItlity.h
//  barrister
//
//  Created by 徐书传 on 16/5/24.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XuAlertView.h"

typedef void (^XuHUDCompletionBlock)();

@interface XuUItlity : NSObject

+ (void)closeAllPopAlert;

/**
 *  显示一个按钮的提示框
 *
 *  @param okText    按钮文字
 *  @param title     提示框标题
 *  @param message   提示框信息
 *  @param aCallback 按钮被按下后的回调
 */
+ (void)showOkAlertView:(NSString *)okText
                  title:(NSString *)title
                 mesage:(NSString *)message
               callback:(XuAlertCallback)aCallback;

/**
 *  显示两个按钮的提示框
 *
 *  @param yesText   确认按钮文字
 *  @param noText    取消按钮文字
 *  @param title     提示框标题
 *  @param message   提示框信息
 *  @param aCallback 按钮被按下后的回调
 */
+ (void)showYesOrNoAlertView:(NSString *)yesText
                      noText:(NSString *)noText
                       title:(NSString *)title
                      mesage:(NSString *)message
                    callback:(XuAlertCallback)aCallback;

/**
 *  显示三个按钮的提示框
 *
 *  @param oneText   确认按钮1文字
 *  @param twoText   确认按钮2文字
 *  @param noText    取消按钮文字
 *  @param title     提示框标题
 *  @param message   提示框信息
 *  @param aCallback 按钮被按下后的回调
 */
+ (void)showYesOrNoAlertView:(NSString *)oneText
                     twoText:(NSString *)twoText
                      noText:(NSString *)noText
                       title:(NSString *)title
                      mesage:(NSString *)message
                    callback:(XuAlertCallback)aCallback;

/**
 *  显示带一个输入框的提示框
 *
 *  @param yesText     确认按钮文字
 *  @param noText      取消按钮文字
 *  @param title       提示框标题
 *  @param message     提示框信息
 *  @param plackholder 输入框placeholder
 *  @param aCallback   按钮被按下后的回调
 */
+ (void)showInputAlertView:(NSString *)yesText
                    noText:(NSString *)noText
                     title:(NSString *)title
                    mesage:(NSString *)message
               placeholder:(NSString *)plackholder
                  callback:(XuAlertCallback)aCallback;

/**
 *  显示等候提示框，与+ (void)hideLoading配合使用
 *
 *  @param hintText 等候提示框提示文字，可为空
 */
+ (void)showLoading:(NSString *)hintText;

/**
 *  在指定View上显示等候提示框，与+ (void)hideLoading配合使用
 *
 *  @param parentView 父View
 *  @param hintText   等候提示框提示文字，可为空
 */
+ (void)showLoadingInView:(UIView *)parentView hintText:(NSString *)hintText;

/**
 *  隐藏等候提示框，与+ (void)showLoading:(NSString *)hintText配合使用
 */
+ (void)hideLoading;

/**
 *  显示成功提示框，2s后自动消失
 *
 *  @param hintText     成功提示框文字，为空时显示“刷新成功”
 *  @param aCompletion  提示框消失后的回调
 */
+ (void)showSucceedHint:(NSString *)hintText completionBlock:(XuHUDCompletionBlock)aCompletion;

/**
 *  显示提示语，2s后自动消失
 *
 *  @param hintText     提示框文字，为空时显示“刷新成功”
 *  @param aCompletion  提示框消失后的回调
 */
+ (void)showAlertHint:(NSString *)hintText
      completionBlock:(XuHUDCompletionBlock)aCompletion
              andView:(UIView *)aView;
/**
 *  显示失败提示框，2s后自动消失
 *
 *  @param hintText     失败提示框文字，为空时显示“刷新失败”
 *  @param aCompletion  提示框消失后的回调
 */
+ (void)showFailedHint:(NSString *)hintText completionBlock:(XuHUDCompletionBlock)aCompletion;

/**
 *  显示提醒信息提示框，2s后自动消失
 *
 *  @param hintText    提醒信息提示框文字
 *  @param aCompletion 提示框消失后的回调
 */
+ (void)showInformationHint:(NSString *)hintText completionBlock:(XuHUDCompletionBlock)aCompletion;

/**
 *  隐藏导航栏，动画从右到左
 *
 *  @param navigationCtrl 导航栏
 */
+ (void)hideNavigationControllerFromRightToLeft:(UINavigationController *)navigationCtrl;

/**
 *  对图片进行按比例缩放
 *
 *  @param Xug        源图
 *  @param targetSize 目标尺寸
 *
 *  @return 缩放后的图片
 */
+ (UIImage *)scaleImageToSize:(UIImage *)Xug size:(CGSize)targetSize;

/**
 *  消除tableView 多余的cell
 *
 *  @param tableView
 */
+(void)clearTableViewEmptyCellWithTableView:(UITableView *)tableView;

@end
