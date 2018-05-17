//
//  UINavigationController+SNTabTabBarController.m
//  snlo
//
//  Created by snlo on 2017/9/29.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UINavigationController+SNTabTabBarController.h"

#import <objc/runtime.h>

#import "SNUIKitTool.h"

@interface UINavigationController ()

@property (nonatomic, strong) UITabBarController * sn_tabBarController;

@property (nonatomic, strong) NSArray <UIViewController *> * sn_itemsViewControllers;
@property (nonatomic, strong) NSArray <NSString *> * sn_itemsTitle;
@property (nonatomic, strong) NSArray <NSString *> * sn_itemsImageNmae;
@property (nonatomic, strong) NSArray <NSString *> * sn_itemsSelectedImageName;

@end

@implementation UINavigationController (SNTabTabBarController)

- (instancetype)initWithTabBarController
{
	self = [super init];
	if (self) {
		[self configurceViews];
		self = [self initWithRootViewController:self.sn_tabBarController];
	}
	return self;
}

- (instancetype)initWithTabBarViewControllers:(NSArray <UIViewController *> *)viewControllers
                                         itemsTitle:(NSArray <NSString *> *)itemsTitle
                                     itemsImageNmae:(NSArray <NSString *> *)itemsImageNmae
                             itemsSelectedImageName:(NSArray <NSString *> *)itemsSelectedImageName {
    self = [super init];
    if (self) {
        self.sn_itemsViewControllers = viewControllers;
        self.sn_itemsTitle = itemsTitle;
        self.sn_itemsImageNmae = itemsImageNmae;
        self.sn_itemsSelectedImageName = itemsSelectedImageName;
        
        [self configurceViews];
        
        self = [self initWithRootViewController:self.sn_tabBarController];
    }
    return self;
}

+ (instancetype)sn_navigationWithTabBarViewControllers:(NSArray <UIViewController *> *)viewControllers
                                         itemsTitle:(NSArray <NSString *> *)itemsTitle
                                     itemsImageNmae:(NSArray <NSString *> *)itemsImageNmae
                             itemsSelectedImageName:(NSArray <NSString *> *)itemsSelectedImageName
{
    return [[self alloc] initWithTabBarViewControllers:viewControllers itemsTitle:itemsTitle itemsImageNmae:itemsImageNmae itemsSelectedImageName:itemsSelectedImageName];
}

- (void)configurceViews {
    
	self.sn_tabBarController.viewControllers = [self sn_tabBarControllerViewControllers];
	
	[self sn_setTabBarItemTitleTextColor:COLOR_CONTENT normalfont:[UIFont systemFontOfSize:12.0f] forState:UIControlStateNormal];
	[self sn_setTabBarItemTitleTextColor:COLOR_TITLE normalfont:[UIFont systemFontOfSize:12.0f] forState:UIControlStateSelected];

	for (int i = 0; i < [self sn_tabBarControllerViewControllers].count; ++i) {
		
		[self configureTabbrItemTitle:[self sn_tabBarItemsTitle][i]
								pages:i
							imageName:[self sn_tabBarItemsImageNmae][i]
					selectedImageName:[self sn_tabBarItemsSelectedImageName][i]];
		
		self.sn_tabBarController.viewControllers[i].title = [self sn_tabBarItemsTitle][i];
	}
    
    if ([self sn_tabBarControllerViewControllers].count < 2) {
        self.sn_tabBarController.tabBar.hidden = YES;
    }
}

- (void)sn_setTabBarItemTitleTextColor:(UIColor *)color normalfont:(UIFont*)font forState:(UIControlState)state {
	[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName, font,NSFontAttributeName,nil] forState:state];
}

#pragma mark -- rewrite methods
- (NSArray <UIViewController *> *)sn_tabBarControllerViewControllers {
    return self.sn_itemsViewControllers;
}
- (NSArray <NSString *> *)sn_tabBarItemsTitle {
    return self.sn_itemsTitle;
}
- (NSArray <NSString *> *)sn_tabBarItemsImageNmae {
    return self.sn_itemsImageNmae;
}
- (NSArray <NSString *> *)sn_tabBarItemsSelectedImageName {
    return self.sn_itemsSelectedImageName;
}

#pragma mark -- private methods

- (void)configureTabbrItemTitle:(NSString *)title pages:(int)pages imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
	self.sn_tabBarController.tabBar.items[pages].image = [IMAGE_NAMED(imageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; //蓝色BUG
	self.sn_tabBarController.tabBar.items[pages].selectedImage = [IMAGE_NAMED(selectedImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	self.sn_tabBarController.tabBar.items[pages].title = title;
}


#pragma mark -- getter or setter

/**
 sn_tabBarController
 */
- (UITabBarController *)sn_tabBarController {
    UITabBarController * tabbarController = objc_getAssociatedObject(self, _cmd);
    if (!tabbarController) {
        tabbarController = [[UITabBarController alloc] init];
        objc_setAssociatedObject(self, _cmd, tabbarController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
	return tabbarController;
}
- (void)setSn_tabBarController:(UITabBarController *)sn_tabBarController {
	objc_setAssociatedObject(self, @selector(sn_tabBarController), sn_tabBarController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 itemsViewControllers
 */
- (NSArray<UIViewController *> *)sn_itemsViewControllers {
    NSArray * array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        array = [[NSArray alloc] init];
        objc_setAssociatedObject(self, _cmd, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return array;
}
- (void)setSn_itemsViewControllers:(NSArray<UIViewController *> *)sn_itemsViewControllers {
    objc_setAssociatedObject(self, @selector(sn_itemsViewControllers), sn_itemsViewControllers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 itemsTitle
 */
- (NSArray<NSString *> *)sn_itemsTitle {
    NSArray * array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        array = [[NSArray alloc] init];
        objc_setAssociatedObject(self, _cmd, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return array;
}
- (void)setSn_itemsTitle:(NSArray<NSString *> *)sn_itemsTitle {
    objc_setAssociatedObject(self, @selector(sn_itemsTitle), sn_itemsTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 itemsImageNmae
 */
- (NSArray<NSString *> *)sn_itemsImageNmae {
    NSArray * array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        array = [[NSArray alloc] init];
        objc_setAssociatedObject(self, _cmd, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return array;
}
- (void)setSn_itemsImageNmae:(NSArray<NSString *> *)sn_itemsImageNmae {
    objc_setAssociatedObject(self, @selector(sn_itemsImageNmae), sn_itemsImageNmae, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 itemsSelectedImageName
 */
- (NSArray<NSString *> *)sn_itemsSelectedImageName {
    NSArray * array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        array = [[NSArray alloc] init];
        objc_setAssociatedObject(self, _cmd, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return array;
}
- (void)setSn_itemsSelectedImageName:(NSArray<NSString *> *)sn_itemsSelectedImageName {
    objc_setAssociatedObject(self, @selector(sn_itemsSelectedImageName), sn_itemsSelectedImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
