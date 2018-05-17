//
//  UIViewController+SNViewController.m
//  snlo
//
//  Created by snlo on 2017/9/27.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UIViewController+SNViewController.h"

#import <objc/runtime.h>

#import "UINavigationBar+SNNavigationBar.h"

#import "SNUIKitTool.h"

#import <Aspects.h>

@interface UIViewController () <UIGestureRecognizerDelegate>

/**
 是否隐藏导航栏背景，默认为NO
 */
@property (nonatomic, assign) BOOL sn_isNavigationBarHidden;

/**
 是否执行navigationBar进场的渐变动画
 */
@property (nonatomic, assign) BOOL sn_animationNavigationBarComeBack;

@end

@implementation UIViewController (SNViewController)

#pragma mark -- life cycle

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (void)viewWillAppear:(BOOL)animated {

    if (self.sn_animationNavigationBarComeBack) {
        if (self.sn_isNavigationBarHidden) {
            [UIView animateWithDuration:0.3 animations:^{
                [self.sn_navigationController.navigationBar sn_setBackgroundColor:[self.sn_navigationBarColor colorWithAlphaComponent:0]];
            } completion:^(BOOL finished) {
            }];
            self.sn_navigationController.navigationBar.shadowImage = [UIImage new];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                [self.sn_navigationController.navigationBar sn_setBackgroundColor:[self.sn_navigationBarColor colorWithAlphaComponent:1]];
            } completion:^(BOOL finished) {
            }];
            [self.sn_navigationController.navigationBar setShadowImage:nil];
        }
    } else {
        if (self.sn_isNavigationBarHidden) {
            [self.sn_navigationController.navigationBar sn_setBackgroundColor:[self.sn_navigationBarColor colorWithAlphaComponent:0]];
            self.sn_navigationController.navigationBar.shadowImage = [UIImage new];
        } else {
            [self.sn_navigationController.navigationBar sn_setBackgroundColor:[self.sn_navigationBarColor colorWithAlphaComponent:1]];
            [self.sn_navigationController.navigationBar setShadowImage:nil];
        }
    }

	if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
		self.navigationController.interactivePopGestureRecognizer.delegate = self;
	}
	
	if (self.sn_navigationController.viewControllers.count < 2) {
		self.sn_isAbleEdgeGesture = NO;
	}
}

//解决多次触发navigation边缘返回手势后的冲突
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	return self.sn_isAbleEdgeGesture; //    <UIGestureRecognizerDelegate>
}
- (void)viewDidLoad {
#pragma mark -- 在这儿定制样式
    [self sn_setNavigationbarHidden:NO animationComeBack:YES];
	
	//更新 navigation <- tabbarController 架构下navgationbar的标题
    
    if (self.tabBarController) {
		[self aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
			self.tabBarController.navigationItem.title = self.title;
		} error:NULL];
	}
	//设置导航栏背景色
    self.sn_navigationBarColor = [UIColor whiteColor];
//    self.view.backgroundColor = COLOR_BACK; //不能设置
    
    self.sn_navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName:COLOR_MAIN};
	
	//导航栏按钮
	if (self.sn_navigationController.viewControllers.count > 1) {
        [[self sn_setLeftBarbuttonItemImage:[UIImage imageNamed:@"public_return"] target:self action:@selector(hansleBackBarbuttonItem:)] setTintColor:COLOR_MAIN];
	}

}
#pragma clang diagnostic pop

#pragma mark -- event response
- (void)hansleBackBarbuttonItem:(UIBarButtonItem *)sender {
	[self.sn_navigationController popViewControllerAnimated:YES];
}

#pragma mark -- getter or setter

- (void)setSn_isNavigationBarHidden:(BOOL)sn_isNavigationBarHidden {
	if (sn_isNavigationBarHidden) {
		[self.sn_navigationController.navigationBar sn_setBackgroundColor:[self.sn_navigationBarColor colorWithAlphaComponent:0]];
		self.sn_navigationController.navigationBar.shadowImage = [UIImage new];
	} else {
		[self.sn_navigationController.navigationBar sn_setBackgroundColor:[self.sn_navigationBarColor colorWithAlphaComponent:1]];
		[self.sn_navigationController.navigationBar setShadowImage:nil];
	}
	objc_setAssociatedObject(self, @selector(sn_isNavigationBarHidden), @(sn_isNavigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)sn_isNavigationBarHidden {
	id sn_isNavigationBarHidden = objc_getAssociatedObject(self, _cmd);
	return sn_isNavigationBarHidden ? [sn_isNavigationBarHidden boolValue] : true;
}

- (void)setSn_navigationBarColor:(UIColor *)sn_navigationBarColor {
//    self.sn_navigationController.navigationBar.overlay.backgroundColor = sn_navigationBarColor;
	objc_setAssociatedObject(self, @selector(sn_navigationBarColor), sn_navigationBarColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)sn_navigationBarColor {
	return objc_getAssociatedObject(self, _cmd);
}

- (void)setSn_animationNavigationBarComeBack:(BOOL)sn_animationNavigationBarComeBack {
	
	if (sn_animationNavigationBarComeBack) {
		[UIView animateWithDuration:0.3 animations:^{
			[self.sn_navigationController.navigationBar sn_setBackgroundColor:[self.sn_navigationBarColor colorWithAlphaComponent:0]];
		} completion:^(BOOL finished) {
			
		}];
		self.sn_navigationController.navigationBar.shadowImage = [UIImage new];
		
	} else {
		[UIView animateWithDuration:0.3 animations:^{
			[self.sn_navigationController.navigationBar sn_setBackgroundColor:[self.sn_navigationBarColor colorWithAlphaComponent:1]];
		} completion:^(BOOL finished) {
			
		}];
		[self.sn_navigationController.navigationBar setShadowImage:nil];
	}
	objc_setAssociatedObject(self, @selector(sn_animationNavigationBarComeBack), @(sn_animationNavigationBarComeBack), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)sn_animationNavigationBarComeBack {
	id sn_animationNavigationBarComeBack = objc_getAssociatedObject(self, _cmd);
	return sn_animationNavigationBarComeBack ? [sn_animationNavigationBarComeBack boolValue] : true;
}

- (void)setSn_navigationController:(UINavigationController *)sn_navigationController {
	objc_setAssociatedObject(self, @selector(sn_navigationController), sn_navigationController, OBJC_ASSOCIATION_ASSIGN);
}
- (UINavigationController *)sn_navigationController {
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
- (void)setSn_navigationItem:(UINavigationItem *)sn_navigationItem {
	objc_setAssociatedObject(self, @selector(sn_navigationItem), sn_navigationItem, OBJC_ASSOCIATION_ASSIGN);
}
- (UINavigationItem *)sn_navigationItem {
	if (self.tabBarController) {
        return self.tabBarController.navigationItem;
	} else if (self.navigationController) {
		return self.navigationItem;
	} else {
		return objc_getAssociatedObject(self, _cmd);
	}
}

- (void)setSn_isAbleEdgeGesture:(BOOL)sn_isAbleEdgeGesture {
	objc_setAssociatedObject(self, @selector(sn_isAbleEdgeGesture), @(sn_isAbleEdgeGesture), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)sn_isAbleEdgeGesture {
	id sn_isAbleEdgeGesture = objc_getAssociatedObject(self, _cmd);
	return sn_isAbleEdgeGesture ? [sn_isAbleEdgeGesture boolValue] : true;
}

- (void)setSn_params:(NSMutableDictionary *)sn_params {
    objc_setAssociatedObject(self, @selector(sn_params), sn_params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableDictionary *)sn_params {
    NSMutableDictionary * tempDictionary = objc_getAssociatedObject(self, _cmd);
    if (!tempDictionary) {
        tempDictionary = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, @selector(sn_params), tempDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } return tempDictionary;
}



#pragma mark -- API

- (UIBarButtonItem *)sn_setRightBarbuttonItemTile:(NSString *)title target:(id)target action:(SEL)action {
	UIBarButtonItem * rightTitleItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
	[rightTitleItem setTintColor:COLOR_MAIN];
    
	self.sn_navigationItem.rightBarButtonItem = rightTitleItem;
	return rightTitleItem;
}
- (UIBarButtonItem *)sn_setLeftBarbuttonItemTile:(NSString *)title target:(id)target action:(SEL)action {
	UIBarButtonItem * leftTitleItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    [leftTitleItem setTintColor:COLOR_MAIN];
    
	self.sn_navigationItem.leftBarButtonItem = leftTitleItem;
	return leftTitleItem;
}

- (UIBarButtonItem *)sn_setRightBarbuttonItemImage:(UIImage *)image target:(id)target action:(SEL)action {
	UIBarButtonItem * rightTitleItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
	[rightTitleItem setTintColor:COLOR_MAIN];
	
	self.sn_navigationItem.rightBarButtonItem = rightTitleItem;
	return rightTitleItem;
}
- (UIBarButtonItem *)sn_setLeftBarbuttonItemImage:(UIImage *)image target:(id)target action:(SEL)action {
	UIBarButtonItem * leftTitleItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
	[leftTitleItem setTintColor:COLOR_MAIN];
    
	self.sn_navigationItem.leftBarButtonItem = leftTitleItem;
	return leftTitleItem;
}

- (void)sn_setNavigationbarHidden:(BOOL)hidden animationComeBack:(BOOL)animation {
    self.sn_isNavigationBarHidden = hidden;
    self.sn_animationNavigationBarComeBack = animation;
}


- (void)sn_popToViewControllerWithName:(NSString *)viewControllerName estimatedTabBarSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;
{
	UINavigationController * tempController;
	BOOL __block _isErrorSign = false;
	UIViewController * shouldViewController = [[NSClassFromString(viewControllerName) alloc] init];
	
	if (self.tabBarController) {
		tempController = self.tabBarController.navigationController;
	} else if (self.navigationController) {
		tempController = self.navigationController;
	} else {
		if (self.presentingViewController) {
			[self dismissViewControllerAnimated:animated completion:^{
				[[SNTool topViewController] sn_popToViewControllerWithName:viewControllerName estimatedTabBarSelectedIndex:selectedIndex animated:animated];
			}];
		} else {
			[tempController pushViewController:shouldViewController animated:animated];
		}
	}
	NSLog(@"viewControllers -- %@",tempController.viewControllers);
	
	for (UIViewController * obj in tempController.viewControllers) {
		_isErrorSign = YES;
		if ([obj isKindOfClass:[shouldViewController class]]) {
			[tempController popToViewController:obj animated:animated];
			_isErrorSign = NO;
			break;
		}
	}
	
	if (_isErrorSign) {
		[tempController popToRootViewControllerAnimated:animated];
		
		if ([tempController.viewControllers.lastObject isKindOfClass:[UITabBarController class]]) {
			UITabBarController * tabBarController = tempController.viewControllers.lastObject;
			
			NSLog(@"tabBarController -- %@",tabBarController.viewControllers);
			
			for (int i = 0; i < tabBarController.viewControllers.count; i ++) {
				_isErrorSign = YES;
				if ([tabBarController.viewControllers[i] isKindOfClass:[shouldViewController class]]) {
					tabBarController.selectedIndex = i;
					_isErrorSign = NO;
					break;
				}
			}
			if (selectedIndex >= 0) {
				tabBarController.selectedIndex = selectedIndex;
			}
			
		} else {
			[self dismissViewControllerAnimated:animated completion:^{
				[[SNTool topViewController] sn_popToViewControllerWithName:viewControllerName estimatedTabBarSelectedIndex:selectedIndex animated:animated];
			}];
		}
		if (_isErrorSign) {
			
			if (self.presentingViewController) {
				[self dismissViewControllerAnimated:animated completion:^{
					[[SNTool topViewController] sn_popToViewControllerWithName:viewControllerName estimatedTabBarSelectedIndex:selectedIndex animated:animated];
				}];
			} else {
				if ([SNTool topViewController].navigationController) {
					[[SNTool topViewController].navigationController pushViewController:shouldViewController animated:animated];
				} else {
					[[SNTool topViewController] presentViewController:shouldViewController animated:animated completion:^{
						
					}];
				}
			}
			NSLog(@"%@ is not within the scope of pop",viewControllerName);
		}
	}
}

@end
