//
//  TFSButton.m
//  验证码按钮
//
//  Created by tfs_ios on 16/5/11.
//  Copyright © 2016年 tritonsfs. All rights reserved.
//

#import "TFSButton.h"
#import "UIImage+Additions.h"
#define MaxSeconds 60  //设置您需要倒计时的最大事件
typedef void(^TouchBtn)(TFSButton* btn);
@interface TFSButton()
{
    TouchBtn  _touchBlock;
    NSTimer*  _timer;
    NSInteger _times;
}

@end

@implementation TFSButton

- (TFSButton* )initWithFrame:(CGRect)rect touchBlock:(void (^)(TFSButton *))touchBlock {
    if (self = [super init]) {
        _touchBlock = touchBlock;
        self.frame = rect;
        
        self.backgroundColor = [UIColor whiteColor];
//        self.layer.cornerRadius = 5;
//        self.layer.masksToBounds = YES;
        
        [self initBtnStatus];
        [self setTitleColor:KColorGray666 forState:UIControlStateNormal];
        self.titleLabel.font = SystemFont(13.0f);
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self setBackgroundImage:[UIImage createImageWithColor:KColorGray999] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(clickSelfBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)initBtnStatus {
    //btn初始化设置
    self.userInteractionEnabled = YES;
    self.selected = NO;
    [_timer invalidate];
    _timer = nil;
    _times = MaxSeconds;
}


- (void)clickSelfBtn:(TFSButton*)btn {
    if (self.userInteractionEnabled == NO) {
        return;
    }
    
    [self startTimer];
    _touchBlock(self);  // 回调block向服务器请求验证码
}

- (void)startTimer {
    self.userInteractionEnabled = NO;
    self.selected = YES;
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(showLastTime) userInfo:nil repeats:YES];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}


- (void)showLastTime {
    if (_times < 0) {
        [self initBtnStatus];
        return;
    }
    
    NSString* str = [NSString stringWithFormat:@"(%ld)重新获取",_times];
    [self setTitle:str forState:UIControlStateSelected];
    
    _times--;
}





@end
