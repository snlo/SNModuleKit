//
//  SNUIKitTool.h
//  SNUIKit
//
//  Created by sunDong on 2018/5/7.
//  Copyright © 2018年 snloveydus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Masonry.h>

#define SNUIKIT_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SNUIKIT_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kIs_iPhoneX (SNUIKIT_SCREEN_HEIGHT / SNUIKIT_SCREEN_WIDTH > 2.1 ? YES : NO)

#define kStatusBarAndNavigationBarHeight (kIs_iPhoneX ? 88.f : 64.f)
#define kTabbarHeight (kIs_iPhoneX ? 83.f : 49.f)

/**
 image about
 */
#define SNUIKIT_IMAGE_NAMED(name) [UIImage imageNamed:name]
#define SNUIKIT_IMAGE_PNG(name) UIImageMakeWithFileAndSuffix(name, @"png")
#define SNUIKIT_IMAGE_JPG(name) UIImageMakeWithFileAndSuffix(name, @"jpg")
#define SNUIKIT_UIImageMakeWithFileAndSuffix(name, suffix) [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", [[NSBundle mainBundle] resourcePath], name, suffix]]

__attribute__((objc_subclassing_restricted))

@interface SNUIKitTool : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) UIColor * contentColor;

@property (nonatomic, strong) UIColor * blackColor;

@property (nonatomic, strong) UIColor * hintColor;

@property (nonatomic, strong) UIColor * mainColor;

@property (nonatomic, strong) UIColor * separatorColor;

+ (CGFloat)homeBarHeight;
+ (CGFloat)tabbarHeight;
+ (CGFloat)navigationBarHeight;
+ (CGFloat)statusBarHeight;
+ (CGFloat)naviBarAndStatusBarHeight;

+ (UIViewController *)topViewController;

+ (void)showAlertStyle:(UIAlertControllerStyle)style title:(NSString *)title msg:(NSString *)message chooseBlock:(void (^)(NSInteger actionIndx))block  actionsStatement:(NSString *)cancelString, ... NS_REQUIRES_NIL_TERMINATION;

@end
