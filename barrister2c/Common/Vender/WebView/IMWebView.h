//
//  IMWebView.h
//  imbangbang
//
//  Created by 赵露 on 14/12/12.
//  Copyright (c) 2014年 com.58. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMWebView : UIWebView<UIWebViewDelegate>

- (void)imWebViewDidStartLoad:(UIWebView *)webView;

- (void)imWebViewDidFinishLoad:(UIWebView *)webView;

- (void)imWebView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end
