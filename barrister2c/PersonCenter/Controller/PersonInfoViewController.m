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
@interface PersonInfoViewController ()<AJPhotoPickerProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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
}

#pragma -mark ---------Data--------

-(void)configData
{
    
    NSArray *titleArray = @[@"头像",@"昵称",@"手机",@"性别",@"地区"];
    for (int i = 0; i < titleArray.count; i ++) {
        PersonCenterModel *model = [[PersonCenterModel alloc] init];
        model.titleStr = [titleArray objectAtIndex:i];
        if (i == 0) {
            model.cellType = PersonCenterModelTypeInfoTX;
        }
        else
        {
            model.cellType = PersonCenterModelTypeInfoCommon;
            model.subtitleStr = @"未填写";
        }
        
        model.isShowArrow = (i == 1)?NO:YES;

        [self.items addObject:model];
    }
}

#pragma -mark ----------UITableViewDataSource Methods---------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCenterModel *model = (PersonCenterModel *)[self.items objectAtIndex:indexPath.row];
    
    return [PersonInfoCustomCell getCellHeightWithModel:model];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonInfoCustomCell *cell = [[PersonInfoCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    PersonCenterModel *modelTemp = (PersonCenterModel *)[self.items objectAtIndex:indexPath.row];
    cell.model = modelTemp;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.items.count <= indexPath.row) {
        return;
    }
    
    PersonCenterModel *modelTemp = [self.items objectAtIndex:indexPath.row];
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
        case 2:
        case 3:
        case 5:
        case 6:
        case 9:
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
        case 4:
        {
            CityChooseViewController *cityVC = [[CityChooseViewController alloc] init];
            [self.navigationController pushViewController:cityVC animated:YES];
        }
            break;
  
        case 8:
            break;

        default:
            break;
    }
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
    [self.proxy UploadHeadImageUrlWithImage:self.headImage params:nil fileName:@"userIcon" Block:^(id returnData, BOOL success) {
        if (success) {
            [XuUItlity showSucceedHint:@"上传成功" completionBlock:nil];
            PersonCenterModel *model = (PersonCenterModel *)[self.items objectAtIndex:0];
            model.headImage = self.headImage;
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
