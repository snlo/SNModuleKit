//
//  SNSacnViewController.m
//  SNSacnViewController
//
//  Created by snlo on 2018/4/9.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNScanViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "SNScanTool.h"

#define SNSACN_ALPHA 0.3
#define SNSACN_RECT CGSizeMake(255, 255)
#define SNSACN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SNSACN_SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height


typedef void(^CanceledBlock)(void);
typedef void(^ScanedBlock)(NSString * scanValue);

@interface SNScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIView * line;

@property (nonatomic, assign) CGRect scanRect;
@property (nonatomic, strong) UIToolbar * backgroudView;

@property (nonatomic, strong) UIButton * buttonCancel;
@property (nonatomic, strong) UIBarButtonItem * itemCancel;

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;

@property (nonatomic, copy) CanceledBlock canceledBlock;
@property (nonatomic, copy) ScanedBlock scanedBlock;

/**
 播放声音
 */
- (void)playBeep;

/**
 抠图
 */
- (void)sn_scanAddMaskToView:(UIView *)view withRoundedRect:(CGRect)roundedRect cornerRadius:(CGFloat)cornerRadius;

@end

@implementation SNScanViewController

- (void)dealloc {
	self.view = nil;
	self.session = nil;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		self.scanRect = CGRectMake((SNSACN_SCREEN_WIDTH -SNSACN_RECT.width)/2, (SNSACN_SCREEN_HIGHT -SNSACN_RECT.height)/2, SNSACN_RECT.width, SNSACN_RECT.height);
	}
	return self;
}

+ (instancetype)scanViewController {
	return [[SNScanViewController alloc] init];
}

#pragma mark -- life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

	[self.session startRunning];
	[self.line.layer addAnimation:[self scaleAnimationformValue:0 toValue:CGRectGetHeight(self.scanRect)] forKey:nil];
}
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	[self.session stopRunning];
	[self.line.layer removeAllAnimations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self configureUserInterface];
    [self configureDataSource];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark -- <AVCaptureMetadataOutputObjectsDelegate>、、
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
	NSString *stringValue = @"";
	if ([metadataObjects count] > 0) {
		// 停止扫描
		AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
		stringValue = metadataObject.stringValue;

		if (self.scanedBlock) {
			[self playBeep];
			self.scanedBlock(stringValue);
		}
		[self.session stopRunning];
		
		[self.line.layer removeAllAnimations];
	}
}
#pragma mark -- CustomDelegate

#pragma mark -- event response
- (void)handleButtonCancel:(UIButton *)sender {
	if (self.canceledBlock) {
		self.canceledBlock();
	}
}
- (void)handleItemCancel:(UIBarButtonItem *)sender {
	if (self.canceledBlock) {
		self.canceledBlock();
	}
}
- (void)playBeep {
	SystemSoundID sound = kSystemSoundID_Vibrate;
	//使用系统铃声
	NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"new-mail",@"caf"];
	//使用自定义铃声
//	NSString *path = [[NSBundle mainBundle] pathForResource:@"QRCodeRead"ofType:@"wav"]; //需将音频资源copy到项目<br>
	if (path) {
		OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
		if (error != kAudioServicesNoError) {
			sound = 0;
		}
	}
	AudioServicesPlaySystemSound(1002);//播放声音
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//静音模式下震动
}
#pragma mark -- public methods

- (void)scanedBlock:(void(^)(NSString * scanedValue))scanedBlock canceledBlock:(void(^)(void))canceledBlock {
	self.canceledBlock = canceledBlock;
	self.scanedBlock = scanedBlock;
}

- (void)onTorch {
	AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	NSError *error = nil;
	if ([captureDevice hasTorch]) {
		BOOL locked = [captureDevice lockForConfiguration:&error];
		if (locked) {
			captureDevice.torchMode = AVCaptureTorchModeOn;
			[captureDevice unlockForConfiguration];
		}
	}
}
- (void)offTorch {
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if ([device hasTorch]) {
		[device lockForConfiguration:nil];
		[device setTorchMode: AVCaptureTorchModeOff];
		[device unlockForConfiguration];
	}
}

#pragma mark -- private methods
- (CABasicAnimation *)scaleAnimationformValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
	CABasicAnimation *animation;
	animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
	animation.duration = 2;
	animation.fromValue = [NSNumber numberWithFloat:fromValue];
	animation.toValue = [NSNumber numberWithFloat:toValue];
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	animation.autoreverses = YES;
	animation.repeatCount = MAXFLOAT;
	return animation;
}

- (void)configureUserInterface {
	self.title = @"扫描";

	[self.view.layer insertSublayer:self.preview atIndex:0];

    [self.view addSubview:self.backgroudView];
    
	[self sn_scanAddMaskToView:self.backgroudView withRoundedRect:self.scanRect cornerRadius:0];
    
	[self.view addSubview:self.line];
	
	[self.view addSubview:self.buttonCancel];
}
- (void)configureDataSource {
	
    [self.session startRunning];
}

#pragma mark -- getter setter

@synthesize scanLineColor = _scanLineColor;
- (void)setScanLineColor:(UIColor *)scanLineColor {
    _scanLineColor = scanLineColor;
    self.line.backgroundColor = _scanLineColor;
}
@synthesize themeColor = _themeColor;
- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    [self.buttonCancel setTitleColor:_themeColor forState:UIControlStateNormal];
    
}
@synthesize contentColor = _contentColor;
- (void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    
}

- (UIColor *)scanLineColor {
    if (!_scanLineColor) {
        _scanLineColor = COLOR_MAIN;
    } return _scanLineColor;
}
- (UIColor *)themeColor {
    if (!_themeColor) {
        _themeColor = [UIColor whiteColor];
    } return _themeColor;
}
- (UIColor *)contentColor {
    if (!_contentColor) {
        _contentColor = COLOR_CONTENT;
    } return _contentColor;
}

- (UIView *)line {
	if (!_line) {
		_line = [[UIView alloc]init];
        _line.backgroundColor = self.scanLineColor;
		_line.frame = CGRectMake(self.scanRect.origin.x, self.scanRect.origin.y, self.scanRect.size.width, 1);
	} return _line;
}

- (UIToolbar *)backgroudView {
	if (!_backgroudView) {
		_backgroudView = [[UIToolbar alloc] init];
		_backgroudView.barStyle = UIBarStyleBlack;
		_backgroudView.frame = CGRectMake(0, -1, SNSACN_SCREEN_WIDTH, SNSACN_SCREEN_HIGHT+1);
	} return _backgroudView;
}
- (void)setBackgroudStyle:(UIBarStyle)backgroudStyle {
    _backgroudStyle = backgroudStyle;
    self.backgroudView.barStyle = _backgroudStyle;
}

- (UIButton *)buttonCancel {
	if (!_buttonCancel) {
		_buttonCancel = [[UIButton alloc] initWithFrame:CGRectMake(20,24,50,40)];
		[_buttonCancel addTarget:self action:@selector(handleButtonCancel:) forControlEvents:UIControlEventTouchUpInside];
		[_buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
		[_buttonCancel setTitleColor:self.themeColor forState:UIControlStateNormal];
		
	} return _buttonCancel;
}
- (UIBarButtonItem *)itemCancel {
	if (!_itemCancel) {
		_itemCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(handleItemCancel:)];
	} return _itemCancel;
}

- (AVCaptureSession *)session {
	if (!_session) {
        
        AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc] init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:input]) {
            [_session addInput:input];
        }
        if ([_session canAddOutput:output]){
            [_session addOutput:output];
        }
        
        //相机权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
            authStatus == AVAuthorizationStatusDenied) { //用户已经明确否认了这一照片数据的应用程序访问
            // 无权限 引导去开启
            [SNTool showAlertStyle:UIAlertControllerStyleAlert title:@"提示" msg:@"没有相机访问权限，是否去设置中开启" chooseBlock:^(NSInteger actionIndx) {
                if (actionIndx == 1) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
                    }
                }
            } actionsStatement:@"取消",@"确认", nil];
        } else {
            NSMutableArray *types =
            [NSMutableArray arrayWithArray:@[AVMetadataObjectTypeUPCECode,
                                             AVMetadataObjectTypeCode39Code,
                                             AVMetadataObjectTypeCode39Mod43Code,
                                             AVMetadataObjectTypeEAN13Code,
                                             AVMetadataObjectTypeEAN8Code,
                                             AVMetadataObjectTypeCode93Code,
                                             AVMetadataObjectTypeCode128Code,
                                             AVMetadataObjectTypePDF417Code,
                                             AVMetadataObjectTypeQRCode,
                                             AVMetadataObjectTypeAztecCode]];
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                [types addObject:AVMetadataObjectTypeInterleaved2of5Code];
                [types addObject:AVMetadataObjectTypeITF14Code];
                [types addObject:AVMetadataObjectTypeDataMatrixCode];
            }
            
            output.metadataObjectTypes = types;
        }

	} return _session;
}
- (AVCaptureVideoPreviewLayer *)preview {
	if (!_preview) {
		_preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
		_preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
		_preview.frame = self.view.layer.bounds;
	} return _preview;
}


- (void)sn_scanAddMaskToView:(UIView *)view withRoundedRect:(CGRect)roundedRect cornerRadius:(CGFloat)cornerRadius {
	UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
	
	[path appendPath:[[UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:cornerRadius] bezierPathByReversingPath]];
	
	CAShapeLayer *shapeLayer = [CAShapeLayer layer];
	
	shapeLayer.path = path.CGPath;
	
	[view.layer setMask:shapeLayer];
}

@end
