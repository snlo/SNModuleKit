//
//  UINavigationController+SNTabTabBarController.h
//  snlo
//
//  Created by snlo on 2017/9/29.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
                     vc
                  /
                 /
 nav -- tabbar -  -  vc
                 \
                  \
                     vc
 */
@interface UINavigationController (SNTabTabBarController)

/**
 初始化
 */
- (instancetype)initWithTabBarController;

/**
 标签视图控制器
 */
@property (nonatomic, readonly) UITabBarController * sn_tabBarController;

/**
 初始化一个标签导航控制器

 @param viewControllers 标签视图集
 @param itemsTitle 标签标题集
 @param itemsImageNmae 标签未选中图片名称集
 @param itemsSelectedImageName 标签中图片名称集
 @return 导航控制器
 */
+ (instancetype)sn_navigationWithTabBarViewControllers:(NSArray <UIViewController *> *)viewControllers
                                         itemsTitle:(NSArray <NSString *> *)itemsTitle
                                     itemsImageNmae:(NSArray <NSString *> *)itemsImageNmae
                             itemsSelectedImageName:(NSArray <NSString *> *)itemsSelectedImageName;

/**
 设置标签栏按钮标题式样
 */
- (void)sn_setTabBarItemTitleTextColor:(UIColor *)color normalfont:(UIFont*)font forState:(UIControlState)state;

/**
 标签内容视图集
 */
- (NSArray <UIViewController *> *)sn_tabBarControllerViewControllers;

/**
 标签内容视图标题以及对应的标签标题集
 */
- (NSArray <NSString *> *)sn_tabBarItemsTitle;

/**
 标签内容视图标签未选中图片集
 */
- (NSArray <NSString *> *)sn_tabBarItemsImageNmae;

/**
 标签内容视图标签选中图片集
 */
- (NSArray <NSString *> *)sn_tabBarItemsSelectedImageName;

@end
