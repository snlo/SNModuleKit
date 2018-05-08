//
//  SNUIKitTool.m
//  SNUIKit
//
//  Created by sunDong on 2018/5/7.
//  Copyright © 2018年 snloveydus. All rights reserved.
//

#import "SNUIKitTool.h"

#import <objc/runtime.h>

#import "UIViewController+SNViewController.h"

#import "SNUIKitTool.h"

@implementation SNUIKitTool

static id instanse;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
	static dispatch_once_t onesToken;
	dispatch_once(&onesToken, ^{
		instanse = [super allocWithZone:zone];
	});
	return instanse;
}
+ (instancetype)sharedManager {
	static dispatch_once_t onestoken;
	dispatch_once(&onestoken, ^{
		instanse = [[self alloc] init];
	});
	return instanse;
}
- (id)copyWithZone:(NSZone *)zone {
	return instanse;
};


+ (UIViewController *)topViewController {
	UIViewController * resultVC = [self fetchTopViewControllerWith:[[UIApplication sharedApplication].keyWindow rootViewController]];
	while (resultVC.presentedViewController) {
		resultVC = [self fetchTopViewControllerWith:resultVC.presentedViewController];
	}
	while (resultVC.childViewControllers.count > 0) {
		resultVC = [self fetchTopViewControllerWithChids:resultVC.childViewControllers.lastObject];
	}
	return resultVC;
}
+ (UIViewController *)fetchTopViewControllerWithChids:(UIViewController *)VC  {
	if (VC.childViewControllers.lastObject) {
		return VC.childViewControllers.lastObject;
	} else {
		return VC;
	}
}
+ (UIViewController *)fetchTopViewControllerWith:(UIViewController *)VC {
	if ([VC isKindOfClass:[UINavigationController class]]) {
		return [self fetchTopViewControllerWith:[(UINavigationController *)VC topViewController]];
	} else if ([VC isKindOfClass:[UITabBarController class]]) {
		return [self fetchTopViewControllerWith:[(UITabBarController *)VC selectedViewController]];
	} else {
		return VC;
	}
}

+ (void)showAlertStyle:(UIAlertControllerStyle)style title:(NSString *)title msg:(NSString *)message chooseBlock:(void (^)(NSInteger actionIndx))block  actionsStatement:(NSString *)cancelString, ... NS_REQUIRES_NIL_TERMINATION {
	NSMutableArray * argsArray = [[NSMutableArray alloc] initWithCapacity:2];
	
	if (cancelString) [argsArray addObject:cancelString];
	
	id arg;
	va_list argList;
	if(cancelString) {
		
		va_start(argList,cancelString);
		
		while ((arg = va_arg(argList,id))) {
			[argsArray addObject:arg];
		}
		va_end(argList);
	}
	
	//    遍历私有属性
	BOOL isSettingColor = NO;
	unsigned int count;
	Ivar *ivars =  class_copyIvarList([UIAlertAction class], &count);
	NSLog(@"________________________________________________");
	for (int i = 0; i < count; i++) {
		Ivar ivar = ivars[i];
		const char * cName =  ivar_getName(ivar);
		NSString *ocName = [NSString stringWithUTF8String:cName];
		if ([ocName isEqualToString:@"_titleTextColor"]) {
			isSettingColor = YES;
			break;
		}
		//        NSLog(@"%@",ocName);
	}
	NSLog(@"________________________________________________");
	//    free(ivars);
	
	UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
	for (int i = 0; i < [argsArray count]; i++) {
		
		UIAlertActionStyle styleAction =  (0 == i)? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
		// Create the actions.
		UIAlertAction * action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:styleAction handler:^(UIAlertAction *action) {
			
			if (block) block(i);
		}];
		if (argsArray.count > 1) {
			if (isSettingColor) {
				if (styleAction == UIAlertActionStyleCancel) {
					[action setValue:[SNUIKitTool sharedManager].contentColor forKey:@"titleTextColor"];
				} else {
					[action setValue:[SNUIKitTool sharedManager].blackColor forKey:@"titleTextColor"];
				}
			}
		}
		[alertController addAction:action];
	}
	
	[[self topViewController] presentViewController:alertController animated:YES completion:nil];
	
	alertController.view.tintColor = [SNUIKitTool sharedManager].blackColor;
	
	//2秒钟之后自动dismiss掉
	if (!cancelString) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[alertController dismissViewControllerAnimated:YES completion:nil];
		});
	}
}

#pragma mark -- height

+ (CGFloat)homeBarHeight {
	if ([SNUIKitTool topViewController].tabBarController.tabBar) {
		return [SNUIKitTool topViewController].tabBarController.tabBar.frame.size.height - 49.f;
	} else {
		return kTabbarHeight - 49.f;
	}
}

+ (CGFloat)tabbarHeight {
	if ([SNUIKitTool topViewController].tabBarController.tabBar) {
		return [SNUIKitTool topViewController].tabBarController.tabBar.frame.size.height;
	} else {
		return kTabbarHeight;
	}
	
}

+ (CGFloat)navigationBarHeight {
	if ([SNUIKitTool topViewController].sn_navigationController.navigationBar) {
		return [SNUIKitTool topViewController].sn_navigationController.navigationBar.frame.size.height;
	} else {
		return kStatusBarAndNavigationBarHeight - [UIApplication sharedApplication].statusBarFrame.size.height;
	}
}

+ (CGFloat)statusBarHeight {
	return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)naviBarAndStatusBarHeight {
	if ([SNUIKitTool topViewController].sn_navigationController.navigationBar) {
		CGFloat height = [SNUIKitTool topViewController].sn_navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
		return height;
	} else {
		return kStatusBarAndNavigationBarHeight;
	}
}

#pragma mark -- getter // setter

- (UIColor *)blackColor {
	if (!_blackColor) {
		_blackColor = [UIColor blackColor];
	} return _blackColor;
}
- (UIColor *)contentColor {
	if (!_contentColor) {
		_contentColor = [UIColor grayColor];
	} return _contentColor;
}
- (UIColor *)hintColor {
    if (!_hintColor) {
        _hintColor = [UIColor redColor];
    } return _hintColor;
}
- (UIColor *)mainColor {
    if (!_mainColor) {
        _mainColor = [UIColor blackColor];
    } return _mainColor;
}
- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor grayColor];
    } return _separatorColor;
}

@end
