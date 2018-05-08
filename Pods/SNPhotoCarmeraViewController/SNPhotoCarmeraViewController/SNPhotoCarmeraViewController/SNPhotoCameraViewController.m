//
//  SNPhotoCameraViewController.m
//  NeighborMom
//
//  Created by sunDong on 16/4/11.
//  Copyright © 2016年 WAYOS. All rights reserved.
//

#import "SNPhotoCameraViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>

#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

#import "CropImageController.h"
#import "SNPhotoCarmeraTool.h"

typedef void(^SelectedImageBlock)(UIImage * valueImage);
typedef void(^SelectedCancelBlock)(void);

@interface SNPhotoCameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController * imagePickerController;

@property (nonatomic, strong) UIViewController * parentVC;
@property (nonatomic, strong) UIImage * selectedImage;
@property (nonatomic, assign) CGSize imageScaledSize;

@property (nonatomic, copy) SelectedImageBlock selectedImageBlock;
@property (nonatomic, copy) SelectedCancelBlock selectedCancelBlock;

@end

@implementation SNPhotoCameraViewController

#pragma mark -- life cycle
- (instancetype)initWithPresent:(UIViewController *)presentViewController estimatedSize:(CGSize)selectedImageSize {
    self = [super init];
    if (self) {
        self.parentVC = presentViewController;
        self.imageScaledSize = selectedImageSize;
        self.selectedImage = [[UIImage alloc]init];
    } return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark -- <UIImagePickerControllerDelegate,
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([info[UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
            [[SNPhotoCarmeraTool topViewController].navigationController popViewControllerAnimated:NO];
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = image.size.height * (width/image.size.width);
            UIImage * orImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(width, height)];
            CropImageController * VC = [CropImageController cropImageViewControllerWithImage:orImage ratio:0.5 seletecedBlock:^(UIImage *image) {
                self.selectedImage = image;
            } cancelBlock:^{
                
            }];
            VC.isOvalcropView = YES;
            [[SNPhotoCarmeraTool topViewController].navigationController pushViewController:VC animated:YES];
            
            return;
            
            if (self.imagePickerController.allowsEditing) {
                self.selectedImage = info[UIImagePickerControllerEditedImage];
            } else {
                self.selectedImage = info[UIImagePickerControllerOriginalImage];
            }
        }
    } else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = image.size.height * (width/image.size.width);
        UIImage * orImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(width, height)];
        CropImageController * VC = [CropImageController cropImageViewControllerWithImage:orImage ratio:0.5 seletecedBlock:^(UIImage *image) {
            self.selectedImage = image;
        } cancelBlock:^{
            
        }];
        VC.isOvalcropView = YES;
        [[SNPhotoCarmeraTool topViewController].navigationController pushViewController:VC animated:YES];
        
        
        
        return;
        
        
        if (self.imagePickerController.allowsEditing) {
            self.selectedImage = info[UIImagePickerControllerEditedImage];
        } else {
            self.selectedImage = info[UIImagePickerControllerOriginalImage];
        }
    }
    if (self.selectedImageBlock) {
        self.selectedImage = [self imageWithImageSimple:self.selectedImage scaledToSize:self.imageScaledSize];
        self.selectedImageBlock(self.selectedImage);
    }
    [self removeFromParentViewController];
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (self.selectedCancelBlock) self.selectedCancelBlock();
    
    [self removeFromParentViewController];
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- CropImageDelegate
- (void)cropImageDidFinishedWithImage:(UIImage *)image {
    if (self.selectedImageBlock) {
        self.selectedImageBlock(image);
    }
}

#pragma mark -- UINavigationControllerDelegate>

#pragma mark -- event response

#pragma mark -- private methods

#pragma public
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize )newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    [image drawInRect : CGRectMake ( 0 , 0 ,newSize.width ,newSize.height )];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext ();
    return newImage;
}

#pragma mark -- API

+ (instancetype)pictureViewControllerWithPresent:(UIViewController *)presentViewController estimatedSize:(CGSize)selectedImageSize {
    return [[SNPhotoCameraViewController alloc] initWithPresent:presentViewController estimatedSize:selectedImageSize];
}
- (void)selectPictureFromAlbunPhotos {
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    //相册权限
//    PHAuthorizationStatus * authors = [PHPhotoLibrary ];
    PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
//    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied){
        //无权限 引导去开启
        [SNPhotoCarmeraTool showAlertStyle:UIAlertControllerStyleAlert title:@"提示" msg:@"没有相册访问权限，是否去设置中开启" chooseBlock:^(NSInteger actionIndx) {
            if (actionIndx == 1) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:nil];
                }
            }
        } actionsStatement:@"取消",@"确认", nil];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePickerController.mediaTypes = @[mediaTypes[0]];
        
        [self.parentVC addChildViewController:self];
        [self.parentVC presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}
- (void)selectPictureFromCamera {
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    //相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus == AVAuthorizationStatusDenied) { //用户已经明确否认了这一照片数据的应用程序访问
        // 无权限 引导去开启
        [SNPhotoCarmeraTool showAlertStyle:UIAlertControllerStyleAlert title:@"提示" msg:@"没有相机访问权限，是否去设置中开启" chooseBlock:^(NSInteger actionIndx) {
            if (actionIndx == 1) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
                }
            }
        } actionsStatement:@"取消",@"确认", nil];
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.mediaTypes = @[mediaTypes[0]];

        self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;

        [self.parentVC addChildViewController:self];
        [self.parentVC presentViewController:self.imagePickerController animated:YES completion:nil];
        
    } else {
        [SNPhotoCarmeraTool showAlertStyle:UIAlertControllerStyleAlert title:nil msg:@"当前设备不支持拍照" chooseBlock:nil actionsStatement:@"确定", nil];
    }
}
- (void)selectedBlock:(void(^)(UIImage *image))selectedBlock cancelBlock:(void(^)(void))cancelBlock {
    if (selectedBlock) self.selectedImageBlock = selectedBlock;
    if (cancelBlock) self.selectedCancelBlock = cancelBlock;
}

#pragma mark -- setter / getter

- (void)setImageScaledSize:(CGSize)imageScaledSize {
    _imageScaledSize = imageScaledSize;
    if (_imageScaledSize.width > 0) {
        self.imagePickerController.allowsEditing = NO;
    } else {
        _imageScaledSize = CGSizeMake(100, 100);
        self.imagePickerController.allowsEditing = NO;
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.imagePickerController.navigationBar.tintColor = _tintColor;
    self.imagePickerController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:_tintColor};
}

- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc]init];
        _imagePickerController.delegate = self;
    } return _imagePickerController;
}

- (void)setContentColor:(UIColor *)contentColor {
	_contentColor = contentColor;
	[SNPhotoCarmeraTool sharedManager].contentColor = _contentColor;
}
- (void)setBlackColor:(UIColor *)blackColor {
	_blackColor = blackColor;
	[SNPhotoCarmeraTool sharedManager].blackColor = _blackColor;
}


@end
