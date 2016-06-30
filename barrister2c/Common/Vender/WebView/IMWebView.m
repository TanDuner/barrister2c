//
//  IMWebView.m
//  imbangbang
//
//  Created by 赵露 on 14/12/12.
//  Copyright (c) 2014年 com.58. All rights reserved.
//

#import "IMWebView.h"

#define PROCESS_VIEW_HEIGHT                 (2.0)
#define PROCESS_VIEW_SETP_WIDTH             (self.bounds.size.width / 10)

@interface IMWebView()
{
    NSTimer * _animationTimer;
    UIView * _processView;
}

@end

@implementation IMWebView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = self;
    }
    
    return self;
}

- (void)imWebViewDidStartLoad:(UIWebView *)webView
{
    if (!_processView)
    {
        _processView = [[UIView alloc] init];
        [_processView setBackgroundColor:kNavigationBarColor];
        [self addSubview:_processView];
    }
    
    CGRect rect = self.bounds;
    rect.size.height = PROCESS_VIEW_HEIGHT;
    rect.size.width = (rect.size.width / 10);
    _processView.frame = rect;
    
    if (_animationTimer)
    {
        [_animationTimer invalidate];
        _animationTimer = nil;
    }
    _animationTimer = [[NSTimer alloc] initWithFireDate:[NSDate date]
                                               interval:0.5
                                                 target:self
                                               selector:@selector(timerEventFunc:)
                                               userInfo:nil
                                                repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_animationTimer forMode:NSDefaultRunLoopMode];
    
    [_processView setHidden:NO];
}

- (void)imWebViewDidFinishLoad:(UIWebView *)webView
{
    @try {  // 应对线上崩溃问题做的临时处理，
        CGRect rect = _processView.frame;
        rect.size.width = self.bounds.size.width;
        _processView.frame = rect;
        
        [self performSelector:@selector(hideProcessView) withObject:nil afterDelay:0.5];
        
        if (_animationTimer)
        {
            [_animationTimer invalidate];
            _animationTimer = nil;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"do nothing");
    }
}

- (void)imWebView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (_animationTimer)
    {
        [_animationTimer invalidate];
        _animationTimer = nil;
    }
    
    [self hideProcessView];
}

- (void)timerEventFunc:(NSTimer *)timer
{
    CGRect rect = _processView.frame;
    rect.size.width += PROCESS_VIEW_SETP_WIDTH;
    
    if (rect.size.width >= (self.bounds.size.width - PROCESS_VIEW_SETP_WIDTH))
    {
        [_animationTimer invalidate];
        _animationTimer = nil;
        rect.size.width = self.bounds.size.width - PROCESS_VIEW_SETP_WIDTH;
    }
    _processView.frame = rect;
}

- (void)hideProcessView
{
    [_processView setHidden:YES];
}

- (void)dealloc
{
    self.delegate = nil;
    
    if (_animationTimer)
    {
        [_animationTimer invalidate];
        _animationTimer = nil;
    }
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self imWebViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self imWebViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self imWebView:webView didFailLoadWithError:error];
}



@end
