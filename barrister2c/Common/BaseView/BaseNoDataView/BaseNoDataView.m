//
//  BaseNoDataView.m
//  barrister
//
//  Created by 徐书传 on 16/5/31.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseNoDataView.h"

@interface BaseNoDataView ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *textLab;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UITapGestureRecognizer *oneTapRecognizer;


@end

@implementation BaseNoDataView

- (void)dealloc
{
    [self removeGestureRecognizer:_oneTapRecognizer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addGestureRecognizer:self.oneTapRecognizer];
        
    }
    return self;
}

- (void)showNoDataViewWithStr:(NSString *)str textBtn:(NSString *)btnText target:(id)target selector:(SEL)selector
{
    [self setHidden:NO];
    
    self.backView.frame = CGRectMake(0, (self.bounds.size.height-260)/2, SCREENWIDTH, 260);
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    UIImage *image = [UIImage imageNamed:@"nodata_placeholder"];
    self.imageView.image = image;
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.frame = CGRectMake((SCREENWIDTH-image.size.width)/2, 0, image.size.width, image.size.height);
    [self.backView addSubview:self.imageView];
    
    self.textLab.frame = CGRectMake((SCREENWIDTH-290)*0.5, image.size.height+10, 290, 60);
    [self.textLab setText:str];
    [self.textLab setNumberOfLines:0];
    [self.textLab setTextColor:KColorGray999];
    [self.textLab setFont:[UIFont systemFontOfSize:15]];
    [self.textLab setTextAlignment:NSTextAlignmentCenter];
    [self.backView addSubview:self.textLab];
    
    if (IS_NOT_EMPTY(btnText) && selector) {
        self.backView.frame = CGRectMake(0, (self.bounds.size.height-260)/2, SCREENWIDTH, 260);
        
        [self.button setFrame:CGRectMake((SCREENWIDTH-290)*0.5, image.size.height+70+10, 290, 40)];
        [self.button setTitle:btnText forState:UIControlStateNormal];
        [self.button.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self.button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.button];
    }
    else {
        self.backView.frame = CGRectMake(0, (self.bounds.size.height-210)/2, SCREENWIDTH, 210);
    }
    
    
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
    }
    return _backView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)textLab
{
    if (!_textLab) {
        _textLab = [[UILabel alloc] init];
    }
    return _textLab;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor blueColor];
    }
    
    return _button;
}

- (UITapGestureRecognizer *)oneTapRecognizer
{
    if (!_oneTapRecognizer) {
        _oneTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        _oneTapRecognizer.numberOfTapsRequired = 1;
    }
    return _oneTapRecognizer;
}

- (void)showNoDataView
{
    [self setHidden:NO];
}

- (void)hideNoDataView
{
    [self setHidden:YES];
}

- (void)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(jobNoDataClick)]) {
        [_delegate jobNoDataClick];
    }
}

@end
