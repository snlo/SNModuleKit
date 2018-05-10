//
//  UIColor+SNModuleKit.m
//  SNModuleKit
//
//  Created by sunDong on 2018/5/9.
//  Copyright © 2018年 AiteCube. All rights reserved.
//

#import "UIColor+SNModuleKit.h"

#import <SNBadgeView.h>
#import <SNNetworking.h>
#import <SNPhotoCameraViewController.h>
#import <SNUIKit.h>
#import <SNScanViewController.h>

#import <SNTool.h>

@implementation UIColor (SNModuleKit)

+ (void)configureDefaultColor {
	[SNBadgeView new].hinthColor = COLOR_BLACK;
    [SNBadgeView new].numberColor = COLOR_TITLE;
	
	[SNNetworking new].contentColor = COLOR_CONTENT;
	[SNNetworking new].blackColor = COLOR_BLACK;
	
	[SNPhotoCameraViewController new].tintColor = COLOR_BLACK;
	[SNPhotoCameraViewController new].contentColor = COLOR_CONTENT;
	[SNPhotoCameraViewController new].blackColor = COLOR_BLACK;
    
    [SNUIKit new].contentColor = COLOR_CONTENT;
    [SNUIKit new].blackColor = COLOR_BLACK;
    [SNUIKit new].hintColor = COLOR_BLACK;
    [SNUIKit new].mainColor = COLOR_BLACK;
    [SNUIKit new].separatorColor = COLOR_SEPARATOR;
    
    [SNScanViewController new].contentColor = COLOR_CONTENT;
    [SNScanViewController new].themeColor = COLOR_BLACK;
    [SNScanViewController new].scanLineColor = COLOR_TITLE;
    [SNScanViewController new].blackColor = COLOR_BLACK;
    
    NSLog(@"%@",NSLocalizedStringFromTable(@"测试", @"SNModuleKitStrings", nil));
}

@end
