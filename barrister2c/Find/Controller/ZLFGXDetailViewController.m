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

#define ButtonHeight 100

@interface ZLFGXDetailViewController ()

@property (nonatomic,strong) ZLFGXSearchListCell *cell;

@property (nonatomic,strong) UIView *bottomView;

@end

@implementation ZLFGXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"详情";
    
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
        
        _bottomView.backgroundColor = kSeparatorColor;
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:RECT(0, 0, ButtonWidth, ButtonHeight)];
        button1.tag = 110;
        button1.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button1 setImage:[UIImage imageNamed:@"zlf_list_3"] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:RECT(0, button1.bounds.size.height - 23, ButtonWidth, 13)];
        label1.text = @"他的债权图";
        label1.font = SystemFont(12.0f);
        label1.textColor = [UIColor whiteColor];
        label1.textAlignment = NSTextAlignmentCenter;
        [button1 addSubview:label1];
        [_bottomView addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setFrame:RECT(ButtonWidth, 0, ButtonWidth, ButtonHeight)];
        button2.titleLabel.textAlignment = NSTextAlignmentCenter;
        button2.tag = 111;
        [button2 setImage:[UIImage imageNamed:@"zlf_list_3"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:RECT(0, button2.bounds.size.height - 23, ButtonWidth, 13)];
        label2.text = @"他的债务图";
        label2.font = SystemFont(12.0f);
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = [UIColor whiteColor];

        [button2 addSubview:label2];
        
        [_bottomView addSubview:button2];
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button3 setFrame:RECT(ButtonWidth *2, 0, ButtonWidth, ButtonHeight)];
        button3.titleLabel.textAlignment = NSTextAlignmentCenter;
        button3.tag = 112;
        [button3 addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
        [button3 setImage:[UIImage imageNamed:@"ZLFGX"] forState:UIControlStateNormal];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:RECT(0, button3.bounds.size.height - 23, ButtonWidth, 13)];
        label3.text = @"债权关系图";
        label3.font = SystemFont(12.0f);
        label3.textAlignment = NSTextAlignmentCenter;
        label3.textColor = [UIColor whiteColor];

        [button3 addSubview:label3];

        
        [_bottomView addSubview:button3];
        
        
        
        UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button4 setFrame:RECT(ButtonWidth *3, 0, ButtonWidth, ButtonHeight)];
        button4.titleLabel.textAlignment = NSTextAlignmentCenter;
        button4.tag = 113;
        [button4 addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
        [button4 setImage:[UIImage imageNamed:@"ZLFGX"] forState:UIControlStateNormal];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:RECT(0, button3.bounds.size.height - 23, ButtonWidth, 13)];
        label4.text = @"债务关系图";
        label4.font = SystemFont(12.0f);
        label4.textAlignment = NSTextAlignmentCenter;
        label4.textColor = [UIColor whiteColor];

        [button4 addSubview:label4];

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
            
            url = [NSString stringWithFormat:@"%@/wap/toShowOneDebtLoopData.do?cduserId=%@",BaseUrl,self.userModel.yingShowUserId];
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
