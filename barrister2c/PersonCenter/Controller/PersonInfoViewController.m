//
//  PersonInfoViewController.m
//  barrister
//
//  Created by 徐书传 on 16/4/19.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "PersonCenterModel.h"
#import "PersonInfoCustomCell.h"
#import "CityChooseViewController.h"
#import "AJPhotoPickerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ModifyInfoViewController.h"
#import "XuNetWorking.h"
#import "MeNetProxy.h"
#import "IMActionSheet.h"
#import "BaseDataSingleton.h"
#import "JPUSHService.h"

@interface PersonInfoViewController ()<AJPhotoPickerProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate,IMActionSheetDelegate>

@property (nonatomic,strong) UIImage *headImage;

@property (nonatomic,strong) MeNetProxy *proxy;
@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self configView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:NO];
}

#pragma -mark ----UI------

-(void)configView
{
 
    self.title = @"个人信息";
 
    [self initNavigationRightTextButton:@"提交" action:@selector(commitActioin)];
}

#pragma -mark --Action-----

-(void)commitActioin
{
    
//      参数:userId，verifyCode,nickname、gendar、phone（重新验证 TBD）、email、area（省+市）

    if (self.items.count < 5) {
        [XuUItlity showFailedHint:@"信息错误" completionBlock:nil];
        return;
    }
    
    
    NSMutableDictionary *aParams = [NSMutableDictionary dictionary];
    [aParams setObject:[BaseDataSingleton shareInstance].userModel.userId forKey:@"userId"];
    [aParams setObject:[BaseDataSingleton shareInstance].userModel.verifyCode forKey:@"verifyCode"];
    
    PersonCenterModel *nameModel = [self.items safeObjectAtIndex:1];
    if (IS_NOT_EMPTY(nameModel.subtitleStr)) {
        if (![nameModel.subtitleStr isEqualToString:@"未填写"]) {
            [aParams setObject:nameModel.subtitleStr forKey:@"nickname"];
        }
    }
    
    PersonCenterModel *phoneModel = [self.items safeObjectAtIndex:2];
    if (IS_NOT_EMPTY(phoneModel.subtitleStr)) {
        if (![phoneModel.subtitleStr isEqualToString:@"未填写"]) {
            [aParams setObject:phoneModel.subtitleStr forKey:@"phone"];
        }
    }
    
    PersonCenterModel *genderModel = [self.items safeObjectAtIndex:3];
    if (IS_NOT_EMPTY(genderModel.subtitleStr)) {
        if (![genderModel.subtitleStr isEqualToString:@"未填写"]) {
            [aParams setObject:genderModel.subtitleStr forKey:@"gendar"];
        }
    }
    
    PersonCenterModel *areaModel = [self.items safeObjectAtIndex:4];
    if (IS_NOT_EMPTY(areaModel.subtitleStr)) {
        if (![areaModel.subtitleStr isEqualToString:@"未填写"]) {
            [aParams setObject:areaModel.subtitleStr forKey:@"area"];
        }
    }
    
   NSString *registrationId =  [JPUSHService registrationID];
    if (registrationId) {
        [aParams setObject:registrationId forKey:@"pushId"];
    }
    
    //缺少极光推送的push id
    
    
    [XuUItlity showLoading:@"正在提交"];
    
    __weak typeof(*&self)weakSelf = self;
    [self.proxy updateUserInfoWithParams:aParams block:^(id returnData, BOOL success) {
        [XuUItlity hideLoading];
        if (success) {
            NSDictionary *dict = (NSDictionary *)returnData;
            if (dict && [dict respondsToSelector:@selector(objectForKey:)]) {
                NSDictionary *userDict = [dict objectForKey:@"user"];
                BarristerUserModel *userModel = [[BarristerUserModel alloc] initWithDictionary:userDict];
                [BaseDataSingleton shareInstance].userModel = userModel;
                [weakSelf configData];

                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }
            
        }
        else
        {
            
        }
    }];


}


#pragma -mark ---------Data--------

-(void)configData
{
    
    NSArray *titleArray = @[@"头像",@"昵称",@"手机",@"性别",@"地区"];
    for (int i = 0; i < titleArray.count; i ++) {
        PersonCenterModel *model = [[PersonCenterModel alloc] init];
        model.titleStr = [titleArray safeObjectAtIndex:i];

        switch (i) {
            case 0:
            {
                model.cellType = PersonCenterModelTypeInfoTX;
                model.userIcon = [BaseDataSingleton shareInstance].userModel.userIcon;
                model.isShowArrow = YES;

            }
                break;
            case 1:
            {
                model.cellType = PersonCenterModelTypeInfoNickName;
                model.subtitleStr = [BaseDataSingleton shareInstance].userModel.nickname?[BaseDataSingleton shareInstance].userModel.nickname:@"未填写";
                model.isShowArrow = YES;

            }
                break;
            case 2:
            {
                model.cellType = PersonCenterModelTypeInfoPhone;
                model.subtitleStr = [BaseDataSingleton shareInstance].userModel.phone?[BaseDataSingleton shareInstance].userModel.phone:@"";
                model.isShowArrow = NO;
            }
                break;
            case 3:
            {
                model.cellType = PersonCenterModelTypeInfoGender;
              model.subtitleStr = @"男";
                model.isShowArrow = YES;
                break;
            }
            case 4:
            {
                model.cellType = PersonCenterModelTypeInfoArea;
                model.subtitleStr = [BaseDataSingleton shareInstance].userModel.area?[BaseDataSingleton shareInstance].userModel.area:@"未填写";
                model.isShowArrow = YES;
            }
                
                break;
            default:
                break;
        }
        
        [self.items addObject:model];
    }
}

#pragma -mark ----------UITableViewDataSource Methods---------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCenterModel *model = (PersonCenterModel *)[self.items safeObjectAtIndex:indexPath.row];
    
    return [PersonInfoCustomCell getCellHeightWithModel:model];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonInfoCustomCell *cell = [[PersonInfoCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    PersonCenterModel *modelTemp = (PersonCenterModel *)[self.items safeObjectAtIndex:indexPath.row];
    cell.model = modelTemp;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.items.count <= indexPath.row) {
        return;
    }
    
    PersonCenterModel *modelTemp = [self.items safeObjectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            AJPhotoPickerViewController *picker = [[AJPhotoPickerViewController alloc] init];
            picker.assetsFilter = [ALAssetsFilter allPhotos];
            picker.showEmptyGroups = YES;
            picker.delegate = self;
            picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                return YES;
            }];
            
            [self presentViewController:picker animated:YES completion:nil];

        }
            break;
        case 1:
        {
            ModifyInfoViewController *modifyVC = [[ModifyInfoViewController alloc] initWithModel:modelTemp];
            modifyVC.modifyBlock = ^(PersonCenterModel *model)
            {
                [self.items replaceObjectAtIndex:indexPath.row withObject:model];
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:modifyVC animated:YES];
        }
            break;
        case 2:
        {
            return;
        }
            break;
        case 3:
        {
            IMActionSheet *genderSheet = [[IMActionSheet alloc] initWithTitle:nil delegate:self/*.delegate*/ cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            [genderSheet showInView:self.view];
            
        }
            break;
        case 4:
        {
            CityChooseViewController *cityVC = [[CityChooseViewController alloc] init];
            cityVC.cityInfo = ^(NSString *province,NSString *area)
            {
                modelTemp.subtitleStr = [NSString stringWithFormat:@"%@%@",province,area];
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:cityVC animated:YES];
        }
            break;
  
        case 8:
            break;

        default:
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    PersonCenterModel *model = [self.items safeObjectAtIndex:3];
    switch (buttonIndex)
    {
        case 0:
        {
            //男
            model.subtitleStr = @"男";
        }
            break;
        case 1:
        {
            model.subtitleStr = @"女";
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}



#pragma -mark ---Photo Picker----

- (void)photoPickerDidCancel:(AJPhotoPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoPicker:(AJPhotoPickerViewController *)picker didSelectAssets:(NSArray *)assets {
    if (assets.count == 1) {
        ALAsset *asset = assets[0];
        self.headImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
        [self uploadHeadImage];
    }
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    
}


- (void)photoPickerTapCameraAction:(AJPhotoPickerViewController *)picker {
    [self checkCameraAvailability:^(BOOL auth) {
        if (!auth) {
            NSLog(@"没有访问相机权限");
            return;
        }
        
        [picker dismissViewControllerAnimated:NO completion:nil];
        UIImagePickerController *cameraUI = [UIImagePickerController new];
        cameraUI.allowsEditing = NO;
        cameraUI.delegate = self;
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraUI.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
        
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
        self.headImage = image;
        [self uploadHeadImage];

    }
    [picker dismissViewControllerAnimated:YES completion:nil];

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


#pragma -mark ----UploadHeaderImage------

-(void)uploadHeadImage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[BaseDataSingleton shareInstance].userModel.userId forKey:@"userId"];
    [params setObject:[BaseDataSingleton shareInstance].userModel.verifyCode forKey:@"verifyCode"];
    [XuUItlity showLoading:@"正在上传.."];
    
    [self.proxy UploadHeadImageUrlWithImage:self.headImage params:params fileName:@"userIcon" Block:^(id returnData, BOOL success) {
        [XuUItlity hideLoading];
        if (success) {
            [XuUItlity showSucceedHint:@"上传成功" completionBlock:nil];
            [BaseDataSingleton shareInstance].userModel.headImage = self.headImage;
            [self.tableView reloadData];

        }
        else
        {
            [XuUItlity showFailedHint:@"上传失败" completionBlock:nil];
        }
    }];
}



#pragma -mark ----getter----

-(MeNetProxy *)proxy
{
    if (!_proxy) {
        _proxy = [[MeNetProxy alloc] init];
    }
    return _proxy;
}

@end
