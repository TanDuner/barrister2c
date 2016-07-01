//
//  IMActionSheet.m
//  imuicomponentdemo
//
//  Created by 赵露 on 14-9-1.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "IMActionSheet.h"
#import "UIImage+Additions.h"

#define BUTTON_HEIGHT               45.0f

#define LEFT_SPACE                  0.0f//8.0f
#define MID_SPACE                   8.0f
#define BOTTOM_SPACE                0.0f//8.0f

#define BUTTON_CORNER_RADIUS        0.0f

#define BUTTON_WIDTH                [UIScreen mainScreen].bounds.size.width - 2 * LEFT_SPACE

#define TABLE_BKG_COLOR             [UIColor colorWithString:@"#f9f9f9" colorAlpha:1.0]
#define TABLE_LINE_COLOR            [UIColor colorWithString:@"#dbdbdb" colorAlpha:1.0]

#define BTN_COLOR                   self.btnColor//[UIColor im58OrangeColor]//[UIColor colorWithString:@"#FDA01D" colorAlpha:1.0]
#define CANCEL_BTN_COLOR            [UIColor imMidLightGrayColor]
#define DESTRUCTIVE_BTN_COLOR       [UIColor colorWithString:@"#FF0000" colorAlpha:1.0]

#define BTN_HIGHLIGHT_COLOR         [UIColor colorWithString:@"#e1e1e1" colorAlpha:1.0]

#define BTN_FONT                    [UIFont systemFontOfSize:19]
#define CANCEL_FONT                 [UIFont boldSystemFontOfSize:19]

@interface IMActionSheet() <UITableViewDataSource, UITableViewDelegate>
{
    NSString * _actionTitle;
    NSString * _cancelBtnText;
    NSString * _destructiveBtnText;
    NSMutableArray * _otherBtnText;
    
    UIButton * _bkgBtn;
    UIView * _actionBtnPanel;
    UIButton * _cancelBtn;
    UITableView * _tableView;
}

@end


@implementation IMActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        [DEFAULT_NOTIFICATION addObserver:self selector:@selector(notifyUserKickout) name:IM_DIALOG_CLOSE object:nil];
        self.btnColor = kNavigationBarColor;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notifyUserKickout
{
    [self removeFromSuperview];
}

- (instancetype)initWithTitle:(NSString *)title delegate:(id<IMActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self)
    {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyUserKickout) name:IM_DIALOG_CLOSE object:nil];
        
        self.delegate = delegate;
        _actionTitle = title;
        _cancelBtnText = cancelButtonTitle;
        _destructiveBtnText = destructiveButtonTitle;
        
        va_list arg_ptr;
        if (otherButtonTitles)
        {
            _otherBtnText = [[NSMutableArray alloc] initWithCapacity:0];
            [_otherBtnText addObject:otherButtonTitles];

            va_start(arg_ptr, otherButtonTitles);
            NSString * RowProp = va_arg(arg_ptr, id);
            
            while (RowProp)
            {
                [_otherBtnText addObject:RowProp];
                RowProp = va_arg(arg_ptr, id);
            }
        }
    }
    return self;
}

- (void)initControl
{
    [self setFrame:[UIScreen mainScreen].bounds];
    [self setUserInteractionEnabled:YES];
    
    _bkgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bkgBtn setFrame:self.bounds];
    [_bkgBtn setBackgroundColor:[UIColor colorWithString:@"#000000" colorAlpha:0.4]];
    [_bkgBtn addTarget:self action:@selector(bkgButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bkgBtn];
    
    _actionBtnPanel = [[UIView alloc] init];
    [_actionBtnPanel setBackgroundColor:[UIColor clearColor]];
    [_actionBtnPanel setFrame:self.bounds];
    [self addSubview:_actionBtnPanel];
    
    NSInteger bottomHeight = BOTTOM_SPACE;
    if (_cancelBtnText)
    {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setFrame:CGRectMake(LEFT_SPACE, self.bounds.size.height - bottomHeight - BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
        [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [_cancelBtn setTitle:_cancelBtnText forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:KColorGray999 forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:SystemFont(19.0)];
        [_cancelBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_cancelBtn.layer setCornerRadius:BUTTON_CORNER_RADIUS];
        [_cancelBtn.layer setMasksToBounds:YES];
        [_cancelBtn addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_cancelBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_cancelBtn setBackgroundImage:[UIImage createImageWithColor:BTN_HIGHLIGHT_COLOR] forState:UIControlStateHighlighted];
        
        [_actionBtnPanel addSubview:_cancelBtn];
        
        bottomHeight += BUTTON_HEIGHT;
        bottomHeight += MID_SPACE;
    }
    
    NSInteger tableHeight = 0;
    NSInteger tableRows = [self numberOfDesAndOtherButtons];
    if (_actionTitle.length > 0)
    {
        tableRows++;
    }
    
    _tableView = [[UITableView alloc] init];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    if (IS_IOS7)
    {
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
        }
        
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    if (tableRows * BUTTON_HEIGHT > (self.frame.size.height - bottomHeight - 20))
    {
        tableHeight = self.frame.size.height - bottomHeight - 20;
        [_tableView setBounces:YES];
    }
    else
    {
        tableHeight = tableRows * BUTTON_HEIGHT;
        [_tableView setBounces:NO];
    }
    [_tableView setFrame:CGRectMake(LEFT_SPACE, self.frame.size.height - bottomHeight - tableHeight, BUTTON_WIDTH, tableHeight)];
    [_tableView setRowHeight:BUTTON_HEIGHT];
    [_tableView.layer setCornerRadius:BUTTON_CORNER_RADIUS];
    [_tableView.layer setMasksToBounds:YES];
    [_tableView setBackgroundColor:TABLE_BKG_COLOR];
    [_tableView setSeparatorColor:kSeparatorColor];
    
    if (_actionTitle.length > 0)
    {
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
        UILabel * textLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BUTTON_WIDTH - 15 * 2, BUTTON_HEIGHT)];
        [textLab setTextColor:KColorGray999];
        [textLab setTextAlignment:NSTextAlignmentCenter];
        [textLab setFont:SystemFont(13.0)];
        [textLab setAdjustsFontSizeToFitWidth:YES];
        [textLab setText:_actionTitle];
        [headerView addSubview:textLab];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(10, BUTTON_HEIGHT - 0.5, BUTTON_WIDTH - 20, 0.5)];
        [lineView setBackgroundColor:KColorGray999];
        [headerView addSubview:lineView];
        
        [_tableView setTableHeaderView:headerView];
    }
    
    [_actionBtnPanel addSubview:_tableView];
    
    [_actionBtnPanel setFrame:CGRectMake(0, self.frame.size.height - bottomHeight - tableHeight, self.frame.size.width, bottomHeight + tableHeight)];
    [_tableView setFrame:CGRectMake(LEFT_SPACE, 0, BUTTON_WIDTH, tableHeight)];
    [_cancelBtn setFrame:CGRectMake(LEFT_SPACE, tableHeight + MID_SPACE, BUTTON_WIDTH, BUTTON_HEIGHT)];
}

- (void)showInView:(UIView *)view
{
    [self initControl];
    
    UIWindow *theWindow = [UIApplication sharedApplication].delegate.window;
    
    [_actionBtnPanel setFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, _actionBtnPanel.frame.size.height)];
    [_bkgBtn setBackgroundColor:[UIColor colorWithString:@"#000000" colorAlpha:0.0]];
    
    [theWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        [_actionBtnPanel setFrame:CGRectMake(0,
                                             self.frame.size.height - _actionBtnPanel.frame.size.height,
                                             self.frame.size.width,
                                             _actionBtnPanel.frame.size.height)];
        [_bkgBtn setBackgroundColor:[UIColor colorWithString:@"#000000" colorAlpha:0.4]];
    }];
}

- (void)bkgButtonClicked:(id)sender
{
    if (_cancelBtnText)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
        {
            [_delegate actionSheet:self clickedButtonAtIndex:self.cancelButtonIndex];
        }
        [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:YES];
    }
}

- (void)cancelButtonClicked:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
    {
        [_delegate actionSheet:self clickedButtonAtIndex:self.cancelButtonIndex];
    }
    [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:YES];
}

- (NSInteger)addButtonWithTitle:(NSString *)title
{
    if (!title)
    {
        return -1;
    }
    if (!_otherBtnText)
    {
        _otherBtnText = [[NSMutableArray alloc] initWithCapacity:0];
    }
    [_otherBtnText addObject:title];
    return _otherBtnText.count - 1;
}

- (void)setCancelButtonIndex:(NSInteger)cancelButtonIndex
{
    if (_cancelBtnText || !_otherBtnText || cancelButtonIndex >= _otherBtnText.count)
    {
        return;
    }
    else
    {
        NSString * cancelText = [_otherBtnText objectAtIndex:cancelButtonIndex];
        [_otherBtnText removeObjectAtIndex:cancelButtonIndex];
        _cancelBtnText = [cancelText copy];
    }
}

- (NSInteger)cancelButtonIndex
{
    if (_cancelBtnText)
    {
        return self.numberOfButtons - 1;
    }
    else
    {
        return -1;
    }
}

- (NSInteger)numberOfDesAndOtherButtons
{
    NSInteger count = 0;
    if (_destructiveBtnText)
    {
        count++;
    }
    if (_otherBtnText)
    {
        count += _otherBtnText.count;
    }
    return count;
}

- (NSInteger)numberOfButtons
{
    NSInteger count = 0;
    if (_cancelBtnText)
    {
        count++;
    }
    count += [self numberOfDesAndOtherButtons];
    return count;
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)])
    {
        [_delegate actionSheet:self willDismissWithButtonIndex:buttonIndex];
    }
    
    if (animated)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [_actionBtnPanel setFrame:CGRectMake(0,
                                                 self.frame.size.height,
                                                 self.frame.size.width,
                                                 _actionBtnPanel.frame.size.height)];
            [_bkgBtn setBackgroundColor:[UIColor colorWithString:@"#000000" colorAlpha:0.0]];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
            if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)])
            {
                [_delegate actionSheet:self didDismissWithButtonIndex:buttonIndex];
            }
        }];
    }
    else
    {
        [self removeFromSuperview];
        
        if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)])
        {
            [_delegate actionSheet:self didDismissWithButtonIndex:buttonIndex];
        }
    }
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex
{
    NSMutableArray * tmpArray = [[NSMutableArray alloc] initWithCapacity:0];
    if (_destructiveBtnText)
    {
        [tmpArray addObject:_destructiveBtnText];
    }
    [tmpArray addObjectsFromArray:_otherBtnText];
    if (_cancelBtnText)
    {
        [tmpArray addObject:_cancelBtnText];
    }
    
    if (buttonIndex < tmpArray.count && buttonIndex >= 0)
    {
        return [tmpArray objectAtIndex:buttonIndex];
    }
    else
    {
        return nil;
    }
}


#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfDesAndOtherButtons];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell.textLabel setFont:BTN_FONT];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.contentView setBackgroundColor:TABLE_BKG_COLOR];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    if (_destructiveBtnText)
    {
        if (indexPath.row == 0)
        {
            [cell.textLabel setTextColor:DESTRUCTIVE_BTN_COLOR];
            cell.textLabel.text = _destructiveBtnText;
        }
        else
        {
            if (_bRadioBoxMode && _selectedIndex != indexPath.row)
            {
                [cell.textLabel setTextColor:KColorGray999];
            }
            else
            {
                [cell.textLabel setTextColor:BTN_COLOR];
            }
            cell.textLabel.text = [_otherBtnText objectAtIndex:indexPath.row - 1];
        }
    }
    else
    {
        if (_bRadioBoxMode && _selectedIndex != indexPath.row)
        {
            [cell.textLabel setTextColor:KColorGray999];
        }
        else
        {
            [cell.textLabel setTextColor:BTN_COLOR];
        }
        cell.textLabel.text = [_otherBtnText objectAtIndex:indexPath.row];
    }
    
  
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
    {
        [_delegate actionSheet:self clickedButtonAtIndex:indexPath.row];
    }
    [self dismissWithClickedButtonIndex:indexPath.row animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
