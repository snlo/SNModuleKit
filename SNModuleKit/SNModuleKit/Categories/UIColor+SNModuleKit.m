//
//  UIColor+SNModuleKit.m
//  SNModuleKit
//
//  Created by sunDong on 2018/5/9.
//  Copyright © 2018年 AiteCube. All rights reserved.
//

#import "UIColor+SNModuleKit.h"

#import <SNBadgeViewTool.h>
#import <SNNetworking.h>
#import <SNPhotoCameraViewController.h>
#import <SNTool.h>

@implementation UIColor (SNModuleKit)

+ (void)configureDefaultColor {
	[SNBadgeViewTool sharedManager].hinthColor = [UIColor blueColor];
	
	[SNNetworking new].contentColor = COLOR_CONTENT;
	[SNNetworking new].blackColor = COLOR_BLACK;
	
	[SNPhotoCameraViewController new].tintColor = COLOR_BLACK;
	[SNPhotoCameraViewController new].contentColor = COLOR_CONTENT;
	[SNPhotoCameraViewController new].blackColor = COLOR_BLACK;
}

@end
