//
//  MyLikeViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/18.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "MyLikeViewController.h"
#import "BarristerLawerModel.h"
#import "LawerListCell.h"

@implementation MyLikeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configView];
    
}

#pragma -mark ---ConfigData-----

-(void)configView
{
    self.title  = @"我的收藏";
    
    [self addRefreshHeader];
    [self addLoadMoreFooter];
}

#pragma -mark --ConfigData

-(void)loadItems
{
    
    BarristerLawerModel *model = [[BarristerLawerModel alloc] init];
    model.name = @"张大强";
    model.workingStartYear = @"1990";
    model.workYears = @"17";
    model.rating = 4.5;
    model.area = @"北京朝阳";
    model.company = @"振华律师事务所";
    model.userIcon = @"http://img4.duitang.com/uploads/item/201508/26/20150826212734_ST5BC.thumb.224_0.jpeg";
    model.goodAt = @"民事诉讼|金融|财产纠纷";
    
    BarristerLawerModel *model1 = [[BarristerLawerModel alloc] init];
    model1.name = @"李言";
    model1.workingStartYear = @"2008";
    model1.workYears = @"8";
    model1.rating = 3.5;
    model1.goodAt = @"经济犯罪|法律顾问|家庭";
    model1.area = @"北京丰台";
    model1.company = @"京城律师事务所";
    model1.userIcon = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=327417392,2097894166&fm=116&gp=0.jpg";
    
    
    
    [self.items addObject:model];
    [self.items addObject:model1];
    
    [self.tableView reloadData];
    
    [self endRefreshing];
}


-(void)loadMoreData
{
    
    BarristerLawerModel *model = [[BarristerLawerModel alloc] init];
    model.name = @"张大强";
    model.workingStartYear = @"1990";
    model.workYears = @"17";
    model.rating = 4.5;
    model.area = @"北京朝阳";
    model.company = @"振华律师事务所";
    model.userIcon = @"http://img4.duitang.com/uploads/item/201508/26/20150826212734_ST5BC.thumb.224_0.jpeg";
    model.goodAt = @"民事诉讼|金融|财产纠纷";
    
    BarristerLawerModel *model1 = [[BarristerLawerModel alloc] init];
    model1.name = @"李言";
    model1.workingStartYear = @"2008";
    model1.workYears = @"8";
    model1.rating = 3.5;
    model.goodAt = @"经济犯罪|法律顾问|家庭";
    model1.area = @"北京丰台";
    model1.company = @"京城律师事务所";
    model1.userIcon = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=327417392,2097894166&fm=116&gp=0.jpg";
    
    BarristerLawerModel *model2 = [[BarristerLawerModel alloc] init];
    model2.name = @"李言";
    model2.workingStartYear = @"2008";
    model2.workYears = @"8";
    model2.rating = 3.5;
    model2.goodAt = @"经济犯罪|法律顾问|家庭";
    model2.area = @"北京丰台";
    model2.company = @"京城律师事务所";
    model2.userIcon = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=327417392,2097894166&fm=116&gp=0.jpg";
    
    [self.items addObject:model];
    [self.items addObject:model1];
    [self.items addObject:model2];
    
    [self.tableView reloadData];
    
    [self endLoadMoreWithNoMoreData:NO];
    
}


#pragma -mark --UITableView Delegate 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif = @"identif";
    LawerListCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[LawerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
    }
    if (self.items.count > indexPath.row) {
        BarristerLawerModel *model = [self.items objectAtIndex:indexPath.row];
        cell.model = model;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LawerListCell getCellHeight];
}



@end
