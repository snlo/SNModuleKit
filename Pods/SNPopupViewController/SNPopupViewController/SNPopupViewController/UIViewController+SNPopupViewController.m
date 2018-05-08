//
//  UIViewController+SNPopupViewController.m
//  SNPopupViewController
//
//  Created by sunDong on 2018/5/6.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UIViewController+SNPopupViewController.h"

#import <objc/runtime.h>

@interface UIViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UINavigationController * snPopup_navigationController;

@end

@implementation UIViewController (SNPopupViewController)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)viewWillAppear:(BOOL)animated {
	
	if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
		self.navigationController.interactivePopGestureRecognizer.delegate = self;
	}
	
	if (self.snPopup_navigationController.viewControllers.count < 2) {
		self.snPopup_isAbleEdgeGesture = NO;
	}
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	return self.snPopup_isAbleEdgeGesture;
}
#pragma clang diagnostic pop

#pragma mark -- snPopup_isAbleEdgeGesture
- (void)setSnPopup_isAbleEdgeGesture:(BOOL)snPopup_isAbleEdgeGesture {
	objc_setAssociatedObject(self, @selector(snPopup_isAbleEdgeGesture), @(snPopup_isAbleEdgeGesture), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)snPopup_isAbleEdgeGesture {
	id snPopup_isAbleEdgeGesture = objc_getAssociatedObject(self, _cmd);
	return snPopup_isAbleEdgeGesture ? [snPopup_isAbleEdgeGesture boolValue] : true;
}

#pragma mark -- snPopup_navigationController
- (void)setSnPopup_navigationController:(UINavigationController *)snPopup_navigationController {
	objc_setAssociatedObject(self, @selector(snPopup_navigationController), snPopup_navigationController, OBJC_ASSOCIATION_ASSIGN);
}
- (UINavigationController *)snPopup_navigationController {
	if (self.navigationController) {
		return self.navigationController;
	} else if (self.tabBarController) {
		return self.tabBarController.navigationController;
	} else if ([self isKindOfClass:[UINavigationController class]]) {
		return (UINavigationController *)self;
	} else {
		return objc_getAssociatedObject(self, _cmd);
	}
}

@end
