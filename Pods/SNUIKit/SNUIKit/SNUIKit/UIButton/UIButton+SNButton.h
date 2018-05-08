//
//  UIButton+SNButton.h
//  AiteCube
//
//  Created by sunDong on 2017/9/23.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,CustomImageType) {
    CustomImageTypeTop = 1,
    CustomImageTypeLeft,
    CustomImageTypeBottom,
    CustomImageTypeRight
};

@interface UIButton (SNButton)

/**
 圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat sn_radius;

/**
 *  设置button的标题避免隐式动画
 */
- (void)setNormalStateTitle:(NSString *)title;

/**
 饱和的圆角半斤
 */
- (void)sn_PlumpCornerRadius;

/**
 *  自定义样式
 */
- (void)setCustomImageType:(CustomImageType)type;

- (void)setCustomImageType:(CustomImageType)type interval:(CGFloat)interval;

- (void)setCustomImageType:(CustomImageType)type imageTitleSpace:(CGFloat)space;

@end
