//
//  ZToastView.m
//  WXD
//
//  Created by Fantasy on 11/17/14.
//  Copyright (c) 2014 JD.COM. All rights reserved.
//

#import "ZToastView.h"

@implementation ZToastView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImage *image = [[UIImage imageNamed:@"hud"] resizableImageWithCapInsets:UIEdgeInsetsMake(29.0f, 10.0f, 29.0f, 10.0f) resizingMode:UIImageResizingModeTile];
        [self setBackgroundImage:image];
    }
    
    return self;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.autoresizesSubviews = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        
        [self addSubview:_backgroundImageView];
    }
    
    return _backgroundImageView;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    
    [self backgroundImageView].image = _backgroundImage;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
        
        [self addSubview:_label];
    }
    
    return _label;
}

- (void)setMessage:(NSString *)message
{
    _message = [message copy];
    
    UILabel *label = [self label];
    CGSize maxSize = CGSizeMake(self.width - 40.0f, SCREENHEIGHT - 55.0f);
    CGSize size = [message sizeWithFont:label.font constrainedToSize:maxSize];
    
    CGRect frame = self.frame;
    frame.size.height = size.height + 55.0f;
    self.frame = frame;
    _backgroundImageView.frame = self.bounds;
    
    frame = CGRectMake((self.width - size.width) / 2.0f, (self.height - size.height) / 2.0f, size.width, size.height);
    label.frame = frame;
    label.text = message;
}

@end
