//
//  SNAnimations.m
//  BlankCode
//
//  Created by sunDong on 16/5/31.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNAnimations.h"

@interface SNAnimations ()

@end

@implementation SNAnimations

+ (CABasicAnimation *)fadeInAnimationToAlpha:(CGFloat)toAlpha
{
    //淡入淡出动画
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = kAnimationTime;
    animation.fromValue = @0;
    animation.toValue = @(toAlpha);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}
+ (CABasicAnimation *)fadeOutAnimation
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = kAnimationTime;
    animation.toValue = @0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
//    animation.delegate = self;
    return animation;
}
+ (CABasicAnimation *)bottomOutAnimationMoveY:(CGFloat)moveY
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.duration = kAnimationTime;
    animation.fromValue = @([UIScreen mainScreen].bounds.size.height + moveY);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)bottomInAnimationMoveY:(CGFloat)moveY
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.duration = kAnimationTime;
    animation.toValue = @([UIScreen mainScreen].bounds.size.height + moveY);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)zoomInAnimationToPorportion:(NSNumber *)porportion
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = kAnimationTime;
    animation.fromValue = @0;
    animation.toValue = porportion;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)zoomOutAnimation
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = kAnimationTime * 0.6;
    animation.toValue = @0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)rotaeAnimationformValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
    CABasicAnimation *animation;
    animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = kAnimationTime;
    animation.fromValue = [NSNumber numberWithFloat:fromValue];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)shakeAnimationformValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shakeAnimation.duration = 0.05f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
    shakeAnimation.toValue = [NSNumber numberWithFloat:toValue];
    shakeAnimation.autoreverses = YES;
    shakeAnimation.repeatCount = 5;
    return shakeAnimation;
}

@end
