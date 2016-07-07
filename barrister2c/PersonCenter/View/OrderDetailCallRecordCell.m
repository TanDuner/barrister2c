//
//  OrderDetailCallRecordCell.m
//  barrister
//
//  Created by 徐书传 on 16/6/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OrderDetailCallRecordCell.h"
#import "UIButton+EnlargeEdge.h"
#import "OrderDetailVoiceView.h"

@interface OrderDetailCallRecordCell ()


@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *appointTimeLabel;
@property (nonatomic,strong) UILabel *talkTimeLabel;
@property (nonatomic,strong) UIView *separteView;


@property (nonatomic,strong) UIView *separatelineView1;
@property (nonatomic,strong) UIView *separatelineView2;
@property (nonatomic,strong) OrderDetailVoiceView *voiceView;

@end

@implementation OrderDetailCallRecordCell

+(CGFloat)getHeightWithModel:(CallHistoriesModel *)model
{
    return 145 + 10;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.separatelineView1];
        

        [self addSubview:self.appointTimeLabel];
        [self addSubview:self.talkTimeLabel];
        
        [self addSubview:self.separatelineView2];

        [self addSubview:self.voiceView];
        
        
        [self addSubview:self.separteView];
        
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.separteView setFrame:RECT(0, 0, SCREENWIDTH, 10)];


    self.appointTimeLabel.hidden = NO;
    self.talkTimeLabel.hidden = NO;
    self.separatelineView2.hidden = NO;
    
    [self.appointTimeLabel setFrame:RECT(LeftPadding, 40 + 10 + self.separteView.height, SCREENWIDTH - 20, 13)];
    [self.talkTimeLabel setFrame:RECT(LeftPadding, self.appointTimeLabel.y + self.appointTimeLabel.height + 10, SCREENWIDTH - 20, 13)];
    [self.separatelineView2 setFrame:RECT(0, self.talkTimeLabel.y + self.talkTimeLabel.height + 9.5, SCREENWIDTH, .5)];

    
    self.talkTimeLabel.text = [NSString stringWithFormat:@"通话时长：%@",self.model.duration?self.model.duration:@"0.0"];
    self.appointTimeLabel.text = [NSString stringWithFormat:@"通话时间：%@ ",self.model.startTime?self.model.startTime:@"0"];

    self.voiceView.model  = self.model;
}


#pragma -mark ----Getter---

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:RECT(10, 13 + 10, 200, 13)];
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
        _separatelineView1 = [self getLineViewWithRect:RECT(0, 39.5 + 10, SCREENWIDTH, .5)];
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

-(OrderDetailVoiceView *)voiceView
{
    if (!_voiceView) {
        _voiceView = [[OrderDetailVoiceView alloc] initWithFrame:RECT(0, 105, SCREENWIDTH, 50)];
        _voiceView.model = self.model;
    }
    return _voiceView;
}

#pragma -mark -----Aciton--------



@end
