//
//  OnlineServiceCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/8/21.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "OnlineServiceCell.h"
#import "YYWebImage.h"
#import "BarristerLoginManager.h"
#import "BaseDataSingleton.h"

@interface OnlineServiceCell ()

@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIButton *qqBtn;

@property (nonatomic,strong) UILabel *IntroLabel;

@property (nonatomic,strong) UIButton *phoneBtn;
@end

@implementation OnlineServiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        
        if (![BaseDataSingleton shareInstance].isClosePay) {
            [self addSubview:self.qqBtn];
        }        
        [self addSubview:self.IntroLabel];
        [self addSubview:self.phoneBtn];
    }
    return self;

}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [kSeparatorColor setStroke];
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [linePath stroke];
    
}

+(CGFloat)getCellHeightWithModel:(OnlineServiceListModel *)model
{
    return model.introContentHeight + 10 + 8 + 12 + 10;
}


-(void)layoutSubviews
{
    if (!self.model) {
        return;
    }
    
    [self.IntroLabel setFrame:RECT(40 + 10 + 10, CGRectGetMaxY(_nameLabel.frame) + 8, SCREENWIDTH - 10 - 40 - 10 - 60 - 10 - 10, self.model.introContentHeight)];
    _nameLabel.text = self.model.name;
    _IntroLabel.text = self.model.intro;
    
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:self.model.icon] placeholder:[UIImage imageNamed:@"commom_default_head.png"]];

    [self.qqBtn setFrame:RECT(SCREENWIDTH - 70, self.height - 25 - 10 - 10 - 25, 60, 25)];
    
    [self.phoneBtn setFrame:RECT(SCREENWIDTH - 70, self.height - 25 - 10, 60, 25)];
    
}

#pragma -mark -----Getter------

-(UIImageView *)iconImageView{

    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:RECT(10, 10, 40, 40)];
    }
    return _iconImageView;
}


-(UILabel *)nameLabel
{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:RECT(40 + 10 + 10, 10, 150, 12)];
        _nameLabel.textColor = KColorGray333;
        _nameLabel.font = SystemFont(15.0f);
    }
    return _nameLabel;
}


-(UIButton *)qqBtn
{
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setTitle:@"QQ联系" forState:UIControlStateNormal];
        [_qqBtn setFrame:RECT(SCREENWIDTH - 70, SCREENHEIGHT - 25 - 10 - 10 - 25, 60, 25)];
        [_qqBtn addTarget:self action:@selector(QQChatAciton) forControlEvents:UIControlEventTouchUpInside];
        _qqBtn.layer.cornerRadius = 3.0f;
        _qqBtn.titleLabel.font = SystemFont(13.0f);
        _qqBtn.layer.masksToBounds = YES;
        _qqBtn.backgroundColor = kNavigationBarColor;
        [_qqBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _qqBtn;

}

-(UILabel *)IntroLabel
{
    if (!_IntroLabel) {
        _IntroLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _IntroLabel.textColor = KColorGray666;
        _IntroLabel.font = SystemFont(13.0f);
        _IntroLabel.numberOfLines = 0;
    }
    return _IntroLabel;

}


-(UIButton *)phoneBtn
{
    if (!_phoneBtn) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtn setTitle:@"电话联系" forState:UIControlStateNormal];
        _phoneBtn.titleLabel.font = SystemFont(13.0f);
        [_phoneBtn setFrame:RECT(SCREENWIDTH - 70, SCREENHEIGHT - 25 - 10, 60, 25)];
        [_phoneBtn addTarget:self action:@selector(PhoneAction) forControlEvents:UIControlEventTouchUpInside];
        _phoneBtn.layer.cornerRadius = 3.0f;
        _phoneBtn.layer.masksToBounds = YES;
        _phoneBtn.backgroundColor = kNavigationBarColor;
        [_phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
    return _phoneBtn;
}

#pragma -mark ----Action----

-(void)PhoneAction
{
    if ([[BaseDataSingleton shareInstance].loginState isEqualToString:@"1"]) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.model.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedLoginNotificaiton" object:nil];
    }
    


}

-(void)QQChatAciton
{
    if ([[BaseDataSingleton shareInstance].loginState isEqualToString:@"1"]) {
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        {
            //用来接收临时消息的客服QQ号码(注意此QQ号需开通QQ推广功能,否则陌生人向他发送消息会失败)
            NSString *QQ = self.model.qq;
            //调用QQ客户端,发起QQ临时会话
            NSString *url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQ];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
        
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedLoginNotificaiton" object:nil];
    }
 
    
}

@end
