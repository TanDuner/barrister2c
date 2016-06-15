//
//  XuAlertView.h
//  barrister
//
//  Created by 徐书传 on 16/5/24.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XuAlertCallback)(NSInteger buttonIndex, NSString * inputString);

@interface XuAlertView : UIAlertView

@property (nonatomic, copy) XuAlertCallback alertCallback;

@end
