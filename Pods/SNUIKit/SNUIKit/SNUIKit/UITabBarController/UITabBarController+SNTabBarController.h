//
//  UITabBarController+SNTabBarController.h
//  AiteCube
//
//  Created by snlo on 2017/11/3.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (SNTabBarController)

/**
 设置分割线 下移 上移 偏移值
 
 @param hidden 是否隐藏
 */
- (void)sn_setSeparatorLineHidden:(BOOL)hidden;

/**
 tabbar 下移
 
 @param offset 偏移值
 @param animation 是否动画
 */
- (void)sn_tabBarMoveDownOffset:(CGFloat)offset animation:(BOOL)animation;

/**
 tabbar 上移
 
 @param offset 偏移值
 @param animation 是否动画
 */
- (void)sn_tabBarMoveUpOffset:(CGFloat)offset animation:(BOOL)animation;

/**
 是否隐藏标签栏
 */
- (void)sn_tabBarHidden:(BOOL)hidden;

@end

