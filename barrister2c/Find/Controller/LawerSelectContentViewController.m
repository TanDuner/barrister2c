//
//  LawerSelectContentViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LawerSelectContentViewController.h"
#import "AppointmentManager.h"


#define ButtonNum 36

#define ButtonWidth 25


@interface AppointCheckView : UIView

@property (nonatomic,strong) UIImageView *checkImageView;

@property (nonatomic,strong) UILabel *showLabel;

@property (nonatomic,assign) NSInteger startTimeNum;

@property (nonatomic,assign) NSInteger endTimeNum;

@property (nonatomic,assign) AppointMentState state;

@end

@implementation AppointCheckView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView
{
    _checkImageView = [[UIImageView alloc] init];
    [_checkImageView setFrame:CGRectMake(0, 0, ButtonWidth, ButtonWidth)];
    _checkImageView.layer.cornerRadius = 3;
    _checkImageView.userInteractionEnabled = YES;
    _checkImageView.layer.masksToBounds = YES;
    [self addSubview:_checkImageView];
    
    _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(ButtonWidth + 5, 0, 65, ButtonWidth)];
    _showLabel.textAlignment = NSTextAlignmentCenter;
    _showLabel.font = SystemFont(10.0f);
    _showLabel.textColor = [UIColor grayColor];
    [self addSubview:_showLabel];
    
}



-(void)setState:(AppointMentState)state
{
    _state = state;
    
    if (self.state == AppointMentStateSelect) {
        _checkImageView.image = [UIImage imageNamed:@"unSelected.png"];
    }
    else if(self.state == AppointMentStateUnSelect)
    {
        _checkImageView.image = [UIImage imageNamed:@"Selected.png"];
    }
    else if (self.state == AppointMentStateUnSelectable)
    {
        _checkImageView.image = [UIImage imageNamed:@"unSelectedable.png"];
    }
    else if (self.state == AppointMentStateUnAgree)
    {
        _checkImageView.image = [UIImage imageNamed:@"unSelectedable.png"];
    }
}


@end


#define CheckWidth (SCREENWIDTH == 320 ?85:90)
#define X_CenterPadding (SCREENWIDTH - 30 - 3*CheckWidth - LeftPadding *2)/2.0
#define Y_CenterPaddng 5
#define TopPadding 10


@interface LawerSelectContentViewController ()

@property (nonatomic,strong) UIScrollView *bgScrollView;


@end

@implementation LawerSelectContentViewController

-(instancetype)initWithArray:(NSMutableArray *)aStatesArray
{
    if (self = [super init]) {
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
}

#pragma -mark ----UI------

-(void)createView
{
    NSInteger startTimeNum = 12 * 30;
    NSInteger endTimeNum = 13 *30;
    NSInteger stopTimeNum = 48 *30;
    
    
    for (int i = 0; i < ButtonNum; i ++) {
        
        if (startTimeNum == stopTimeNum) {
            break;
        }
        
        AppointCheckView *checkView = [[AppointCheckView alloc] init];
        
        NSString *startStr = [self getTimeStrWithTimeNum:startTimeNum];
        
        NSString *endStr = [self getTimeStrWithTimeNum:endTimeNum];
        
        NSString *showStr = [NSString stringWithFormat:@"%@~%@",startStr,endStr];
        
        NSString *stateStr = [self.model.settingArray safeObjectAtIndex:i];
    
        if (stateStr.intValue == 0) {
            stateStr = @"3";
        }
        
        checkView.state = stateStr.integerValue;

        
        checkView.startTimeNum = startTimeNum;
        checkView.endTimeNum = endTimeNum;
        
        checkView.tag = i + 1000;
        [checkView setFrame:CGRectMake(LeftPadding + (i%3)*((SCREENWIDTH == 320?85:CheckWidth) + X_CenterPadding), TopPadding + (i / 3)*(Y_CenterPaddng + ButtonWidth), CheckWidth, 25)];
        checkView.showLabel.text = showStr;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkAciton:)];
        [checkView addGestureRecognizer:tap];
        [self.bgScrollView addSubview:checkView];
        
        startTimeNum += 30;
        endTimeNum += 30;
        
    }
    
    self.bgScrollView.contentSize = CGSizeMake(0, (ButtonNum / 3)*(Y_CenterPaddng + ButtonWidth) + 10);
    [self.view addSubview:self.bgScrollView];
    
    
}


-(NSString *)getTimeStrWithTimeNum:(NSInteger)timeNum
{
    NSString *hourStr = timeNum / 60 < 10 ?[NSString stringWithFormat:@"0%ld",timeNum / 60]:[NSString stringWithFormat:@"%ld",timeNum / 60];
    NSString *minStr = timeNum % 60 < 10 ?[NSString stringWithFormat:@"0%ld",timeNum % 60]:[NSString stringWithFormat:@"%ld",timeNum % 60];
    
    NSString *totalStr = [NSString stringWithFormat:@"%@:%@",hourStr,minStr];
    
    return totalStr;
}


#pragma -mark ---Getter---

-(UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:RECT(0, 0, self.view.width, 190)];
    }
    return _bgScrollView;
}

#pragma -mark ----Aciton ----

-(void)checkAciton:(UITapGestureRecognizer *)tap
{
    AppointCheckView *checkView = (AppointCheckView *)[tap view];
    
    
    if (checkView.state == AppointMentStateSelect) {
        checkView.state = AppointMentStateUnSelect;
        [self handleCheckViewDateWithIndex:checkView.tag withState:@"2"];

    }
    else if(checkView.state == AppointMentStateUnSelect)
    {
        checkView.state = AppointMentStateSelect;
        [self handleCheckViewDateWithIndex:checkView.tag withState:@"0"];

    }
    
    [checkView setNeedsLayout];
    
}




-(void)handleCheckViewDateWithIndex:(NSInteger)index withState:(NSString *)state
{
    if (self.commitModel.settingArray.count > index - 1000) {
        [self.commitModel.settingArray replaceObjectAtIndex:index - 1000 withObject:state];
    }

}

-(AppointmentMoel *)commitModel
{
    if (!_commitModel) {
        _commitModel = [AppointmentMoel getEmptyModelWithInitDateWithModel:self.model];
    }
    return _commitModel;
}


@end
