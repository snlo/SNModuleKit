//
//  SNSacnViewController.m
//  SNSacnViewController
//
//  Created by snlo on 2018/4/9.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNScanViewController.h"

#import "SNScanTool.h"

#import "ViewModelSNScan.h"

typedef void(^CanceledBlock)(void);
typedef void(^ScanedBlock)(NSString * scanValue);

@interface SNScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) ViewModelSNScan * viewmodel;

@property (nonatomic, copy) CanceledBlock canceledBlock;
@property (nonatomic, copy) ScanedBlock scanedBlock;

@end

@implementation SNScanViewController

- (void)dealloc {
	self.viewScan = nil;
    self.viewmodel.session = nil;
}

+ (instancetype)scanViewController {
	return [[SNScanViewController alloc] init];
}

#pragma mark -- life cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

	[self.viewmodel.session startRunning];
    [self.viewScan startAnimation];
}
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	[self.viewmodel.session stopRunning];
    [self.viewScan stopAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self configureUserInterface];
    [self configureDataSource];
}
#pragma mark -- CustomDelegate

#pragma mark -- event response
- (void)handleButtonCancel:(UIButton *)sender {
	if (self.canceledBlock) {
		self.canceledBlock();
	}
}
- (void)handleButtonTouch:(UIButton *)sender {
    if (sender.selected) {
        [self.viewmodel offTorch];
        sender.selected = NO;
    } else {
        [self.viewmodel onTorch];
        sender.selected = YES;
    }
}
- (void)handleButtonAlbum:(UIButton *)sender {
    [self.viewmodel selectPictureFromAlbunPhotos:^(UIImagePickerController *imagePickerController) {
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }];
}

#pragma mark -- public methods

- (void)scanedBlock:(void(^)(NSString * scanedValue))scanedBlock canceledBlock:(void(^)(void))canceledBlock {
	self.canceledBlock = canceledBlock;
	self.scanedBlock = scanedBlock;
}


#pragma mark -- private methods
- (void)configureUserInterface {
    [self.view.layer insertSublayer:self.viewmodel.preview atIndex:0];
    [self.view addSubview:self.viewScan];
}
- (void)configureDataSource {
	
    [self.viewmodel.session startRunning];
}

#pragma mark -- getter setter

#pragma mark -- getter / setter
- (ViewModelSNScan *)viewmodel {
    if (!_viewmodel) {
        _viewmodel = [[ViewModelSNScan alloc] init];
        _viewmodel.scanedBlock = self.scanedBlock;
        [_viewmodel selectedBlock:^(UIImage *image) {
            [self.viewmodel.preview removeFromSuperlayer];
            [self.viewScan removeFromSuperview];
            self.viewmodel.preview = nil;
            self.viewScan = nil;
            
            __block UIImageView * imageView = [[UIImageView alloc] init];
            imageView.frame = self.view.bounds;
            [self.view addSubview:imageView];
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            if (![self.viewmodel scanImageQRCode:image]) {
                [imageView removeFromSuperview];
                imageView = nil;
                [self configureUserInterface];
                [self.viewmodel.session startRunning];
                [self.viewScan startAnimation];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SNTool showAlertStyle:UIAlertControllerStyleAlert title:@"" msg:@"识别失败" chooseBlock:^(NSInteger actionIndx) {
                        
                    } actionsStatement:@"确定", nil];
                });
            }
        } cancelBlock:^{
            
        }];
    } return _viewmodel;
}
- (SNScanView *)viewScan {
    if (!_viewScan) {
        _viewScan = [SNScanView scanViewWithScanSize:CGSizeMake(SCREEN_WIDTH-108, SCREEN_WIDTH-108)];
        [_viewScan.buttonCancel addTarget:self action:@selector(handleButtonCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_viewScan.buttonTouch addTarget:self action:@selector(handleButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        [_viewScan.buttonAlbum addTarget:self action:@selector(handleButtonAlbum:) forControlEvents:UIControlEventTouchUpInside];
    } return _viewScan;
}


@end
