//
//  HomeAreaCell.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/20.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "HomeAreaCell.h"
#import "UIButton+EnlargeEdge.h"
#import "BussinessAreaModel.h"


#define TopSpace 10
#define VerSpace 30




#define LawButtonWidth 38
#define LawLeftPadding 17.5
#define LawTopPadding 10

#define LawNumOfLine 5

#define LawHorSpacing (SCREENWIDTH - LawLeftPadding *2 - LawButtonWidth *LawNumOfLine)/(LawNumOfLine - 1)
#define LawVerSpacing 30

@interface HomeAreaCell ()

@end

@implementation HomeAreaCell


+(CGFloat)getCellHeightWithArray:(NSMutableArray *)array
{
    int x = ceil(array.count / 5.0);

    CGFloat height =  TopSpace + x *(LawButtonWidth + VerSpace);
    
    return height;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)createAreaViews
{
    for (int i = 0; i < self.items.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor blueColor];
        button.layer.cornerRadius = LawButtonWidth/2.0f;
        button.layer.masksToBounds = YES;
        [button setEnlargeEdge:8];
        button.tag = i;
        button.titleLabel.font = SystemFont(10.0f);
        [button addTarget:self action:@selector(clickLawBooksAciton:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:RECT(LawLeftPadding + (LawButtonWidth + LawHorSpacing) *(i%LawNumOfLine), LawTopPadding + (LawButtonWidth + LawVerSpacing)*(i/LawNumOfLine), LawButtonWidth, LawButtonWidth)];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(button.x - 10, button.y + button.height + 5, LawButtonWidth + 20, 12)];
        tipLabel.textColor = KColorGray666;
        tipLabel.textAlignment =  NSTextAlignmentCenter;
        tipLabel.font = SystemFont(12.0f);
        BussinessAreaModel *areaModel = [self.items objectAtIndex:i];
        tipLabel.text = areaModel.title;
        
        [self addSubview:button];
        [self addSubview:tipLabel];
    }

}

-(void)clickLawBooksAciton:(UIButton *)button
{
    if (self.block) {
        self.block(button.tag);
    }
}


@end
