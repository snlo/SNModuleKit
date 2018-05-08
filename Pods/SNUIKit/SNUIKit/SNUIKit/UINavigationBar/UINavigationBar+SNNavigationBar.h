//
//  UINavigationBar+SNNavigationBar.h
//  WisView
//
//  Created by sunDong on 2017/4/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (SNNavigationBar)

/**
 背景视图
 */
@property (nonatomic, strong) UIView * sn_overlay;

/**
 设置背景颜色
 */
- (void)sn_setBackgroundColor:(UIColor *)backgroundColor;

/**
 设置透明度
 */
- (void)sn_setElementsAlpha:(CGFloat)alpha;

/**
 设置y轴位置
 */
- (void)sn_setTranslationY:(CGFloat)translationY;

@end
