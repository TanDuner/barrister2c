//
//  ZhaiLiFangNewViewController.m
//  barrister2c
//
//  Created by 徐书传 on 17/5/1.
//  Copyright © 2017年 Xu. All rights reserved.
//

#import "ZhaiLiFangNewViewController.h"
#import "ZhaiLiFangViewController.h"
#import "YingShowPublishViewController.h"
#import "YingShowViewController.h"


@interface ZhaiLiFangNewViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;


@end

@implementation ZhaiLiFangNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"债立方";
    
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kBaseViewBackgroundColor;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar:YES];
}


#pragma mark - tableView Delegate Methods---

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return [self createSubviewsWithCell:cell indexPath:indexPath];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        ZhaiLiFangViewController *zhailifang = [[ZhaiLiFangViewController alloc] init];
        [self.navigationController pushViewController:zhailifang animated:YES];
    }
    else if (indexPath.row == 1)
    {
        
    }
    else if (indexPath.row == 2)
    {
        YingShowViewController *searchVC = [[YingShowViewController alloc] init];
        [self.navigationController pushViewController:searchVC animated:YES];

    }
    else if (indexPath.row == 3)
    {
        YingShowPublishViewController *publishVC = [[YingShowPublishViewController alloc] init];
        [self.navigationController pushViewController:publishVC animated:YES];
    
    }
}


-(UITableViewCell *)createSubviewsWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 3) {
        return [UITableViewCell new];
    }
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:RECT(LeftPadding, LeftPadding, 30, 30)];
    leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"zlf_list_%ld",indexPath.row + 1]];
    [cell addSubview:leftImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(50, LeftPadding + 8, 200, 14)];
    label.font = SystemFont(14.0f);
    label.textColor = kFontColorNormal;
    
    [cell addSubview:label];
    
    if (indexPath.row == 0) {
        label.text = @"上榜债务信息";
    }
    else if (indexPath.row == 1)
    {
        label.text = @"债权债务关系查询";
    }
    else if (indexPath.row == 2)
    {
        label.text = @"债权债务详细查询";
    }
    else if (indexPath.row == 3)
    {
        label.text = @"上传债权债务信息";
    }
    

    return cell;

}

#pragma mark - getter and setter

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_DEFAULT_HEIGHT) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;

}



@end
