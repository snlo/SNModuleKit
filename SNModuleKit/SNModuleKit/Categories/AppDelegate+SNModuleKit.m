//
//  AppDelegate+SNModuleKit.m
//  SNModuleKit
//
//  Created by snlo on 2018/5/8.
//  Copyright © 2018年 AiteCube. All rights reserved.
//

#import "AppDelegate+SNModuleKit.h"

#import <SNNetworking.h>
#import <SNPhotoCameraViewController.h>
#import <SNTool.h>
#import <Aspects.h>

@implementation AppDelegate (SNModuleKit)

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//
//        [self aspect_hookSelector:@selector(application:didFinishLaunchingWithOptions:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, UIApplication *application, NSDictionary *launchOptions) {
//
//            [SNNetworking new].contentColor = COLOR_CONTENT;
//            [SNNetworking new].blackColor = COLOR_BLACK;
//
//            [SNPhotoCameraViewController new].tintColor = COLOR_BLACK;
//            [SNPhotoCameraViewController new].contentColor = COLOR_CONTENT;
//            [SNPhotoCameraViewController new].blackColor = COLOR_BLACK;
//
//        } error:NULL];
//    }
//    return self;
//}

@end
