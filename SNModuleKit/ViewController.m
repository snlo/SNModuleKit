//
//  ViewController.m
//  SNMediatorKit
//
//  Created by snlo on 2017/11/9.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "ViewController.h"

//#import "SNModuleKit.h"
//
//#import "SNModuleConfig.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    pod trunk push SNModuleKit.podspec --verbose --allow-warnings --use-libraries
    
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
	
    
//    [button setTitle:[NSBundle sn_localizedStringForKey:@"测试"] forState:UIControlStateNormal];
//    button.frame = CGRectMake(0, 100, SCREEN_WIDTH, 90);
//    [self.view addSubview:button];
//    [button.sn_badgeView setBadgeValue:2];
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [SNTool showAlertStyle:UIAlertControllerStyleAlert title:@"提示" msg:@"点我干嘛" chooseBlock:^(NSInteger actionIndx) {
//            
//        } actionsStatement:@"取消",@"确认", nil];
//    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController * vc =
        [SNMediator sn_Module:@"Public" url:nil action:@"nativeFetchPublicViewController" params:nil cacheTarget:NO];
        [self presentViewController:vc animated:YES completion:nil];
        
    });
    
    //swift
//    TestViewController * vcTest = [[TestViewController alloc] init];
    
    
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


//+ (void)configureDefaultColor {
//	[SNBadgeView new].hinthColor = COLOR_BLACK;
//	[SNBadgeView new].numberColor = COLOR_TITLE;
//
//	[SNNetworking new].contentColor = COLOR_CONTENT;
//	[SNNetworking new].blackColor = COLOR_BLACK;
//
//	[SNPhotoCameraViewController new].tintColor = COLOR_BLACK;
//	[SNPhotoCameraViewController new].contentColor = COLOR_CONTENT;
//	[SNPhotoCameraViewController new].blackColor = COLOR_BLACK;
//
//	[SNUIKit new].contentColor = COLOR_CONTENT;
//	[SNUIKit new].blackColor = COLOR_BLACK;
//	[SNUIKit new].hintColor = COLOR_BLACK;
//	[SNUIKit new].mainColor = COLOR_BLACK;
//	[SNUIKit new].separatorColor = COLOR_SEPARATOR;
//
//	[SNScanViewController new].contentColor = COLOR_CONTENT;
//	[SNScanViewController new].themeColor = COLOR_BLACK;
//	[SNScanViewController new].scanLineColor = COLOR_TITLE;
//	[SNScanViewController new].blackColor = COLOR_BLACK;
//
//	NSLog(@"%@",NSLocalizedStringFromTable(@"测试", @"SNModuleKitStrings", nil));
//}

@end
