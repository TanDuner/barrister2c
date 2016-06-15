//
//  CityChooseViewController.m
//  yoyo
//
//  Created by YoYo on 16/5/12.
//  Copyright © 2016年 cn.yoyoy.mw. All rights reserved.
//

#import "CityChooseViewController.h"


@interface CityChooseViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *mainTableView; //主
@property (strong, nonatomic) UITableView *subTableView; //次
@property (strong, nonatomic) NSArray *cityList; //城市列表
@property (assign, nonatomic) NSInteger selIndex;//主列表当前选中的行
@property (assign, nonatomic) NSIndexPath *subSelIndex;//子列表当前选中的行
@property (assign, nonatomic) BOOL clickRefresh;//是否是点击主列表刷新子列表,系统刚开始默认为NO
@property (copy, nonatomic) NSString *province; //选中的省
@property (copy, nonatomic) NSString *area; //选中的地区
@property (strong, nonatomic) UIButton *sureBtn;//push过来的时候，右上角的确定按钮

@end

@implementation CityChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
}

//赋值
- (void)returnCityInfo:(CityBlock)block {
    _cityInfo = block;
}

#pragma mark 创建两个tableView
- (void)addTableView {
    self.title = @"选择城市";
    self.view.backgroundColor = [UIColor whiteColor];
    //获取目录下的city.plist文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    _cityList = [NSArray arrayWithContentsOfFile:plistPath];
    //刚开始，默认选中第一行
    _selIndex = 0;
    _province = _cityList.firstObject[@"state"]; //赋值
    //tableView
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH / 4 + 1, SCREENHEIGHT) style:UITableViewStylePlain];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    [_mainTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone]; //默认省份选中第一行
    [self.view addSubview:_mainTableView];
    _subTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREENWIDTH / 4, 0, SCREENWIDTH * 3 / 4, SCREENHEIGHT - (self.navigationController == nil ? 0 : 64)) style:UITableViewStylePlain];
    _subTableView.dataSource = self;
    _subTableView.delegate = self;
    [self.view addSubview:_subTableView];
    if (self.navigationController != nil) { //push过来这个页面的时候
        [self initNavigationRightTextButton:@"确定" action:@selector(sureAction)];
        
    }
}
#pragma mark 确认选择
-(void) sureAction {
    if (_cityInfo != nil && _province != nil && _area != nil) {
        _cityInfo(_province, _area);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [XuUItlity showInformationHint:@"请选择城市" completionBlock:nil];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_mainTableView]) {
        return _cityList.count;
    }else {
        NSArray *areaList = _cityList[_selIndex][@"cities"];
        return areaList.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_mainTableView]) {
        static NSString *mainCellId = @"mainCellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellId];
        }
        cell.textLabel.text = _cityList[indexPath.row][@"state"];
        return cell;
    }else {
        static NSString *subCellId = @"subCellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:subCellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *areaList = _cityList[_selIndex][@"cities"];
        cell.textLabel.text = areaList[indexPath.row];
        //当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打勾的
        if (_subSelIndex == indexPath && _clickRefresh == NO) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_mainTableView]) {
        _province = _cityList[indexPath.row][@"state"]; //赋值
        if (self.navigationController != nil) { //不是push过来的
            _sureBtn.hidden = YES;
        }
        _selIndex = indexPath.row;
        _clickRefresh = YES;
        [_subTableView reloadData];
    }else {
        _area = _cityList[_selIndex][@"cities"][indexPath.row]; //赋值
        _clickRefresh = NO;
        //之前选中的，取消选择
        UITableViewCell *celled = [tableView cellForRowAtIndexPath:_subSelIndex];
        celled.accessoryType = UITableViewCellAccessoryNone;
        //记录当前选中的位置索引
        _subSelIndex = indexPath;
        //当前选择的打勾
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (self.navigationController == nil) { //不是push过来的
            if (_cityInfo != nil) {
                _cityInfo(_province, _area);
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else {
            _sureBtn.hidden = false;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
