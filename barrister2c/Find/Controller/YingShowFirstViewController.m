//
//  YingShowFirstViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/13.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowFirstViewController.h"
#import "ZHPickView.h"
#import "YingShowHorSelectModel.h"
#import "AJPhotoPickerViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface YingShowFirstViewController ()<UITextViewDelegate,XWMoneyTextFieldLimitDelegate,AJPhotoPickerProtocol,ZHPickViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,YingShowHorScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) ZHPickView *pickview;

@property (nonatomic,strong) UIView *panjueView;

@property (nonatomic,strong) UIView *pingzhengView;

@property (nonatomic,assign) BOOL isPanjueType;

@end


@implementation YingShowFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self createView];
}


-(void)createView
{
    [self.view addSubview:self.contentScrollView];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, LeftPadding, 200, 15)];
    typeLabel.textColor = KColorGray333;
    typeLabel.text = @"类型";
    typeLabel.textAlignment = NSTextAlignmentLeft;
    typeLabel.font = SystemFont(15.0f);
    [self.contentScrollView addSubview:typeLabel];

    
    NSArray *titleArray = @[@"合同欠款",@"借款",@"侵权",@"劳动与劳务",@"其他"];
    
    NSMutableArray *itemArray = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i ++) {
        YingShowHorSelectModel *model = [[YingShowHorSelectModel alloc] init];
        if (i == 0) {
            model.isSelected = YES;
        }
        model.titleStr = titleArray[i];
        [itemArray addObject:model];
    }
    
    
    self.typeScrollView = [[YingShowHorSelectScrollView alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(typeLabel.frame) + 5, SCREENWIDTH - 20, 15) items:itemArray];
    
    [self.contentScrollView addSubview:self.typeScrollView];

    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.typeScrollView.frame) + 10, 200, 15)];
    statusLabel.textColor = KColorGray333;
    statusLabel.text = @"债状态";
    statusLabel.textAlignment = NSTextAlignmentLeft;
    statusLabel.font = SystemFont(15.0f);
    [self.contentScrollView addSubview:statusLabel];
    
    NSArray *statusTitlteArray = @[@"未起诉",@"诉讼中",@"执行中",@"已过失效"];
    
    NSMutableArray *statusItemArray = [NSMutableArray array];
    for (int i = 0; i < statusTitlteArray.count; i ++) {
        YingShowHorSelectModel *model = [[YingShowHorSelectModel alloc] init];
        model.titleStr = statusTitlteArray[i];
        if (i == 0) {
            model.isSelected = YES;
        }
        [statusItemArray addObject:model];
    }
    
    
    self.statusScrollView = [[YingShowHorSelectScrollView alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(statusLabel.frame) + 5, SCREENWIDTH - 20, 15) items:statusItemArray];
    self.statusScrollView.horScrollDelegate = self;
    
    [self.contentScrollView addSubview:self.statusScrollView];

    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.statusScrollView.frame) + 10, 200, 15)];
    descLabel.textColor = KColorGray333;
    descLabel.text = @"描述";
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.font = SystemFont(15.0f);
    [self.contentScrollView addSubview:descLabel];
    
    
    
    _descTextView = [[UITextView alloc] initWithFrame:RECT(0, CGRectGetMaxY(descLabel.frame) + 10, SCREENWIDTH, 150)];
    _descTextView.delegate = self;
    _descTextView.textColor = KColorGray999;
    [self.contentScrollView addSubview:_descTextView];
    
    
    self.moneyTextField = [[XWMoneyTextField alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(_descTextView.frame) + 10, SCREENWIDTH  -LeftPadding - LeftPadding, 44)];
    self.moneyTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.moneyTextField.placeholder = @"请输入金额";
    self.moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTextField.limit.delegate = self;
    self.moneyTextField.limit.max = @"9999999999.99";
    [self.contentScrollView addSubview:self.moneyTextField];

    self.timeLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.moneyTextField.frame) + 20, 200, 15)];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.userInteractionEnabled = YES;
    self.timeLabel.font = SystemFont(14.0f);
    self.timeLabel.text = @"请选择形成时间";
    self.timeLabel.textColor = KColorGray333;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTime)];
    [self.timeLabel addGestureRecognizer:tap];
    
    [self.contentScrollView addSubview:self.timeLabel];
    
    [self.contentScrollView addSubview:self.panjueView];
    
    [self.contentScrollView addSubview:self.pingzhengView];
    
    self.panjueView.hidden = YES;
    
    
    self.contentScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.addImageView.frame) + 300 + 400);
    
    UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [self.contentScrollView addGestureRecognizer:hideTap];
    
    
    
    
    
}

-(void)hideKeyBoard
{
    [self.view endEditing:YES];
}

-(void)addImageAction:(UITapGestureRecognizer *)tap
{
    UIView *tapView = tap.view;

    AJPhotoPickerViewController *picker = [[AJPhotoPickerViewController alloc] init];
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = YES;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return YES;
    }];

    
    if (tapView == self.addImageView) {
        picker.isPanjueType = NO;
    }
    else if(tapView == self.addPanjueImageView)
    {
        picker.isPanjueType = YES;
    }
    
    [self presentViewController:picker animated:YES completion:nil];

}

//选择完成
- (void)photoPicker:(AJPhotoPickerViewController *)picker didSelectAssets:(NSArray *)assets
{
    if (assets.count == 1) {
        ALAsset *asset = assets[0];
        
        if (picker.isPanjueType) {
            self.selectPanjueImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            self.addPanjueImageView.image = self.selectPanjueImage;
        }
        else{
            self.selectImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            self.addImageView.image = self.selectImage;
        }
        
        
    }
    [picker dismissViewControllerAnimated:NO completion:^{
        [self.view setFrame:RECT(SCREENWIDTH *2, 0, SCREENHEIGHT, self.view.height)];
    }];

}

- (void)photoPickerTapCameraAction:(AJPhotoPickerViewController *)picker {
    [self checkCameraAvailability:^(BOOL auth) {
        if (!auth) {
            NSLog(@"没有访问相机权限");
            return;
        }
        
        [picker dismissViewControllerAnimated:NO completion:^{
            [self.view setFrame:RECT(SCREENWIDTH *2, 0, SCREENHEIGHT, self.view.height)];
        }];
        
        UIImagePickerController *cameraUI = [UIImagePickerController new];
        cameraUI.allowsEditing = NO;
        cameraUI.delegate = self;
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraUI.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
        self.isPanjueType = picker.isPanjueType;
        [self presentViewController: cameraUI animated: YES completion:nil];
    }];
}



/**
 *  相机拍摄完成图片
 *
 *  @param picker
 *  @param image
 *  @param editingInfo
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImage* image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
        if (self.isPanjueType) {
            self.selectPanjueImage = image;
            self.addPanjueImageView.image = self.selectPanjueImage;
        }
        else{
            self.selectImage = image;
            self.addImageView.image = self.selectImage;
        }
        
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.view setFrame:RECT(SCREENWIDTH *2, 0, SCREENHEIGHT, self.view.height)];
    }];
    
}


- (void)photoPickerDidCancel:(AJPhotoPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self.view setFrame:RECT(SCREENWIDTH *2, 0, SCREENHEIGHT, self.view.height)];
    }];
}


- (void)checkCameraAvailability:(void (^)(BOOL auth))block {
    BOOL status = NO;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        status = YES;
    } else if (authStatus == AVAuthorizationStatusDenied) {
        status = NO;
    } else if (authStatus == AVAuthorizationStatusRestricted) {
        status = NO;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                if (block) {
                    block(granted);
                }
            } else {
                if (block) {
                    block(granted);
                }
            }
        }];
        return;
    }
    if (block) {
        block(status);
    }
}



-(void)selectTime
{
    
    NSDate *date=[NSDate date];
    _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    _pickview.delegate=self;
    
    [_pickview show];

}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if (resultString && resultString.length > 10) {
        resultString = [resultString substringToIndex:10];
    }
    self.timeLabel.text = resultString;
}

- (void)valueChange:(id)sender
{
    
}

#pragma -mark ---Getter---

-(UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:RECT(0, 0, SCREENWIDTH, SCREENHEIGHT - NAVBAR_HIGHTIOS_7 - 40)];

    }
    return _contentScrollView;
}


-(UIView *)pingzhengView
{
    if (!_pingzhengView) {
        _pingzhengView = [[UIView alloc] initWithFrame:RECT(0, CGRectGetMaxY(self.timeLabel.frame) + 10, SCREENWIDTH, 120)];
        
        
        UILabel *pingzhengLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 10, 200, 15)];
        pingzhengLabel.textColor = KColorGray333;
        pingzhengLabel.text = @"凭证类型";
        pingzhengLabel.textAlignment = NSTextAlignmentLeft;
        pingzhengLabel.font = SystemFont(15.0f);
        [_pingzhengView addSubview:pingzhengLabel];
        
        NSArray *pingzhengTitleArray = @[@"合同",@"协议",@"欠条",@"其他"];
        
        NSMutableArray *pingzhengItemArray = [NSMutableArray array];
        for (int i = 0; i < pingzhengTitleArray.count; i ++) {
            YingShowHorSelectModel *model = [[YingShowHorSelectModel alloc] init];
            if (i == 0) {
                model.isSelected = YES;
            }
            model.titleStr = pingzhengTitleArray[i];
            [pingzhengItemArray addObject:model];
        }
        
        
        self.pingzhengScrollView = [[YingShowHorSelectScrollView alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(pingzhengLabel.frame) + 5, SCREENWIDTH - 20, 15) items:pingzhengItemArray];
        
        [_pingzhengView addSubview:self.pingzhengScrollView];
        
        
        UILabel *selectImageLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.pingzhengScrollView.frame) + 40, 200, 15)];
        
        selectImageLabel.font = SystemFont(15.0);
        selectImageLabel.textAlignment = NSTextAlignmentLeft;
        selectImageLabel.textColor = KColorGray333;
        selectImageLabel.text = @"选择凭证图片";
        [_pingzhengView addSubview:selectImageLabel];
        
        self.addImageView = [[UIImageView alloc] initWithFrame:RECT(SCREENWIDTH - 20 - 75, CGRectGetMaxY(self.pingzhengScrollView.frame)  + 10, 75, 75)];
        self.addImageView.image = [UIImage imageNamed:@"addBankCard.png"];
        self.addImageView.backgroundColor = [UIColor colorWithString:@"#DDDDDD" colorAlpha:1];
        self.addImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *selectTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageAction:)];
        [self.addImageView addGestureRecognizer:selectTap];
        [_pingzhengView addSubview:self.addImageView];
        
        
    }
    return _pingzhengView;
}



-(UIView *)panjueView
{
    if (!_panjueView) {
        _panjueView = [[UIView alloc] initWithFrame:RECT(0, CGRectGetMaxY(self.timeLabel.frame) + 10, SCREENWIDTH, 120)];
        _panjueView.backgroundColor = RGBCOLOR(242, 242, 242);
        
        UILabel *panjueLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, 10, 200, 15)];
        panjueLabel.textColor = KColorGray333;
        panjueLabel.text = @"判决书类型";
        panjueLabel.textAlignment = NSTextAlignmentLeft;
        panjueLabel.font = SystemFont(15.0f);
        [_panjueView addSubview:panjueLabel];

        
        NSArray *titleArray = @[@"判决书",@"调解书",@"仲裁书",@"其他"];
        
        NSMutableArray *itemArray = [NSMutableArray array];
        for (int i = 0; i < titleArray.count; i ++) {
            YingShowHorSelectModel *model = [[YingShowHorSelectModel alloc] init];
            if (i == 0) {
                model.isSelected = YES;
            }
            model.titleStr = titleArray[i];
            [itemArray addObject:model];
        }
        
        
        self.panjueTypeScrollView = [[YingShowHorSelectScrollView alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(panjueLabel.frame) + 5, SCREENWIDTH - 20, 15) items:itemArray];
        
        [_panjueView addSubview:self.panjueTypeScrollView];
        
        
        UILabel *selectImageLabel = [[UILabel alloc] initWithFrame:RECT(LeftPadding, CGRectGetMaxY(self.panjueTypeScrollView.frame) + 40, 200, 15)];
        
        selectImageLabel.font = SystemFont(15.0);
        selectImageLabel.textAlignment = NSTextAlignmentLeft;
        selectImageLabel.textColor = KColorGray333;
        selectImageLabel.text = @"选择判决书图片";
        [_panjueView addSubview:selectImageLabel];
        
        self.addPanjueImageView = [[UIImageView alloc] initWithFrame:RECT(SCREENWIDTH - 20 - 75, CGRectGetMaxY(self.panjueTypeScrollView.frame)  + 10, 75, 75)];
        self.addPanjueImageView.image = [UIImage imageNamed:@"addBankCard.png"];
        self.addPanjueImageView.backgroundColor = [UIColor colorWithString:@"#DDDDDD" colorAlpha:1];
        self.addPanjueImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *selectTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageAction:)];
        [self.addPanjueImageView addGestureRecognizer:selectTap];
        [_panjueView addSubview:self.addPanjueImageView];
        
    }
    return _panjueView;
}


#pragma -mark ----delegate ---

-(void)didSelectItemWithSelectObject:(NSString *)selectObject ScrollView:(YingShowHorSelectScrollView *)horScrollView
{
    if (horScrollView == self.statusScrollView) {
        if ([selectObject isEqualToString:@"执行中"]) {
            self.panjueView.hidden = NO;
            self.pingzhengView.hidden = YES;
            [self.contentScrollView bringSubviewToFront:self.panjueView];
        }
        else{
            self.pingzhengView.hidden = NO;
            self.panjueView.hidden = YES;
            [self.contentScrollView bringSubviewToFront:self.pingzhengView];
        }
    }
}

@end
