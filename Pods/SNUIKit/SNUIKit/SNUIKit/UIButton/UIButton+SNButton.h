//
//  UIButton+SNButton.h
//  snlo
//
//  Created by snlo on 2017/9/23.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,SNButtonTitleImageType) {
    SNButtonTitleImageTypeTop = 1,
    SNButtonTitleImageTypeLeft,
    SNButtonTitleImageTypeBottom,
    SNButtonTitleImageTypeRight
};

@interface UIButton (SNButton)

/**
 圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat sn_radius;

/**
 设置button的标题避免隐式动画
 */
- (void)sn_setNormalStateTitle:(NSString *)title;

/**
 饱和的圆角，圆角直径等于高
 */
- (void)sn_PlumpCornerRadius;

/**
 设置标题与图片类型
 */
- (void)sn_setTitleImageType:(SNButtonTitleImageType)type imageTitleSpace:(CGFloat)space;

@end
