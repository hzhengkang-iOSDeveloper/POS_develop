//
//  SettingViewController.m
//  POS_develop
//
//  Created by syn on 2018/9/15.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "UpdatePasswordViewController.h"
#import "UpdatePhoneViewController.h"
#import "SettingNameViewController.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *settingTableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self createTableView];
    [self createSignOutBtn];
    
}
- (void)createTableView {
    _settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FITiPhone6(214)) style:UITableViewStylePlain];
    _settingTableView.backgroundColor = WhiteColor;
    _settingTableView.delegate = self;
    _settingTableView.dataSource = self;
    _settingTableView.showsVerticalScrollIndicator = NO;
    _settingTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_settingTableView];
}

- (void)createSignOutBtn {
    UIButton *signOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signOutBtn.backgroundColor = WhiteColor;
    signOutBtn.frame = CGRectMake(0, FITiPhone6(232), ScreenWidth, FITiPhone6(40));
    [signOutBtn setTitle:@"退出当前账户" forState:UIControlStateNormal];
    signOutBtn.titleLabel.font = F13;
    [signOutBtn setTitleColor:C1E95F9 forState:UIControlStateNormal];
    [signOutBtn addTarget:self action:@selector(signOutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signOutBtn];
}

#pragma mark ---- 退出登录 ----
- (void)signOutClick {
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingTableViewCell *cell = [SettingTableViewCell cellWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.titleLabel.hidden = YES;
        cell.iconImageV.hidden = NO;
        cell.iconImageV.image = [UIImage imageNamed:@"头像2"];
//        [cell.iconImageV sd_setImageWithURL:[NSURL URLWithString:_loginManager.userInfo.UserImg] placeholderImage: [UIImage imageNamed:@"头像2"] options:SDWebImageRefreshCached];
        cell.detailLabel.text = @"修改头像";
        cell.detailLabel.textColor = C989898;
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"手机号";
        cell.detailLabel.text = [@"17612197453" stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else if (indexPath.row == 2) {
        cell.titleLabel.text = @"姓名";
        cell.detailLabel.text = @"小幸运";
    }else {
        cell.titleLabel.text = @"修改密码";
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
             [self changeUserHeaderImage];
        }
            break;
        case 1:{
            UpdatePhoneViewController *vc = [[UpdatePhoneViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            SettingNameViewController *vc = [[SettingNameViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            UpdatePasswordViewController *vc = [[UpdatePasswordViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return FITiPhone6(64);
    }else {
        return FITiPhone6(50);
    }
}

#pragma mark ----------------------------上传头像----------------------------
- (void)changeUserHeaderImage{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark - action sheet delegate method

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing = YES;
            imagePicker.delegate = self;
            imagePicker.showsCameraControls = YES;
            //            imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }
        else {
            showAlertWithMessgae(@"相机不可用");
        }
    }
    else if (buttonIndex == 1) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing = YES;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }
        else {
            showAlertWithMessgae(@"相机不可用");
        }
    }
}

#pragma mark - image picker delegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
        UIImage *resizeImage = [image TransformtoSize:CGSizeMake(160, 160)];
        NSLog(@"上传头像");
        [self UploadHeadImage:resizeImage];
    }];
}

-(void)UploadHeadImage:(UIImage*)headImage{
    
//    HPDProgressHudShowWithMessage(@"头像上传中..");
//    NSData *imageData = UIImageJPEGRepresentation(headImage,1.0f);
//    NSString *encodedImageStr = [imageData base64Encoding];
//    NSDictionary* params = @{@"Memo":encodedImageStr};
//    [[HPDConnect connect] webservicesAFNetPOSTMethod:KSoapMethodUploadHeadImage params:params cookie:[[LoginManager getInstance] userCookie] result:^(bool success, NSDictionary *result) {
//        HPDProgressHide;
//        //        showToast(result[@"doMsg"]);
//        if (success) {
//            if (result[@"doStatu"]) {
//                if (result[@"doObject"] == nil) {
//                    showToast(result[@"prompt"]);
//                    //                    return ;
//                }else{
//
//                    NSDictionary *dictInfo = [GlobalMethod dictionaryWithJsonString:result[@"doObject"]];
//                    NSString* headImage = [NSString stringWithFormat:@"%@",dictInfo[@"userimg"]];
//                    NSLog(@"imageUrl = %@",dictInfo[@"userimg"]);
//                    if (headImage.length>0) {
//                        _loginManager.userInfo.UserImg = headImage;
//                        [UserInformation saveUserinfoWithKey:User_HeadImage value:headImage];
//                        [_UserInformationTableView reloadData];
//                    }
//                }
//            }
//
//            NSLog(@"result = %@",result);
//        }else{
//
//        }
//    }];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        // do nothing
    }];
}
@end
