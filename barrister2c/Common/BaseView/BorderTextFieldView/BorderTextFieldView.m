//
//  BorderTextFieldView.m
//  barrister
//
//  Created by 徐书传 on 16/3/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BorderTextFieldView.h"

@implementation BorderTextFieldView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self setBorderStyle:UITextBorderStyleNone];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        self.enablesReturnKeyAutomatically = NO;
        self.layer.borderColor = kNavigationTitleColor.CGColor;
        self.layer.borderWidth = .5;
        //        self.layer.cornerRadius = 8.0f;
        self.layer.cornerRadius = 3.0f;
        self.backgroundColor = [UIColor whiteColor];
        _cleanBtnOffset_x = self.bounds.origin.x + self.bounds.size.width -20.0;
        _textOffset_width = self.bounds.size.width - 20;
    }
    return self;
}

////控制左视图位置
//- (CGRect)leftViewRectForBounds:(CGRect)bounds{
//    CGRect inset = CGRectMake(bounds.origin.x+8, bounds.origin.y + 8, bounds.size.width -10, bounds.size.height);
//    return inset;
//}

//控制显示文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds{
  self.textLeftOffset =  self.textLeftOffset > 0?self.textLeftOffset:10;
    CGRect inset = CGRectMake(bounds.origin.x  +  self.textLeftOffset, bounds.origin.y, bounds.size.width - self.textLeftOffset, bounds.size.height);
    return inset;
}

//控制清除按钮的位置
-(CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    if (_row==1) {
        return  CGRectMake(_cleanBtnOffset_x, bounds.origin.y + bounds.size.height -28, 15, 15);
    }
    return CGRectMake(_cleanBtnOffset_x, bounds.origin.y + bounds.size.height -28, 15, 15);
}

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    self.textLeftOffset =  self.textLeftOffset > 0?self.textLeftOffset:10;

    if (IS_IOS7) {
        CGRect inset = CGRectMake(bounds.origin.x + self.textLeftOffset, bounds.origin.y + 14, bounds.size.width - self.textLeftOffset, bounds.size.height);
        return inset;
    }
    CGRect inset = CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    self.textLeftOffset =  self.textLeftOffset > 0?self.textLeftOffset:10;

    CGRect inset = CGRectMake(bounds.origin.x + self.textLeftOffset, bounds.origin.y, _textOffset_width - self.textLeftOffset - 10 - 15, bounds.size.height);
    return inset;
}

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    NSDictionary *attributes = @{NSFontAttributeName:SystemFont(14.0f),NSForegroundColorAttributeName:RGBCOLOR(199, 199, 205)};
    [[self placeholder] drawInRect:rect withAttributes:attributes];
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
