//
//  SNPopupTool.m
//  SNPopupViewController
//
//  Created by sunDong on 2018/5/6.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNPopupTool.h"

#import <objc/runtime.h>

@implementation SNPopupTool

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

+ (UIViewController *)getNextViewController
{
	UIViewController *result = nil;
	UIWindow * window = [[UIApplication sharedApplication] keyWindow];
	
	if (window.windowLevel != UIWindowLevelNormal) {
		NSArray *windows = [[UIApplication sharedApplication] windows];
		
		for(UIWindow * tmpWin in windows) {
			
			if (tmpWin.windowLevel == UIWindowLevelNormal) {
				window = tmpWin;
				break;
			}
		}
	}
	
	UIView * frontView = [[UIView alloc]init];
	
	if (window.subviews.count < 1) {
		frontView = window.rootViewController.view;
	} else {
		frontView = [[window subviews] objectAtIndex:0];
	}
	
	id nextResponder = [frontView nextResponder];
	
	if ([nextResponder isKindOfClass:[UIViewController class]]) {
		result = nextResponder;
	} else {
		result = window.rootViewController;
	}
	
	if (result.presentedViewController) {
		result = result.presentedViewController;
		
		for (int i = 0; i < 20; ++i) {
			if (result.presentedViewController) {
				result = result.presentedViewController;
			} else {
				break;
			}
		}
	}
	NSLog(@"getNextViewController -- %@",NSStringFromClass([result class]));
	return result;
}

@end
