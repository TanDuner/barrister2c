//
//  OrderDetailVoiceView.m
//  barrister2c
//
//  Created by 徐书传 on 16/7/6.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderDetailVoiceView.h"
#import "DownloadVoiceManager.h"
#import "HUMSlider.h"
#import "VolumePlayHelper.h"


#define progressViewWidth (SCREENWIDTH - 60 - 60)

@interface OrderDetailVoiceView ()

@property (nonatomic,strong) UIActivityIndicatorView *loadingView;


//@property (nonatomic,strong) WLCircleProgressView *progressView;

@property (nonatomic,strong) UILabel *totalTimeLabel;

@property (nonatomic,strong) HUMSlider *playSlide;

@property (nonatomic,strong) UIButton *playBtn;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation OrderDetailVoiceView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self addSubview:self.playBtn];
        [self addSubview:self.totalTimeLabel];
        [self addSubview:self.playSlide];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playAction:) name:NOTIFICATION_PLAY_VOICE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinishAction:) name:NOTIFICATION_PLAY_VOICE_FINISH object:nil];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[VolumePlayHelper PlayerHelper] audioPlayerStop];
}

-(void)playAction:(NSNotification *)nsnoti
{
    if ([nsnoti.object isEqualToString:self.model.fileName]) {
        self.playSlide.value = 0;
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refreshSlideProgress) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            [self switchWithDownloadState:@"3"];
        }
    }
}

-(void)refreshSlideProgress
{
    if (self.playSlide.value == 1) {
        [self switchWithDownloadState:@"2"];
        return;
    }
    self.playSlide.value += 0.01/self.model.duration.doubleValue;
}

-(void)playFinishAction:(NSNotification *)nsnotifi
{
    if ([nsnotifi.object isEqualToString:self.model.fileName]) {
        if ([[DownloadVoiceManager shareInstance] isVoiceFileExistWithOrderId:self.model.orderId index:self.model.index]) {
            [self switchWithDownloadState:@"2"];
        }
        else
        {
            [self switchWithDownloadState:@"0"];
        }

    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.model) {
        self.totalTimeLabel.text = self.model.totalShowTimeStr;
        if ([[DownloadVoiceManager shareInstance] isVoiceFileExistWithOrderId:self.model.orderId index:self.model.index]) {
            [self switchWithDownloadState:@"1"];
        }
        else
        {
            [self switchWithDownloadState:@"0"];
        }
    }
    
}

-(void)downloadAciton:(UIButton *)btn
{
    if (!self.model.isDownloading) {
        __weak typeof(*&self) weakSelf = self;
        [self.model downloadVoiceWithBlock:^(double precent) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (precent == 1) {
                strongSelf.playBtn.hidden = NO;
                [strongSelf.loadingView stopAnimating];
                strongSelf.loadingView.hidden = YES;
                NSString *fileName = [[DownloadVoiceManager shareInstance] getFileNameWithOrderId:strongSelf.model.orderId index:strongSelf.model.index];
                [[VolumePlayHelper PlayerHelper] playSound:fileName];
                [strongSelf switchWithDownloadState:@"2"];
            }
            else
            {
                strongSelf.playSlide.hidden = NO;
                [strongSelf.playSlide setFrame:RECT(60, 5, progressViewWidth *precent, 30)];
                [strongSelf switchWithDownloadState:@"1"];
            }
            
        }];
    }

}


#pragma -mark ----Getter---


-(UIButton *)playBtn
{
    if (!_playBtn) {

        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"orderdetail_play"] forState:UIControlStateNormal];
        [_playBtn setFrame:RECT((SCREENWIDTH - 30)/2.0, LeftPadding, 30, 30)];

        _playBtn.layer.cornerRadius  = 15.0f;
        [_playBtn addTarget:self action:@selector(downloadAciton:) forControlEvents:UIControlEventTouchUpInside];
        _playBtn.layer.masksToBounds = YES;
    }
    return _playBtn;
}


-(UILabel *)totalTimeLabel
{
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc] initWithFrame:RECT(SCREENWIDTH - 10 - 50, 15, 50, 20)];
        _totalTimeLabel.textColor = KColorGray999;
        _totalTimeLabel.font = SystemFont(14.0f);
        _totalTimeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalTimeLabel;
}

-(HUMSlider *)playSlide
{
    if (!_playSlide) {
        _playSlide = [[HUMSlider alloc] initWithFrame:RECT(60, 5, progressViewWidth, 30)];
        _playSlide.hidden = YES;
        _playSlide.tintColor = kNavigationBarColor;
    }
    return _playSlide;
}


//state 0  未下载 state 1 下载中  state 2  已下载  3 正在播放

-(void)switchWithDownloadState:(NSString *)state
{
    self.playBtn.hidden = NO;
    if ([state isEqualToString:@"0"]) {
        [UIView animateWithDuration:.5 animations:^{
            [self.playBtn setFrame:RECT((SCREENWIDTH - 30)/2.0, LeftPadding, 30, 30)];
        }];
        self.totalTimeLabel.hidden = YES;
        [self.playBtn setTitle:@"点击下载" forState:UIControlStateNormal];
        [self.playBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
        [self.playBtn setTitleColor:KColorGray999 forState:UIControlStateNormal];
        self.playSlide.hidden = YES;
    }
    else if ([state isEqualToString:@"1"])
    {
        self.totalTimeLabel.hidden = NO;
        [UIView animateWithDuration:.5 animations:^{
            [self.playBtn setFrame:RECT(LeftPadding, LeftPadding, 30, 30)];
        } completion:^(BOOL finished) {
            if (finished) {
                self.playSlide.hidden = NO;
            }
        }];
        [self.playBtn setTitle:@"下载中" forState:UIControlStateNormal];
        [self.playBtn setTitleColor:KColorGray999 forState:UIControlStateNormal];

    }
    else if ([state isEqualToString:@"2"])
    {
        self.totalTimeLabel.hidden = NO;
        self.playSlide.hidden = NO;
        [self.playBtn setTitle:@"点击播放" forState:UIControlStateNormal];
        [self.playBtn setTitleColor:KColorGray999 forState:UIControlStateNormal];

    }
    else if ([state isEqualToString:@"3"])//正在播放
    {
        [self.playBtn setTitle:@"正在播放" forState:UIControlStateNormal];
        [self.playBtn setTitleColor:KColorGray999 forState:UIControlStateNormal];
        [self.playBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
 
}

@end
