//
//  SNNetworkTool.h
//  SNNetworking
//
//  Created by snlo on 2018/5/8.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "NSString+SNNetworkingHASH.h"
#import "NSString+SNNetworkingJSON.h"
#import "SNNetworkTransformer.h"
#import "SNFileNetworkManager.h"
#import "SNNetworkCachePool.h"

@interface SNNetworkTool : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) UIColor * contentColor;

@property (nonatomic, strong) UIColor * blackColor;

+ (UIViewController *)topViewController;

+ (void)showAlertStyle:(UIAlertControllerStyle)style title:(NSString *)title msg:(NSString *)message chooseBlock:(void (^)(NSInteger actionIndx))block  actionsStatement:(NSString *)cancelString, ... NS_REQUIRES_NIL_TERMINATION;

+ (NSString *)currentTime;

+ (void)showLoading:(NSString *)loadingMsg;

+ (void)dismisLoding;

@end
