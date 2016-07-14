//
//  BaseWebViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/30.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseWebViewController.h"
#import "IMWebView.h"


@interface BaseWebViewController ()<UIWebViewDelegate>
{
    IMWebView *_webView;
}
@end

@implementation BaseWebViewController


- (void)dealloc
{
    [_webView setDelegate:nil];
    
    _webView = nil;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
}

- (void)initUI
{
    
    self.title = self.showTitle;
    
    [self initNavigationRightTextButton:@"关闭" action:@selector(closeView)];
    
    //初始化组件
    CGRect webRect = self.view.bounds;
    webRect.size.height = webRect.size.height - NAVBAR_DEFAULT_HEIGHT;
    _webView = [[IMWebView alloc] initWithFrame:webRect];
    _webView.delegate = self;
    [self.view addSubview:_webView];

    [self loadWebViewRequest];
    
}

- (void)backAction:(id)sender
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        [super backAction:sender];
    }
}



- (void)loadWebViewRequest
{

    NSURL *myurl = [NSURL URLWithString:self.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [_webView loadRequest:request];
}




#pragma mark - UIWebViewDelegate

#pragma -mark ------UIWebView Delegate Methods------

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    if ([self p_callBackDispose:request]) {
//        return NO;
//    }
    if (!self.showTitle) {
        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_webView imWebViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_webView imWebViewDidFinishLoad:webView];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_webView imWebView:webView didFailLoadWithError:error];
    if([error code] == NSURLErrorCancelled)
    {
        return;
    }
    
    [XuUItlity showOkAlertView:@"知道了" title:nil mesage:@"页面加载失败，请稍后重试..." callback:^(NSInteger buttonIndex, NSString *inputString) {
        [self closeView];
    }];
    
}

#pragma mark - 关闭处理
- (void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
