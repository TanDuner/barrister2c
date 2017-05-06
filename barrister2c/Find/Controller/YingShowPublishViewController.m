//
//  YingShowPublishViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowPublishViewController.h"
#import "NinaPagerView.h"
#import "YingShowFirstViewController.h"
#import "YingShowSecAndThirdViewController.h"
#import "YingShowProxy.h"
#import "BarristerLoginManager.h"
#import "YingShowInfoModel.h"

@interface YingShowPublishViewController ()


@property (nonatomic,strong) NinaPagerView *yingShowPageView;

@property (nonatomic,strong) YingShowFirstViewController *firstVC;
@property (nonatomic,strong) YingShowSecAndThirdViewController *secondVC;
@property (nonatomic,strong) YingShowSecAndThirdViewController *thirdVC;
@property (nonatomic,strong) YingShowProxy *proxy;


@end

@implementation YingShowPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    self.title = @"发布债权债务信息";
    
    [self initNavigationRightTextButton:@"发布" action:@selector(submitAction)];
    
}

-(void)submitAction
{
    //没登录 让登录
    if (![[BaseDataSingleton shareInstance].loginState isEqualToString:@"1"]) {
        [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
        return;
    }

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.firstVC.moneyTextField.text.length == 0 || IS_EMPTY(self.firstVC.moneyTextField.text)) {
        [XuUItlity showFailedHint:@"请填写金额" completionBlock:nil];
        return;
    }
    
    if ([self.firstVC.timeLabel.text isEqualToString:@"请选择形成时间"]) {
        [XuUItlity showFailedHint:@"请选择形成时间" completionBlock:nil];
        return;
    }
    
    if (!self.firstVC.selectImage) {
        [XuUItlity showFailedHint:@"请上传凭证图片" completionBlock:nil];
        return;
    }

    
    
    
    [params setObject:[YingShowInfoModel getSubmitStrWithSelectObject:self.firstVC.typeScrollView.selectObject] forKey:@"type"];
    [params setObject:self.firstVC.moneyTextField.text forKey:@"money"];
    [params setObject:[YingShowInfoModel getSubmitStrWithSelectObject:self.firstVC.statusScrollView.selectObject] forKey:@"creditDebtStatus"];
    [params setObject:self.firstVC.descTextView.text?self.firstVC.descTextView.text:@"" forKey:@"desc"];
    [params setObject:self.firstVC.timeLabel.text forKey:@"creditDebtTime"];
    
    if (self.firstVC.typeScrollView.selectObject) {
        [params setObject:[YingShowInfoModel getSubmitStrWithSelectObject:self.firstVC.pingzhengScrollView.selectObject] forKey:@"proofName"];
    }
    
    
    NSData *imageData = [XuUtlity p_compressImage:self.firstVC.selectImage];


    NSData *panjueData = [XuUtlity p_compressImage:self.firstVC.selectPanjueImage];
    
    
    
    
    if (![self checkZhaiQuanInfoWithParams:params]) {
        return;
    };

    if (![self checkZhaiWuInfoWithParams:params]) {
        return;
    }
    
    [self.proxy publishYingShowWithParams:params imageData:imageData panjueshuImageData:panjueData Block:^(id returnData, BOOL success) {
        if (success) {
            
            [XuUItlity showSucceedHint:@"发布成功" completionBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        }
        else{
            if ([returnData respondsToSelector:@selector(objectForKey:)]) {
                NSString *resultCode = [NSString stringWithFormat:@"%@",[returnData objectForKey:@"resultCode"]];
                if (resultCode.integerValue == 901) {
                    [XuUItlity showFailedHint:@"发布失败" completionBlock:nil];
                    [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
                    return;
                }
            }
            
            [XuUItlity showFailedHint:@"发布失败" completionBlock:nil];
        }
    }];

}


-(BOOL)checkZhaiQuanInfoWithParams:(NSMutableDictionary *)params
{
    //债权人
    //是公司
    if ([self.secondVC.type isEqualToString:@"1"]) {
        
        if (IS_EMPTY(self.secondVC.contactTextField.text)) {
            [XuUItlity showFailedHint:@"请填写联系人" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.secondVC.companyNameTextField.text)) {
            [XuUItlity showFailedHint:@"请填写公司名称" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.secondVC.companyPhoneTextField.text)) {
            [XuUItlity showFailedHint:@"请填写公司电话" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.secondVC.licenseCodeTextField.text)) {
            [XuUItlity showFailedHint:@"请填写信用代码" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.secondVC.companyAddressTextField.text)) {
            [XuUItlity showFailedHint:@"请填写公司地址" completionBlock:nil];
            return NO;
        }
        
        
        [params setObject:self.secondVC.contactTextField.text forKey:@"creditName"];
        [params setObject:self.secondVC.companyNameTextField.text forKey:@"creditCompany"];
        [params setObject:self.secondVC.companyPhoneTextField.text forKey:@"creditCompanyPhone"];
        [params setObject:self.secondVC.licenseCodeTextField.text forKey:@"creditLicenseNuber"];
        [params setObject:self.secondVC.companyAddressTextField.text forKey:@"creditAddress"];
        
        
    }
    else{//是个人
        
        if (IS_EMPTY(self.secondVC.nameTextField.text)) {
            [XuUItlity showFailedHint:@"请填写联系人" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.secondVC.phoneTextField.text)) {
            [XuUItlity showFailedHint:@"请填写联系电话" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.secondVC.ID_NumberTextField.text)) {
            [XuUItlity showFailedHint:@"请填写身份证" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.secondVC.addressTextField.text)) {
            [XuUItlity showFailedHint:@"请填写联系地址" completionBlock:nil];
            return NO;
        }
        
        
        [params setObject:self.secondVC.nameTextField.text forKey:@"creditName"];
        [params setObject:self.secondVC.phoneTextField.text forKey:@"creditPhone"];
        [params setObject:self.secondVC.ID_NumberTextField.text forKey:@"creditID_number"];
        [params setObject:self.secondVC.addressTextField.text forKey:@"creditAddress"];
        
    }
    return YES;
}


-(BOOL)checkZhaiWuInfoWithParams:(NSMutableDictionary *)params
{
    //债务
    //公司
    if ([self.thirdVC.type isEqualToString:@"1"]) {
        
        if (IS_EMPTY(self.thirdVC.contactTextField.text)) {
            [XuUItlity showFailedHint:@"请填写联系人" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.thirdVC.companyNameTextField.text)) {
            [XuUItlity showFailedHint:@"请填写公司名称" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.thirdVC.companyPhoneTextField.text)) {
            [XuUItlity showFailedHint:@"请填写公司电话" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.thirdVC.licenseCodeTextField.text)) {
            [XuUItlity showFailedHint:@"请填写信用代码" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.thirdVC.companyAddressTextField.text)) {
            [XuUItlity showFailedHint:@"请填写公司地址" completionBlock:nil];
            return NO;
        }
        
        
        [params setObject:self.thirdVC.contactTextField.text forKey:@"debtName"];
        [params setObject:self.thirdVC.companyNameTextField.text forKey:@"debtCompany"];
        [params setObject:self.thirdVC.companyPhoneTextField.text forKey:@"debtCompanyPhone"];
        [params setObject:self.thirdVC.licenseCodeTextField.text forKey:@"debtLicenseNuber"];
        [params setObject:self.thirdVC.companyAddressTextField.text forKey:@"debtAddress"];
        
    }
    else{//是个人
        
        if (IS_EMPTY(self.thirdVC.nameTextField.text)) {
            [XuUItlity showFailedHint:@"请填写联系人" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.thirdVC.phoneTextField.text)) {
            [XuUItlity showFailedHint:@"请填写联系电话" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.thirdVC.ID_NumberTextField.text)) {
            [XuUItlity showFailedHint:@"请填写身份证" completionBlock:nil];
            return NO;
        }
        
        if (IS_EMPTY(self.thirdVC.addressTextField.text)) {
            [XuUItlity showFailedHint:@"请填写联系地址" completionBlock:nil];
            return NO;
        }
        
        
        [params setObject:self.thirdVC.nameTextField.text forKey:@"debtName"];
        [params setObject:self.thirdVC.phoneTextField.text forKey:@"debtPhone"];
        [params setObject:self.thirdVC.ID_NumberTextField.text forKey:@"debtID_number"];
        [params setObject:self.thirdVC.addressTextField.text forKey:@"debtAddress"];

    }
    
    return YES;

}



-(void)initView
{
    NSArray *titlesArray = @[@"填写债权人信息",@"填写债务人信息",@"债权债务信息"];
    
    NSMutableArray *VCArray = [NSMutableArray array];
    [VCArray addObject:self.secondVC];
    [VCArray addObject:self.thirdVC];
    [VCArray addObject:self.firstVC];
    
    
    NSArray *colorArray = @[
                            kNavigationBarColor, /**< 选中的标题颜色 Title SelectColor  **/
                            KColorGray666, /**< 未选中的标题颜色  Title UnselectColor **/
                            kNavigationBarColor, /**< 下划线颜色 Underline Color   **/
                            [UIColor whiteColor], /**<  上方菜单栏的背景颜色 TopTab Background Color   **/
                            ];
    
    
    
    self.yingShowPageView  = [[NinaPagerView alloc] initWithTitles:titlesArray WithVCs:VCArray WithColorArrays:colorArray isAlertShow:NO];
    
    
    [self.view addSubview:self.yingShowPageView];
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showTabbar:YES];
    
}


#pragma -mark --Getter--

-(YingShowFirstViewController *)firstVC
{
    if (!_firstVC) {
        _firstVC = [[YingShowFirstViewController alloc] init];
    }
    return _firstVC;
}

-(YingShowSecAndThirdViewController *)secondVC
{
    if (!_secondVC) {
        _secondVC = [[YingShowSecAndThirdViewController alloc] init];
    }
    return _secondVC;
}

-(YingShowSecAndThirdViewController *)thirdVC
{
    if (!_thirdVC) {
        _thirdVC = [[YingShowSecAndThirdViewController alloc] init];
    }
    return _thirdVC;
}


-(YingShowProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[YingShowProxy alloc] init];
    }
    return _proxy;
}

@end
