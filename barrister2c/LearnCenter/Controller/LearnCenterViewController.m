//
//  LearnCenterViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/15.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LearnCenterViewController.h"
#import "LearnCenterCell.h"
#import "LearnCenterModel.h"

@implementation LearnCenterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self loadItems];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma -mark -----UI-------
-(void)configView
{
    
}



#pragma -mark -----Data-----
-(void)loadItems
{
    LearnCenterModel *model = [[LearnCenterModel alloc] init];
    model.learnTitle = @"法律知识法规学习";
    model.imageUrl = @"http://img4.duitang.com/uploads/item/201508/26/20150826212734_ST5BC.thumb.224_0.jpeg";
    model.learnSubtitle = @"深入贯彻党的行动路线";
    model.publishTime = @"2016/03/24";
    
    
    LearnCenterModel *model1 = [[LearnCenterModel alloc] init];
    model1.imageUrl = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=327417392,2097894166&fm=116&gp=0.jpg";
    model1.learnTitle = @"刑法相关知识讲座";
    model1.publishTime = @"2016/04/25";
    model1.learnSubtitle = @"更好的理解刑法的相关知识";
    
    
    LearnCenterModel *model2 = [[LearnCenterModel alloc] init];
    model2.imageUrl = @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=731016823,2238050103&fm=116&gp=0.jpg";
    model2.learnTitle = @"婚姻法的始末";
    model2.publishTime = @"2016/04/26 15:00";
    model2.learnSubtitle = @"帮助你在婚姻法中立于不败之地";
    
    [self.items addObject:model];
    [self.items addObject:model1];
    [self.items addObject:model2];
    
    [self.tableView reloadData];
}

#pragma -mark -----UITableVIewDelegate Methods------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"learnCenterCell";
    
    LearnCenterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[LearnCenterCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    LearnCenterModel *model =  (LearnCenterModel *)[self.items objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
