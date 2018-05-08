//
//  SNAnimations.h
//  BlankCode
//
//  Created by sunDong on 16/5/31.
//  Copyright © 2016年 sunDong. All rights reserved.
//
/**
 *  ps:提供简单的出场、退场动画。
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

static const CGFloat kAnimationTime = 0.3;

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 90400

@interface SNAnimations : NSObject<CAAnimationDelegate>

#else

@interface SNAnimations : NSObject

#endif

/**
 淡入
 */
+ (CABasicAnimation *)fadeInAnimationToAlpha:(CGFloat)toAlpha;

/**
 淡出
 */
+ (CABasicAnimation *)fadeOutAnimation;

/**
 从底部出现
 */
+ (CABasicAnimation *)bottomOutAnimationMoveY:(CGFloat)moveY;

/**
 消失进入底部
 */
+ (CABasicAnimation *)bottomInAnimationMoveY:(CGFloat)moveY;

/**
 放大
 */
+ (CABasicAnimation *)zoomInAnimationToPorportion:(NSNumber *)porportion;

/**
 缩小
 */
+ (CABasicAnimation *)zoomOutAnimation;

/**
 旋转
 */
+ (CABasicAnimation *)rotaeAnimationformValue:(CGFloat)fromValue toValue:(CGFloat)toValue;

/**
 晃动 eg:-5,5
 */
+ (CABasicAnimation *)shakeAnimationformValue:(CGFloat)fromValue toValue:(CGFloat)toValue;

@end
