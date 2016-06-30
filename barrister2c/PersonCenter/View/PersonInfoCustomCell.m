//
//  PersonInfoCustomCell.m
//  barrister
//
//  Created by 徐书传 on 16/4/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "PersonInfoCustomCell.h"
#import "UIImageView+YYWebImage.h"
#define ImageWidth 60

@interface PersonInfoCustomCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *rightRow;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UIImageView *headerImageView;

@end


@implementation PersonInfoCustomCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightRow];
        [self addSubview:self.subTitleLabel];
        [self addSubview:self.headerImageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setFrame:RECT(LeftPadding, ([PersonInfoCustomCell getCellHeightWithModel:self.model] - 15)/2.0, 200, 15)];
    [self.rightRow setFrame:CGRectMake(SCREENWIDTH - 15 - 15, self.titleLabel.y, 15, 15)];
    if (self.model.isShowArrow) {
        self.rightRow.hidden = NO;
        [self.subTitleLabel setFrame:RECT(SCREENWIDTH - 15  - 10 - 15 - 200, self.titleLabel.y, 200, 15)];
    }
    else {
        self.rightRow.hidden = YES;
        self.subTitleLabel.hidden = NO;
        [self.subTitleLabel setFrame:RECT(SCREENWIDTH - 15 - 200, self.titleLabel.y, 200, 15)];
        
    }
}


-(void)configData
{
    if (self.model) {
        self.titleLabel.text = self.model.titleStr;
        
     
        
        if (self.model.cellType == PersonCenterModelTypeInfoTX) {
            self.headerImageView.hidden = NO;
            [self.headerImageView setFrame:CGRectMake(SCREENWIDTH - 15 - 15 - 10 - ImageWidth, ([PersonInfoCustomCell getCellHeightWithModel:self.model] - ImageWidth)/2.0, ImageWidth, ImageWidth)];
            if ([BaseDataSingleton shareInstance].userModel.userIcon) {
                [self.headerImageView yy_setImageWithURL:[NSURL URLWithString:[BaseDataSingleton shareInstance].userModel.userIcon] placeholder:[UIImage imageNamed:@"commom_default_head.png"]];
            }
            else if(self.model.headImage)
            {
                [self.headerImageView setImage:self.model.headImage];
            }
        }
        else
        {
            self.subTitleLabel.text = self.model.subtitleStr;
            self.headerImageView.hidden = YES;
        }
    }
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [kSeparatorColor setStroke];
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [linePath stroke];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(CGFloat)getCellHeightWithModel:(PersonCenterModel *)model
{
    if (model.cellType == PersonCenterModelTypeInfoTX) {
        return 80;
    }
    else
    {
        return 45;
    }
}

#pragma -mark ------Getter----------





-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KColorGray222;
        _titleLabel.font = SystemFont(15.0f);
    }
    return _titleLabel;
}


-(UIImageView*)rightRow
{
    if (!_rightRow) {
        _rightRow = [[UIImageView alloc] init];
        _rightRow.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rightRow.png" ofType:nil]];
        _rightRow.hidden = YES;
        
    }
    return _rightRow;
}

-(UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = KColorGray333;
        _subTitleLabel.font = [UIFont systemFontOfSize:13.0f];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _subTitleLabel;
}

-(UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.cornerRadius = 30.0f;
        _headerImageView.image = [UIImage imageNamed:@"commom_default_head.png"];
        _headerImageView.layer.masksToBounds = YES;
        
    }
    return _headerImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
