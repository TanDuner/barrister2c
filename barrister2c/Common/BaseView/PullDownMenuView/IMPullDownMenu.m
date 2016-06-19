//
//  IMPullDownMenu.m
//  BangBang
//
//  Created by 赵露 on 14-9-29.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "IMPullDownMenu.h"

typedef enum
{
    IndicatorStateShow = 0,
    IndicatorStateHide
}
IndicatorStatus;

typedef enum
{
    BackGroundViewStatusShow = 0,
    BackGroundViewStatusHide
}
BackGroundViewStatus;

#define MAX_LISTITEM_SHOWCOOUNT                 7.5

#pragma mark - CALayer category
// CALayerCategory
@interface CALayer (MXAddAnimationAndValue)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath;

@end

#pragma mark - IMPullDownMenuGroup define
@interface IMPullDownMenuGroup()

@property (nonatomic, strong) NSMutableArray * menuArray;

- (void)tapCurMenu:(IMPullDownMenu *)curMenu;

@end

#pragma mark - IMPullDownMenuItem implementation
@interface IMPullDownMenuItem()

@property (nonatomic, assign) int curIndex;

@end

@implementation IMPullDownMenuItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.defaultIndex = -1;
    }
    return self;
}

@end

#pragma mark - IMPullDownMenu implementation
@interface IMPullDownMenu() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IMPullDownMenuGroup * myGroup;
@property (nonatomic, weak) UIView * parentView;

@end

@implementation IMPullDownMenu
{
    UIView *_backGroundView;
    UITableView *_tableView;
    
    NSMutableArray *_titles;
    NSMutableArray *_indicators;
    
    NSInteger _currentSelectedMenudIndex;
    bool _show;
    
    NSInteger _numOfMenu;
    
    NSArray *_array;
//    UIView * _parentView;
}

- (void)resetDataArray:(NSArray *)array
{
    if (!array || array.count <= 0)
    {
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    } completion:^(BOOL finished) {
        [_backGroundView removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height + _menuToTableViewSpace, [UIScreen mainScreen].bounds.size.width, 0);
    } completion:^(BOOL finished) {
        [_tableView removeFromSuperview];
    }];
    _show = NO;
    
    _array = array;
    
    _numOfMenu = _array.count;
    
    CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
//    CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
    
    for (CALayer * layer in _titles)
    {
        [layer removeFromSuperlayer];
    }
    
    for (CALayer * layer in _indicators)
    {
        [layer removeFromSuperlayer];
    }
    
    _titles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    _indicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    
    for (int i = 0; i < _numOfMenu; i++)
    {
        IMPullDownMenuItem * menuItem = [_array objectAtIndex:i];
        menuItem.curIndex = -1;
        
        CGPoint position = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2);
        CATextLayer *title = [self createTitleLayerByMenuItem:menuItem position:position];//[self creatTextLayerWithNSString:menuItem.title withColor:_menuColor andPosition:position];
        [self.layer addSublayer:title];
        [_titles addObject:title];
        
        
        CAShapeLayer *indicator = [self creatIndicatorWithColor:_menuHighLightColor andPosition:CGPointMake(position.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2)];
        [self.layer addSublayer:indicator];
        [_indicators addObject:indicator];
        
        if (i != 0)
        {
            CGFloat itemWidth = self.frame.size.width / _numOfMenu;
            UIView * sepLine = [[UIView alloc] initWithFrame:CGRectMake(i * itemWidth, self.frame.size.height / 4, 0.5, self.frame.size.height / 2)];
            [sepLine setBackgroundColor:kSeparatorColor];
            [self addSubview:sepLine];
        }
        
        
    }
}

- (CATextLayer *)createTitleLayerByMenuItem:(IMPullDownMenuItem *)menuItem position:(CGPoint)position
{
    CATextLayer *title;// = [self creatTextLayerWithNSString:menuItem.title withColor:_menuColor andPosition:position];
    if (menuItem.defaultIndex == -1)
    {
        title = [self creatTextLayerWithNSString:menuItem.title withColor:_menuColor andPosition:position];
    }
    else
    {
        if (menuItem.unlimitedBtnText && menuItem.unlimitedBtnText.length > 0)
        {
            if (menuItem.defaultIndex != 0 && (menuItem.defaultIndex - 1) < menuItem.listItemArray.count)
            {
                NSString * defaultStr = [menuItem.listItemArray objectAtIndex:(menuItem.defaultIndex - 1)];
                title = [self creatTextLayerWithNSString:defaultStr withColor:_menuColor andPosition:position];
                menuItem.curIndex = (int)menuItem.defaultIndex;
            }
            else
            {
                title = [self creatTextLayerWithNSString:menuItem.title withColor:_menuColor andPosition:position];
            }
        }
        else
        {
            if (menuItem.defaultIndex >= 0 && menuItem.defaultIndex < menuItem.listItemArray.count)
            {
                NSString * defaultStr = [menuItem.listItemArray objectAtIndex:menuItem.defaultIndex];
                title = [self creatTextLayerWithNSString:defaultStr withColor:_menuColor andPosition:position];
                menuItem.curIndex = (int)menuItem.defaultIndex;
            }
            else
            {
                title = [self creatTextLayerWithNSString:menuItem.title withColor:_menuColor andPosition:position];
            }
        }
    }

    return title;
}

- (IMPullDownMenu *)initWithArray:(NSArray *)array
                            frame:(CGRect)frame
                   viewController:(UIViewController *)parentController
                        menuColor:(UIColor *)aMenuColor
                      hlMenuColor:(UIColor *)aHlMenuColor
                         menuFont:(UIFont *)aMenuFont
{
    if (aMenuColor)
    {
        _menuColor = aMenuColor;
    }
    else
    {
        _menuColor = KColorGray666;
    }
    
    if (aHlMenuColor)
    {
        _menuHighLightColor = aHlMenuColor;
    }
    else
    {
        _menuHighLightColor = kNavigationBarColor;
    }
    
    if (aMenuFont)
    {
        _menuFont = aMenuFont;
    }
    else
    {
        _menuFont = [UIFont systemFontOfSize:14.0];
    }
    
    return [self initWithArray:array frame:frame viewController:parentController];
}

- (IMPullDownMenu *)initWithArray:(NSArray *)array frame:(CGRect)frame viewController:(UIViewController *)parentController
{
    self = [super init];
    if (self)
    {
        self.frame = frame;
        self.parentView = parentController.view;
        self.menuToTableViewSpace = 1;
        
        if (!_menuColor)
        {
            _menuColor = KColorGray666;
        }
        
        if (!_menuHighLightColor)
        {
            _menuHighLightColor = kNavigationBarColor;
        }
        
        if (!_menuFont)
        {
            _menuFont = [UIFont systemFontOfSize:14.0];
        }
        
        _array = array;

        _numOfMenu = _array.count;
        
        CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
//        CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
        
        _titles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        _indicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        
        for (int i = 0; i < _numOfMenu; i++)
        {
            IMPullDownMenuItem * menuItem = [_array objectAtIndex:i];
            menuItem.curIndex = -1;
            
            CGPoint position = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2);
            CATextLayer *title = [self createTitleLayerByMenuItem:menuItem position:position];//[self creatTextLayerWithNSString:menuItem.title withColor:_menuColor andPosition:position];
            [self.layer addSublayer:title];
            [_titles addObject:title];
            
            
            CAShapeLayer *indicator = [self creatIndicatorWithColor:_menuHighLightColor andPosition:CGPointMake(position.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2)];
            [self.layer addSublayer:indicator];
            [_indicators addObject:indicator];
            
            if (i != 0)
            {
                CGFloat itemWidth = self.frame.size.width / _numOfMenu;
                UIView * sepLine = [[UIView alloc] initWithFrame:CGRectMake(i * itemWidth, self.frame.size.height / 4, 0.5, self.frame.size.height / 2)];
                [sepLine setBackgroundColor:kSeparatorColor];
                [self addSubview:sepLine];
            }
            
//            if (i != _numOfMenu - 1) {
//                CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height / 2);
//                CAShapeLayer *separator = [self creatSeparatorLineWithColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:243.0/255.0 alpha:1.0] andPosition:separatorPosition];
//                [self.layer addSublayer:separator];
//            }
            
        }
        _tableView = [self creatTableViewAtPosition:CGPointMake(0, self.frame.origin.y + self.frame.size.height)];
        if (IS_IOS7)
        {
            _tableView.tintColor = _menuHighLightColor;
        }
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        // 设置menu, 并添加手势
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
        [self addGestureRecognizer:tapGesture];
        
        // 创建背景
        CGRect sourceRect = CGRectMake(0, self.frame.origin.y + self.frame.size.height + _menuToTableViewSpace, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        _backGroundView = [[UIView alloc] initWithFrame:sourceRect];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround:)];
        [_backGroundView addGestureRecognizer:gesture];
         
        _currentSelectedMenudIndex = -1;
        _show = NO;
    }
    return self;
}

- (void)setMenuHighLightColor:(UIColor *)menuHighLightColor
{
    if (IS_IOS7)
    {
        _menuHighLightColor = menuHighLightColor;
        _tableView.tintColor = _menuHighLightColor;
    }
}


#pragma mark - tapEvent
// 处理菜单点击事件.
- (void)tapMenu:(UITapGestureRecognizer *)paramSender
{
    CGPoint touchPoint = [paramSender locationInView:self];
    
    // 得到tapIndex
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    
    if (tapIndex < 0 || tapIndex >= _numOfMenu)
    {
        return;
    }
    
//    for (int i = 0; i < _numOfMenu; i++)
//    {
//        if (i != tapIndex)
//        {
//            [self animateIndicator:_indicators[i] Forward:NO complete:^{
//                [self animateTitle:_titles[i] show:NO complete:^{
//                }];
//            }];
//        }
//    }
    
    [self hideOtherPopMenu:tapIndex];
    
    if (_myGroup)
    {
        [_myGroup tapCurMenu:self];
    }
    
    if (tapIndex == _currentSelectedMenudIndex && _show)
    {
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            _currentSelectedMenudIndex = tapIndex;
            _show = NO;
            
        }];
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(PullDownMenu:willPullDownAtColumn:)])
        {
            [self.delegate PullDownMenu:self willPullDownAtColumn:tapIndex];
        }
        
        _currentSelectedMenudIndex = tapIndex;
        [_tableView reloadData];
        [self animateIdicator:_indicators[tapIndex] background:_backGroundView tableView:_tableView title:_titles[tapIndex] forward:YES complecte:^{
            _show = YES;
        }];
        
    }

}

/**
 *  收起弹出的菜单
 */
- (void)rollbackPullDownMenu
{
    [self hideOtherPopMenu:-1];
}

- (void)hideOtherPopMenu:(NSInteger)tapIndex
{
    for (int i = 0; i < _numOfMenu; i++)
    {
        if (i != tapIndex)
        {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titles[i] show:NO complete:^{
                }];
            }];
        }
    }
    
    if (tapIndex == -1)
    {
        [self animateBackGroundView:_backGroundView show:NO complete:^{
            [self animateTableView:_tableView show:NO complete:^{
                _currentSelectedMenudIndex = 0;
                _show = NO;
            }];
        }];
    }
}

- (void)tapBackGround:(UITapGestureRecognizer *)paramSender
{
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];

}


#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self confiMenuWithSelectRow:indexPath.row];
    IMPullDownMenuItem * menuItem = [_array objectAtIndex:_currentSelectedMenudIndex];
    menuItem.curIndex = (int)indexPath.row;
    if (self.delegate && [self.delegate respondsToSelector:@selector(PullDownMenu:didSelectRowAtColumn:row:userData:)])
    {
        if (menuItem.unlimitedBtnText && menuItem.unlimitedBtnText.length > 0)
        {
            if (indexPath.row == 0 || !menuItem.userDataArray || menuItem.userDataArray.count <= (indexPath.row - 1))
            {
                [self.delegate PullDownMenu:self didSelectRowAtColumn:_currentSelectedMenudIndex row:indexPath.row userData:nil];
            }
            else
            {
                [self.delegate PullDownMenu:self didSelectRowAtColumn:_currentSelectedMenudIndex row:indexPath.row userData:[menuItem.userDataArray objectAtIndex:indexPath.row - 1]];
            }
        }
        else
        {
            if (menuItem.userDataArray && menuItem.userDataArray.count > indexPath.row)
            {
                [self.delegate PullDownMenu:self didSelectRowAtColumn:_currentSelectedMenudIndex row:indexPath.row userData:[menuItem.userDataArray objectAtIndex:indexPath.row]];
            }
            else
            {
                [self.delegate PullDownMenu:self didSelectRowAtColumn:_currentSelectedMenudIndex row:indexPath.row userData:nil];
            }
        }
    }
    else if (self.delegate && [self.delegate respondsToSelector:@selector(PullDownMenu:didSelectRowAtColumn:row:)])
    {
        [self.delegate PullDownMenu:self didSelectRowAtColumn:_currentSelectedMenudIndex row:indexPath.row];
    }
}


#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_array && _array.count > 0 && _currentSelectedMenudIndex >= 0 && _currentSelectedMenudIndex < _array.count)
    {
        IMPullDownMenuItem * menuItem = [_array objectAtIndex:_currentSelectedMenudIndex];
        
        if (menuItem.unlimitedBtnText && menuItem.unlimitedBtnText.length > 0)
        {
            return menuItem.listItemArray.count + 1;
        }
        else
        {
            return menuItem.listItemArray.count;
        }
    }
    else
    {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = _menuFont;//[UIFont systemFontOfSize:14.0];
    }
    IMPullDownMenuItem * menuItem = [_array objectAtIndex:_currentSelectedMenudIndex];
    
    [cell.textLabel setTextColor:[UIColor darkTextColor]];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    if (menuItem.unlimitedBtnText && menuItem.unlimitedBtnText.length > 0)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = menuItem.unlimitedBtnText;
        }
        else
        {
            cell.textLabel.text = [menuItem.listItemArray objectAtIndex:(indexPath.row - 1)];
        }
    }
    else
    {
        cell.textLabel.text = [menuItem.listItemArray objectAtIndex:indexPath.row];
    }
    
    if (menuItem.curIndex == indexPath.row)
    {
        if (menuItem.curIndex != 0 || !menuItem.unlimitedBtnText || menuItem.unlimitedBtnText.length <= 0)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
    
//    if (cell.textLabel.text == [(CATextLayer *)[_titles objectAtIndex:_currentSelectedMenudIndex] string])
//    {
//        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
////        [cell.textLabel setTextColor:[tableView tintColor]];
//    }
    
    return cell;
}





#pragma mark - animation
- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.x"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];

    if (!anim.removedOnCompletion)
    {
        [indicator addAnimation:anim forKey:anim.keyPath];
    }
    else
    {
        [indicator addAnimation:anim andValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    indicator.fillColor = _menuHighLightColor.CGColor;//forward ? _menuHighLightColor.CGColor : _menuColor.CGColor;
    
    complete();
}


- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete
{
    if (show)
    {
        CGRect sourceRect = CGRectMake(0, self.frame.origin.y + self.frame.size.height + _menuToTableViewSpace, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [_parentView addSubview:view];
        CGRect maskRect = [self.superview convertRect:sourceRect toView:_parentView];
        view.frame = maskRect;
        CGRect rect = [self.superview convertRect:self.frame toView:_parentView];
        self.frame = rect;
        [_parentView addSubview:self];
        
//        [self.superview addSubview:view];
//        [view.superview addSubview:self];

        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        }];
    
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
        
    }
    complete();
    
}

- (void)animateTableView:(UITableView *)tableView show:(BOOL)show complete:(void(^)())complete
{
    if (show)
    {
        tableView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height + _menuToTableViewSpace, [UIScreen mainScreen].bounds.size.width, 0);
        [self.superview addSubview:tableView];
        
        
        CGFloat tableViewHeight = ([tableView numberOfRowsInSection:0] > MAX_LISTITEM_SHOWCOOUNT) ? (MAX_LISTITEM_SHOWCOOUNT * tableView.rowHeight) : ([tableView numberOfRowsInSection:0] * tableView.rowHeight);
        
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height + _menuToTableViewSpace, [UIScreen mainScreen].bounds.size.width, tableViewHeight);
        }];

    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height + _menuToTableViewSpace, [UIScreen mainScreen].bounds.size.width, 0);
        } completion:^(BOOL finished) {
            [tableView removeFromSuperview];
        }];
    }
    complete();
    
}

- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)())complete
{
    if (show)
    {
        title.foregroundColor = _menuHighLightColor.CGColor;
    }
    else
    {
        title.foregroundColor = _menuColor.CGColor;
    }
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    
    if (sizeWidth < size.width)
    {
        title.string = [self trimStringByWidth:sizeWidth string:title.string];
    }
    
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background tableView:(UITableView *)tableView title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete
{
    
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                [self animateTableView:tableView show:forward complete:^{
                }];
            }];
        }];
    }];
    
    complete();
}


#pragma mark - drawing
- (CAShapeLayer *)creatIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CFRelease(bound);
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)creatSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,0)];
    [path addLineToPoint:CGPointMake(160, 20)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CFRelease(bound);
    layer.position = point;
    
    return layer;
}

- (CATextLayer *)creatTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point
{
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = _menuFont.pointSize;// 14.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}


- (UITableView *)creatTableViewAtPosition:(CGPoint)point
{
    UITableView *tableView = [UITableView new];
    
//    tableView.frame = CGRectMake(point.x, point.y, self.frame.size.width, 0);
    tableView.frame = CGRectMake(point.x, point.y + _menuToTableViewSpace, [UIScreen mainScreen].bounds.size.width, 0);
    tableView.rowHeight = 40;
    
    return tableView;
}


#pragma mark - otherMethods
- (NSString *)trimStringByWidth:(CGFloat)width string:(NSString *)string
{
    NSString * retStr = @"...";
    CGFloat fontSize = _menuFont.pointSize;// 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    
    int length = 1;
    while (YES)
    {
        NSMutableString * subStr = [[NSMutableString alloc] initWithCapacity:length + 3];
        [subStr appendString:[string substringToIndex:length]];
        [subStr appendString:@"..."];
        
        CGSize size;
        if (IS_IOS7)
        {
            size = [subStr boundingRectWithSize:CGSizeMake(280, 0)
                                        options:(NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                     attributes:dic context:nil].size;
        }
        else
        {
            size = [subStr XuSizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(280, 0)];
        }

        
        if (size.width > width || length >= string.length)
        {
            break;
        }
        else
        {
            retStr = subStr;
            length++;
        }
    }
    
    return retStr;
}

- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = _menuFont.pointSize;// 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size;
    if (IS_IOS7)
    {
        size = [string boundingRectWithSize:CGSizeMake(280, 0)
                                    options:(NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                 attributes:dic context:nil].size;
    }
    else
    {
        size = [string XuSizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(280, 0)];

    }
    return size;
}

- (void)confiMenuWithSelectRow:(NSInteger)row
{
    IMPullDownMenuItem * menuItem = [_array objectAtIndex:_currentSelectedMenudIndex];
    CATextLayer *title = (CATextLayer *)_titles[_currentSelectedMenudIndex];
    
    if (menuItem.unlimitedBtnText && menuItem.unlimitedBtnText.length > 0)
    {
        if (row == 0)
        {
            title.string = menuItem.title;
        }
        else
        {
            title.string = [menuItem.listItemArray objectAtIndex:(row - 1)];
        }
    }
    else
    {
        title.string = [menuItem.listItemArray objectAtIndex:row];
    }
    
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
        
    }];
    
    CAShapeLayer *indicator = (CAShapeLayer *)_indicators[_currentSelectedMenudIndex];
    indicator.position = CGPointMake(title.position.x + title.frame.size.width / 2 + 8, indicator.position.y);
}


@end

#pragma mark - CALayer Category

@implementation CALayer (MXAddAnimationAndValue)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath
{
    [self addAnimation:anim forKey:keyPath];
    [self setValue:value forKeyPath:keyPath];
}


@end

#pragma mark - IMPullDownMenuGroup implementation
@implementation IMPullDownMenuGroup

- (IMPullDownMenuGroup *)initWithMenuObjects:(IMPullDownMenu *)firstObj, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super init];
    if (self)
    {
        NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:0];
        
        va_list arglist;
        va_start(arglist, firstObj);
        [array addObject:firstObj];
        if ([firstObj isKindOfClass:[IMPullDownMenu class]])
        {
            [firstObj setMyGroup:self];
        }
        
        id arg;
        while((arg = va_arg(arglist, id))) {
            [array addObject:arg];
            if ([arg isKindOfClass:[IMPullDownMenu class]])
            {
                [arg setMyGroup:self];
            }
        }
        va_end(arglist);
        
        self.menuArray = array;
    }
    return self;
}

- (void)tapCurMenu:(IMPullDownMenu *)curMenu
{
    for (IMPullDownMenu * aMenu in _menuArray)
    {
        if (aMenu != curMenu)
        {
            [aMenu hideOtherPopMenu:-1];
        }
    }
}

@end
