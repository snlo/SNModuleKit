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

+ (CABasicAnimation *)fadeInAnimationToAlpha:(CGFloat)toAlpha duration:(CFTimeInterval)duration {
    //淡入淡出动画
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = duration;
    animation.fromValue = @0;
    animation.toValue = @(toAlpha);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}
+ (CABasicAnimation *)fadeOutAnimationDuration:(CFTimeInterval)duration {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = duration;
    animation.toValue = @0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
//    animation.delegate = self;
    return animation;
}
+ (CABasicAnimation *)bottomOutAnimationMoveY:(CGFloat)moveY duration:(CFTimeInterval)duration {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.duration = duration;
    animation.fromValue = @([UIScreen mainScreen].bounds.size.height + moveY);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)bottomInAnimationMoveY:(CGFloat)moveY duration:(CFTimeInterval)duration {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.duration = duration;
    animation.toValue = @([UIScreen mainScreen].bounds.size.height + moveY);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)zoomInAnimationToPorportion:(NSNumber *)porportion duration:(CFTimeInterval)duration {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = duration;
    animation.fromValue = @0;
    animation.toValue = porportion;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)zoomOutAnimationDuration:(CFTimeInterval)duration {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = duration;
    animation.toValue = @0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)rotaeAnimationformValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(CFTimeInterval)duration {
    CABasicAnimation *animation;
    animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.duration = duration;
    animation.fromValue = [NSNumber numberWithFloat:fromValue];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)shakeAnimationformValue:(CGFloat)fromValue toValue:(CGFloat)toValue repeatCount:(CGFloat)repeatCount duration:(CFTimeInterval)duration {
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shakeAnimation.duration = duration;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
    shakeAnimation.toValue = [NSNumber numberWithFloat:toValue];
	shakeAnimation.removedOnCompletion = NO;
    shakeAnimation.autoreverses = YES;
    shakeAnimation.repeatCount = repeatCount;
//	shakeAnimation.delegate = self;
    return shakeAnimation;
}

#pragma mark -- CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
	NSLog(@"animation start");
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	NSLog(@"animation stop %@",flag ? @"YES":@"NO");
}

@end
