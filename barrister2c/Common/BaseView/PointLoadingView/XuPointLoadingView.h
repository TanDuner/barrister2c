//
//  XuPointLoadingView.h
//  barrister
//
//  Created by 徐书传 on 16/5/24.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XuPointLoadingView : UIView

+ (XuPointLoadingView *)viewWithPointLoading;

- (void)startAnimating;
- (void)stopAnimating;

@end
