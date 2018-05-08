//
//  SNMediatorTool.h
//  SNMediator
//
//  Created by sunDong on 2018/5/7.
//  Copyright © 2018年 snloveydus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

__attribute__((objc_subclassing_restricted))

@interface SNMediatorTool : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) UIColor * contentColor;

@property (nonatomic, strong) UIColor * blackColor;

+ (UIViewController *)topViewController;

+ (void)showAlertStyle:(UIAlertControllerStyle)style title:(NSString *)title msg:(NSString *)message chooseBlock:(void (^)(NSInteger actionIndx))block  actionsStatement:(NSString *)cancelString, ... NS_REQUIRES_NIL_TERMINATION;

@end
