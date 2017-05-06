//
//  ZLFGXDetailViewController.m
//  barrister2c
//
//  Created by 徐书传 on 17/5/6.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "ZLFGXDetailViewController.h"
#import "ZLFGXSearchListCell.h"

#define ButtonWidth (SCREENWIDTH/4.0)

#define PICBASEPREURL1   @"/wap/toShowOneCreditorData.do?cduserId=%@"

#define PICBASEPREURL2   @"/wap/toShowOneDebtData.do?cduserId=%@"

#define PICBASEPREURL3   @"/wap/toShowOneCreditorLoopData.do?cduserId=%@"

#define PICBASEPREURL4   @"/wap/clientservice/wap/toShowOneDebtLoopData.do?cduserId=%@"

#import "BaseWebViewController.h"

#define ButtonHeight 80

@interface ZLFGXDetailViewController ()

@property (nonatomic,strong) ZLFGXSearchListCell *cell;

@property (nonatomic,strong) UIView *bottomView;

@end

@implementation ZLFGXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.cell];
    
    [self.view addSubview:self.bottomView];
}



-(ZLFGXSearchListCell *)cell
{
    if (!_cell) {
        _cell = [[ZLFGXSearchListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _cell.backgroundColor = [UIColor whiteColor];
        [_cell setFrame:RECT(0, 0, SCREENWIDTH, 170)];
        _cell.model = self.userModel;
        
        [_cell setNeedsLayout];
    }
    return _cell;

}





#pragma mark - getter and setter

-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:RECT(0, 170, SCREENWIDTH, ButtonHeight)];
        
        _bottomView.backgroundColor = KColorGray999;
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:RECT(LeftPadding, 0, ButtonWidth, ButtonHeight)];
        [button1 setTitle:@"他的债权图" forState:UIControlStateNormal];
        button1.imageEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
        button1.titleLabel.font = SystemFont(12.0);
        button1.tag = 110;
        button1.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button1 setImage:[UIImage imageNamed:@"zlf_list_2"] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setFrame:RECT(LeftPadding + ButtonWidth, 0, ButtonWidth, ButtonHeight)];
        button2.titleLabel.textAlignment = NSTextAlignmentCenter;
        button2.tag = 111;
        [button2 setTitle:@"他的债务图" forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"zlf_list_2"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
        button2.titleLabel.font = SystemFont(12.0);
        button2.imageEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
        [_bottomView addSubview:button2];
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button3 setFrame:RECT(LeftPadding + ButtonWidth *2, 0, ButtonWidth, ButtonHeight)];
        button3.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button3 setTitle:@"债权关系图" forState:UIControlStateNormal];
        button3.tag = 112;
        [button3 addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
        [button3 setImage:[UIImage imageNamed:@"zlf_list_3"] forState:UIControlStateNormal];
        button3.titleLabel.font = SystemFont(12.0);
        button3.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
        [_bottomView addSubview:button3];
        
        UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button4 setFrame:RECT(LeftPadding + ButtonWidth *3, 0, ButtonWidth, ButtonHeight)];
        button4.titleLabel.textAlignment = NSTextAlignmentCenter;
        button4.tag = 113;
        [button4 setTitle:@"债务关系图" forState:UIControlStateNormal];
        [button4 addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
        [button4 setImage:[UIImage imageNamed:@"zlf_list_3"] forState:UIControlStateNormal];
        button4.titleLabel.font = SystemFont(12.0);
        button4.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
        [_bottomView addSubview:button4];
        
        
    }
    return _bottomView;
}

-(void)clickAciton:(UIButton *)button
{
    NSString *url;
    NSString *showTitle;
    switch (button.tag) {
        case 110:
        {
            url = [NSString stringWithFormat:@"%@/wap/toShowOneCreditorData.do?cduserId=%@",BaseUrl,self.userModel.yingShowUserId];
            showTitle = @"他的债权图";
        }
            break;
            
            
        case 111:
        {
            url = [NSString stringWithFormat:@"%@/wap/toShowOneDebtData.do?cduserId=%@",BaseUrl,self.userModel.yingShowUserId];
            showTitle = @"他的债务图";
        }
            break;
            
            
        case 112:
        {
            url = [NSString stringWithFormat:@"%@/wap/toShowOneCreditorLoopData.do?cduserId=%@",BaseUrl,self.userModel.yingShowUserId];
            showTitle = @"债权关系图";
        
        }
            break;
            
        case 113:
        {
            
            url = [NSString stringWithFormat:@"%@/wap/clientservice/wap/toShowOneDebtLoopData.do?cduserId=%@",BaseUrl,self.userModel.yingShowUserId];
            showTitle = @"债务关系图";
            
        }
            break;
            
            
        default:
            break;
    }
    
    
    
    BaseWebViewController *baseweb = [[BaseWebViewController alloc] init];
    
    baseweb.url = url;
    baseweb.showTitle = showTitle;
    
    [self.navigationController pushViewController:baseweb animated:YES];
    
}


@end
