//
//  ZToastView.h
//  WXD
//
//  Created by Fantasy on 11/17/14.
//  Copyright (c) 2014 JD.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZToastView : UIView {
@private
    UIImageView *_backgroundImageView;
    UILabel *_label;
}

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, copy) NSString *message;

@end
