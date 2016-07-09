//
//  XuUItlity.m
//  barrister
//
//  Created by 徐书传 on 16/5/24.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "XuUItlity.h"
#import "MBProgressHUD.h"
#import "XuPointLoadingView.h"
#import "UIColorAdditions.h"
#import "XuUtlity.h"

#define LOADING_VIEW_TEXT                   @"加载中..."
#define INFO_HINT_MARGIN                    (71 * SCREENWIDTH / 320)

@implementation XuUItlity

static MBProgressHUD * _loadingHUD;
static MBProgressHUD * _hintHUD;

// AlertView使用
static XuAlertView * _alertView;
static XuUItlity * _alertDelegate;

//inputAlert中的textField的tag
static const NSInteger InputAlertTextFieldTag = 12345;

- (void)alertView:(XuAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.alertCallback)
    {
        if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput)
        {
            UITextField * textField = [alertView textFieldAtIndex:0];
            alertView.alertCallback(buttonIndex, textField.text);
            alertView.alertCallback = nil;
        }
        else
        {
            alertView.alertCallback(buttonIndex, nil);
            alertView.alertCallback = nil;
        }
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == InputAlertTextFieldTag)
    {
        if (range.location >= 10)
            return NO;
        return YES;
    }
    return YES;
}

+ (void)closeAllPopAlert
{
    if (_alertView)
    {
        //        [_alertView dismissWithClickedButtonIndex:0 withAnimate:NO];
        [_alertView dismissWithClickedButtonIndex:0 animated:NO];
        [_alertView removeFromSuperview];
        _alertView = nil;
    }
    if (_loadingHUD)
    {
        [XuUItlity hideLoading];
        //        [_loadingHUD removeFromSuperview];
        //        _loadingHUD = nil;
    }
    if (_hintHUD)
    {
        [_hintHUD removeFromSuperview];
        _hintHUD = nil;
    }
}

+ (void)showYesOrNoAlertView:(NSString *)yesText
                      noText:(NSString *)noText
                       title:(NSString *)title
                      mesage:(NSString *)message
                    callback:(XuAlertCallback)aCallback
{
    if (!_alertDelegate)
    {
        _alertDelegate = [[XuUItlity alloc] init];
    }
    if (_alertView)
    {
        //        [_alertView dismissWithClickedButtonIndex:0 animated:NO];
        [_alertView removeFromSuperview];
        _alertView = nil;
    }
    
    NSString * showTitle = title;
    NSString * showMsg = message;
    if (showTitle.length <= 0)
    {
        showTitle = showMsg;
        showMsg = nil;
    }
    
    _alertView = [[XuAlertView alloc] initWithTitle:showTitle message:showMsg delegate:_alertDelegate cancelButtonTitle:noText otherButtonTitles:yesText, nil];
    //    _alertView = [[IMAlertView2 alloc] initWithType:IMAlertViewType_Default withTitle:title message:message delegate:_alertDelegate cancelButtonTitle:noText otherButtonTitles:yesText, nil];
    _alertView.alertCallback = aCallback;
    
    [_alertView show];
}

+ (void)showYesOrNoAlertView:(NSString *)oneText twoText:(NSString *)twoText noText:(NSString *)noText title:(NSString *)title mesage:(NSString *)message callback:(XuAlertCallback)aCallback {
    
    if (!_alertDelegate)
    {
        _alertDelegate = [[XuUItlity alloc] init];
    }
    if (_alertView)
    {
        [_alertView removeFromSuperview];
        _alertView = nil;
    }
    
    NSString * showTitle = title;
    NSString * showMsg = message;
    if (showTitle.length <= 0)
    {
        showTitle = showMsg;
        showMsg = nil;
    }
    
    _alertView = [[XuAlertView alloc] initWithTitle:showTitle message:showMsg delegate:_alertDelegate cancelButtonTitle:noText otherButtonTitles:oneText,twoText, nil];
    _alertView.alertCallback = aCallback;
    [_alertView show];
    
}


+ (void)showOkAlertView:(NSString *)okText
                  title:(NSString *)title
                 mesage:(NSString *)message
               callback:(XuAlertCallback)aCallback
{
    if (!_alertDelegate)
    {
        _alertDelegate = [[XuUItlity alloc] init];
    }
    if (_alertView)
    {
        //        [_alertView dismissWithClickedButtonIndex:0 animated:NO];
        [_alertView removeFromSuperview];
        _alertView = nil;
    }
    
    NSString * showTitle = title;
    NSString * showMsg = message;
    if (showTitle.length <= 0)
    {
        showTitle = showMsg;
        showMsg = nil;
    }
    
    _alertView = [[XuAlertView alloc] initWithTitle:showTitle message:showMsg delegate:_alertDelegate cancelButtonTitle:okText otherButtonTitles:nil, nil];
    //    _alertView = [[IMAlertView2 alloc] initWithType:IMAlertViewType_Default withTitle:title message:message delegate:_alertDelegate cancelButtonTitle:okText otherButtonTitles:nil, nil];
    _alertView.alertCallback = aCallback;
    
    [_alertView show];
}

+ (void)showInputAlertView:(NSString *)yesText
                    noText:(NSString *)noText
                     title:(NSString *)title
                    mesage:(NSString *)message
               placeholder:(NSString *)plackholder
                  callback:(XuAlertCallback)aCallback
{
    if (!_alertDelegate)
    {
        _alertDelegate = [[XuUItlity alloc] init];
    }
    if (_alertView)
    {
        //        [_alertView dismissWithClickedButtonIndex:0 animated:NO];
        [_alertView removeFromSuperview];
        _alertView = nil;
    }
    
    NSString * showTitle = title;
    NSString * showMsg = message;
    if (showTitle.length <= 0)
    {
        showTitle = showMsg;
        showMsg = nil;
    }
    
    _alertView = [[XuAlertView alloc] initWithTitle:showTitle message:showMsg delegate:_alertDelegate cancelButtonTitle:noText otherButtonTitles:yesText, nil];
    
    [_alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [[_alertView textFieldAtIndex:0] setPlaceholder:plackholder];
    [[_alertView textFieldAtIndex:0] setTag:InputAlertTextFieldTag];
    
    //    _alertView = [[IMAlertView2 alloc] initWithType:IMAlertViewType_Input withTitle:title message:message delegate:_alertDelegate cancelButtonTitle:noText otherButtonTitles:yesText, nil];
    //    UITextField * textField = _alertView.textInput;
    //    textField.tag = InputAlertTextFieldTag;
    //    textField.delegate = _alertDelegate;
    //    if (textField)
    //    {
    //        [textField setPlaceholder:plackholder];
    //    }
    _alertView.alertCallback = aCallback;
    
    [_alertView show];
}

+ (void)showLoadingInView:(UIView *)parentView hintText:(NSString *)hintText
{
    CGRect theFrame = parentView.frame;
    if (_loadingHUD)
    {
        [_loadingHUD removeFromSuperview];
        _loadingHUD = nil;
    }
    _loadingHUD = [[MBProgressHUD alloc] initWithFrame:theFrame];
    //    _loadingHUD.labelText = hintText;
    _loadingHUD.labelText = LOADING_VIEW_TEXT;
    [parentView addSubview:_loadingHUD];
    
    _loadingHUD.mode = MBProgressHUDModeCustomView;
    _loadingHUD.customView = [XuPointLoadingView viewWithPointLoading];
    [((XuPointLoadingView *)_loadingHUD.customView) startAnimating];
    
    [_loadingHUD setColor:[UIColor colorWithString:@"#000000" colorAlpha:0.55]];
    [_hintHUD setTextColor:[UIColor colorWithString:@"#ffffff" colorAlpha:1.0]];
    [_loadingHUD setDimBackground:NO];
    
    [_loadingHUD show:YES];
}

+ (void)showLoading:(NSString *)hintText
{
    UIWindow *theWindow = [UIApplication sharedApplication].delegate.window;
    CGRect theFrame = theWindow.frame;
    if (_loadingHUD)
    {
        [_loadingHUD removeFromSuperview];
        _loadingHUD = nil;
    }
    _loadingHUD = [[MBProgressHUD alloc] initWithFrame:theFrame];
    //    _loadingHUD.labelText = hintText;
    _loadingHUD.labelText = hintText?hintText:LOADING_VIEW_TEXT;
    [theWindow addSubview:_loadingHUD];
 
    
    _loadingHUD.mode = MBProgressHUDModeCustomView;
    _loadingHUD.customView = [XuPointLoadingView viewWithPointLoading];
    [((XuPointLoadingView *)_loadingHUD.customView) startAnimating];
    
    [_loadingHUD setColor:[UIColor colorWithString:@"#000000" colorAlpha:0.55]];
    [_hintHUD setTextColor:[UIColor colorWithString:@"#ffffff" colorAlpha:1.0]];
    [_loadingHUD setDimBackground:NO];
    
    [_loadingHUD show:YES];
}

+ (void)hideLoading
{
    [((XuPointLoadingView *)_loadingHUD.customView) stopAnimating];
    [_loadingHUD removeFromSuperview];
    _loadingHUD = nil;
}

+ (void)showAutoHidHint:(NSString *)hintText imageName:(NSString *)imageName completionBlock:(XuHUDCompletionBlock)aCompletion
{
    UIWindow *theWindow = [UIApplication sharedApplication].delegate.window;
    CGRect theFrame = theWindow.frame;
    if (_hintHUD)
    {
        [_hintHUD removeFromSuperview];
        _hintHUD = nil;
    }
    _hintHUD = [[MBProgressHUD alloc] initWithFrame:theFrame];
    if ([XuUtlity stringIsNull:hintText])
    {
        _hintHUD.detailsLabelText = @"信息";
    }
    else
    {
        //        _hintHUD.labelText = hintText;
        _hintHUD.detailsLabelFont = SystemFont(16.0f);
        _hintHUD.detailsLabelText = hintText;
    }
    _hintHUD.mode = MBProgressHUDModeCustomView;
    _hintHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [theWindow addSubview:_hintHUD];
    
    [_hintHUD setColor:[UIColor colorWithString:@"#000000" colorAlpha:0.8]];
    [_hintHUD setTextColor:[UIColor colorWithString:@"#ffffff" colorAlpha:1.0]];
    [_hintHUD setDimBackground:NO];
    [_hintHUD setOutMargin:INFO_HINT_MARGIN];
    
    [_hintHUD showAnimated:YES whileExecutingBlock:nil completionBlock:aCompletion];
    [_hintHUD hide:YES afterDelay:2.0f];
}

+ (void)showSucceedHint:(NSString *)hintText completionBlock:(XuHUDCompletionBlock)aCompletion
{
    if (hintText.length > 0)
    {
        [self showAutoHidHint:hintText imageName:@"common_icon_succeed" completionBlock:aCompletion];
    }
    else
    {
        [self showAutoHidHint:@"刷新成功" imageName:@"common_icon_succeed" completionBlock:aCompletion];
    }
}

+ (void)showInformationHint:(NSString *)hintText completionBlock:(XuHUDCompletionBlock)aCompletion
{
    [self showAutoHidHint:hintText imageName:@"common_icon_info" completionBlock:aCompletion];
}

+ (void)showFailedHint:(NSString *)hintText completionBlock:(XuHUDCompletionBlock)aCompletion
{
    if (hintText.length > 0)
    {
        [self showAutoHidHint:hintText imageName:@"common_icon_warning" completionBlock:aCompletion];
    }
    else
    {
        [self showAutoHidHint:@"刷新失败" imageName:@"common_icon_warning" completionBlock:aCompletion];
    }
}




+ (void)showAlertHint:(NSString *)hintText
      completionBlock:(XuHUDCompletionBlock)aCompletion
              andView:(UIView *)aView{
    //    UIWindow *theWindow = [UIApplication sharedApplication].delegate.window;
    CGRect theFrame = aView.frame;
    if (_hintHUD)
    {
        [_hintHUD removeFromSuperview];
        _hintHUD = nil;
    }
    _hintHUD = [[MBProgressHUD alloc] initWithFrame:theFrame];
    if ([XuUtlity stringIsNull:hintText])
    {
        _hintHUD.labelText = @"刷新成功";
    }
    else
    {
        //        _hintHUD.labelText = hintText;
        _hintHUD.detailsLabelFont = [UIFont systemFontOfSize:17.0f];
        _hintHUD.detailsLabelText = hintText;
    }
    _hintHUD.mode = MBProgressHUDModeCustomView;
    //    _hintHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_alert_succeed"]];
    //    [theWindow addSubview:_hintHUD];
    [aView addSubview:_hintHUD];
    
    [_hintHUD setColor:[UIColor colorWithString:@"#000000" colorAlpha:0.8]];
    [_hintHUD setTextColor:[UIColor colorWithString:@"#ffffff" colorAlpha:1.0]];
    [_hintHUD setDimBackground:NO];
    
    [_hintHUD showAnimated:YES whileExecutingBlock:nil completionBlock:aCompletion];
    [_hintHUD hide:YES afterDelay:2.0f];
}

+ (void)hideNavigationControllerFromRightToLeft:(UINavigationController *)navigationCtrl
{
    CGRect frame = navigationCtrl.navigationBar.frame;
    
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        navigationCtrl.navigationBar.frame = CGRectMake(-SCREENWIDTH, frame.origin.y, frame.size.width, frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [navigationCtrl setNavigationBarHidden:YES animated:NO];
        
    }];
}

+ (UIImage *)scaleImageToSize:(UIImage*)img size:(CGSize)targetSize
{
    UIImage *sourceImage = img;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width > height && targetSize.width < targetSize.height)
    {
        CGFloat tmp = targetSize.width;
        targetSize.width = targetSize.height;
        targetSize.height = tmp;
    }
    else if (width < height && targetSize.width > targetSize.height)
    {
        CGFloat tmp = targetSize.width;
        targetSize.width = targetSize.height;
        targetSize.height = tmp;
    }
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

+(void)clearTableViewEmptyCellWithTableView:(UITableView *)tableView
{
    tableView.tableFooterView = [UIView new];
}


@end
