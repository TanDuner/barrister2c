//
//  OrderDetailCallRecordCell.m
//  barrister
//
//  Created by 徐书传 on 16/6/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderDetailCallRecordCell.h"
#import "UIButton+EnlargeEdge.h"

@interface OrderDetailCallRecordCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *appointTimeLabel;
@property (nonatomic,strong) UILabel *talkTimeLabel;
@property (nonatomic,strong) UIView *separteView;

@property (nonatomic,strong) UILabel *voiceRecordLabel;

@property (nonatomic,strong) UIButton *playBtn;

@property (nonatomic,strong) UISlider *playerSlider;

@property (nonatomic,strong) UILabel *playTimeLabel;

@property (nonatomic,strong) UIView *separatelineView1;
@property (nonatomic,strong) UIView *separatelineView2;
@property (nonatomic,strong) UIView *separatelineView3;

@end

@implementation OrderDetailCallRecordCell

+(CGFloat)getHeightWithModel:(BarristerOrderModel *)model
{
    if (model.orderState == BarristerOrderStateFinished) {
        return 145 + 10;
    }
    return 40 + 10;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.separatelineView1];
        

        [self addSubview:self.appointTimeLabel];
        [self addSubview:self.talkTimeLabel];
        
        [self addSubview:self.separatelineView2];

        
        [self addSubview:self.voiceRecordLabel];
        
        [self addSubview:self.separatelineView3];
        
        [self addSubview:self.playBtn];
        
        
        [self addSubview:self.playerSlider];
        
        [self addSubview:self.playTimeLabel];
        
        [self addSubview:self.separteView];
        
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.model.orderState == BarristerOrderStateFinished) {

        self.appointTimeLabel.hidden = NO;
        self.playBtn.hidden = NO;
        self.talkTimeLabel.hidden = NO;
        self.voiceRecordLabel.hidden = NO;
        self.playerSlider.hidden = NO;
        self.separatelineView2.hidden = NO;
        self.separatelineView3.hidden = NO;
        
        [self.appointTimeLabel setFrame:RECT(LeftPadding, 40 + 10, SCREENWIDTH - 20, 13)];
        [self.talkTimeLabel setFrame:RECT(LeftPadding, self.appointTimeLabel.y + self.appointTimeLabel.height + 10, SCREENWIDTH - 20, 13)];
        [self.voiceRecordLabel setFrame:RECT(LeftPadding, self.talkTimeLabel.y + self.talkTimeLabel.height + 10 + 20, 64, 13)];
        [self.separatelineView2 setFrame:RECT(0, self.talkTimeLabel.y + self.talkTimeLabel.height + 9.5, SCREENWIDTH, .5)];
        [self.separatelineView3 setFrame:RECT(self.voiceRecordLabel.x + self.voiceRecordLabel.width + 10, self.voiceRecordLabel.y, 1, 13)];
        [self.playBtn setFrame:RECT(LeftPadding + 64 + 10 + 10, self.voiceRecordLabel.y, 15, 15)];
        [self.playerSlider setFrame:RECT(self.playBtn.x + self.playBtn.width + 10, self.voiceRecordLabel.y, (160.0/320.0) *SCREENWIDTH, 13)];
        
        self.talkTimeLabel.text = [NSString stringWithFormat:@"通话时长：%@",self.model.talkTime?self.model.talkTime:@"0.0"];
        self.appointTimeLabel.text = [NSString stringWithFormat:@"预约时间：%@ - %@",self.model.startTime?self.model.startTime:@"0",self.model.endTime?self.model.endTime:@"0"];

    }
    else
    {
        self.separatelineView2.hidden = YES;
        self.separatelineView3.hidden = YES;
        self.appointTimeLabel.hidden = YES;
        self.playBtn.hidden = YES;
        self.talkTimeLabel.hidden = YES;
        self.voiceRecordLabel.hidden = YES;
        self.playerSlider.hidden = YES;
    }
    
    [self.separteView setFrame:RECT(0, self.height - 10, SCREENWIDTH, 10)];
    

}


#pragma -mark ----Getter---

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:RECT(10, 13, 200, 13)];
        _titleLabel.text = @"通话记录";
        _titleLabel.textColor = KColorGray222;
        _titleLabel.font = SystemFont(15.0f);
    }
    return _titleLabel;
}


-(UILabel *)appointTimeLabel
{
    if (!_appointTimeLabel) {
        _appointTimeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 40 + 10, 45, 45)];
        _appointTimeLabel.textColor = KColorGray666;
        _appointTimeLabel.font = SystemFont(14.0f);

    }
    return _appointTimeLabel;
}

-(UILabel *)talkTimeLabel
{
    if (!_talkTimeLabel) {
        _talkTimeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, self.appointTimeLabel.y + self.appointTimeLabel.height + 10, 45, 45)];
        _talkTimeLabel.textColor = KColorGray666;
        _talkTimeLabel.font = SystemFont(14.0f);
        
    }
    return _talkTimeLabel;
}

-(UILabel *)voiceRecordLabel
{
    if (!_voiceRecordLabel) {
        _voiceRecordLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, self.talkTimeLabel.y + self.talkTimeLabel.height + 20 + 10, 64, 45)];
        _voiceRecordLabel.textColor = KColorGray222;
        _voiceRecordLabel.text = @"录音记录";
        _voiceRecordLabel.font = SystemFont(14.0f);

    }
    return _voiceRecordLabel;
}


-(UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"orderdetail_play.png"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playAciton) forControlEvents:UIControlEventTouchUpInside];
        [_playBtn setFrame:RECT(LeftPadding + 64 + 10 + 10, self.voiceRecordLabel.y, 15, 15)];
        [_playBtn setEnlargeEdgeWithTop:15 right:5 bottom:15 left:15];

    }
    return _playBtn;
}

-(UISlider *)playerSlider
{
    if (!_playerSlider) {
        _playerSlider = [[UISlider alloc] initWithFrame:RECT(self.playBtn.x + self.playBtn.width + 5, self.voiceRecordLabel.y, (160.0/640.0) *SCREENWIDTH, 13)];
        _playerSlider.value = 0;

        [_playerSlider setMinimumTrackTintColor:kNavigationBarColor];
        [_playerSlider setMaximumTrackTintColor:KColorGray999];

        [_playerSlider setThumbImage:[UIImage imageNamed:@"orderDetail_slider.png"] forState:UIControlStateNormal];
    }
    return _playerSlider;
}


-(UILabel *)playTimeLabel
{
    if (!_playTimeLabel) {
        _playTimeLabel = [[UILabel alloc] initWithFrame:RECT(SCREENWIDTH - 100, self.playerSlider.y, 100, 13)];
        _playTimeLabel.textColor = KColorGray222;
        _playTimeLabel.font = SystemFont(13.0f);
    }
    return _playTimeLabel;
}



-(UIView *)separteView
{
    if (!_separteView) {
        _separteView = [[UIView alloc] init];
        _separteView.backgroundColor = kBaseViewBackgroundColor;
        
    }
    return _separteView;
}

-(UIView *)separatelineView1
{
    if (!_separatelineView1) {
        _separatelineView1 = [self getLineViewWithRect:RECT(0, 39.5, SCREENWIDTH, .5)];
    }
    return _separatelineView1;
}

-(UIView *)separatelineView2
{
    if (!_separatelineView2) {
        _separatelineView2 = [self getLineViewWithRect:RECT(0, self.talkTimeLabel.y + self.talkTimeLabel.height + 9.5, SCREENWIDTH, .5)];
    }
    return _separatelineView2;
}

-(UIView *)separatelineView3
{
    if (!_separatelineView3) {
        _separatelineView3 = [self getLineViewWithRect:RECT(self.voiceRecordLabel.x + self.voiceRecordLabel.width + 10, self.voiceRecordLabel.y, 1, 13)];
    }
    return _separatelineView3;
}
#pragma -mark -----Aciton--------

-(void)playAciton
{
    
}


@end
