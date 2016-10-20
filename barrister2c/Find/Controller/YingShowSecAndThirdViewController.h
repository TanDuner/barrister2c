//
//  YingShowSecAndThirdViewController.h
//  barrister2c
//
//  Created by 徐书传 on 16/10/13.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseViewController.h"
#import "BorderTextFieldView.h"



@interface YingShowSecAndThirdViewController : BaseViewController

// 0 是个人 1 是公司
@property (nonatomic,strong) NSString *type;


@property (nonatomic,strong) BorderTextFieldView *nameTextField;

@property (nonatomic,strong) BorderTextFieldView *phoneTextField;

@property (nonatomic,strong) BorderTextFieldView *ID_NumberTextField;

@property (nonatomic,strong) BorderTextFieldView *addressTextField;




/////////////////////////////

@property (nonatomic,strong) BorderTextFieldView *contactTextField;

@property (nonatomic,strong) BorderTextFieldView *companyNameTextField;

@property (nonatomic,strong) BorderTextFieldView *companyPhoneTextField;

@property (nonatomic,strong) BorderTextFieldView *licenseCodeTextField;

@property (nonatomic,strong) BorderTextFieldView *companyAddressTextField;



@end
