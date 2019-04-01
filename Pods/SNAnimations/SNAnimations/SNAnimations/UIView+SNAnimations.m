//
//  UIView+SNAnimations.m
//  SNAnimations
//
//  Created by snlo on 2018/5/12.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "UIView+SNAnimations.h"
#import <objc/runtime.h>

typedef void(^SNAnimationsDidStartBlock)(CAAnimation * animation);
typedef void(^SNAnimationsDidStopBlock)(CAAnimation * animation);
typedef void(^SNAnimationsBeforeStopblock)(CAAnimation * animation);

@interface UIView ()

@property (nonatomic, copy) SNAnimationsDidStartBlock sn_didStartBlock;
@property (nonatomic, copy) SNAnimationsDidStopBlock sn_didStopBlock;
@property (nonatomic, copy) SNAnimationsBeforeStopblock sn_beforeStopblock;

@property (nonatomic) NSString * sn_animationKey;
@property (nonatomic) NSString * sn_animationValue;

@end

@implementation UIView (SNAnimations)

- (NSString *)sn_FetchAnimationKeyValue {
	NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"HHmmssSSS"];
	return [NSString stringWithFormat:@"%@%u",[formatter stringFromDate:[NSDate date]],arc4random_uniform(2000)];
}

- (void)sn_addAnimation:(CAAnimation *)animation didStartBlock:(void(^)(CAAnimation *Animation))didStartBlock didStopBlock:(void(^)(CAAnimation *Animation))didStopBlock beforeStopblock:(void(^)(CAAnimation *Animation))beforeStopblock {
	
	self.sn_animationKey = [self sn_FetchAnimationKeyValue];
	self.sn_animationValue = [self sn_FetchAnimationKeyValue];
	
	
	if (didStartBlock) {
		self.sn_didStartBlock = didStartBlock;
	}
	if (didStopBlock) {
		self.sn_didStopBlock = didStopBlock;
	}
	if (beforeStopblock) {
		self.sn_beforeStopblock = beforeStopblock;
	}
	
	animation.delegate = self;
	[animation setValue:self.sn_animationValue forKey:self.sn_animationKey];
	[self.layer addAnimation:animation forKey:self.sn_animationKey];
}

- (void)animationDidStart:(CAAnimation *)anim {
	if ([[anim valueForKey:self.sn_animationKey] isEqualToString:self.sn_animationValue]) {
		if (self.sn_didStartBlock) {
			self.sn_didStartBlock(anim);
		}
	}
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	if (!flag) {
		if ([[anim valueForKey:self.sn_animationKey] isEqualToString:self.sn_animationValue]) {
			if (self.sn_beforeStopblock) {
				self.sn_beforeStopblock(anim);
			}
		}
	} else {
		if ([[anim valueForKey:self.sn_animationKey] isEqualToString:self.sn_animationValue]) {
			if (self.sn_didStopBlock) {
				self.sn_didStopBlock(anim);
			}
		}
	}
	
}

#pragma mark -- getter / setter

- (void)setSn_didStartBlock:(SNAnimationsDidStartBlock)sn_didStartBlock {
	objc_setAssociatedObject(self, @selector(sn_didStartBlock), sn_didStartBlock, OBJC_ASSOCIATION_COPY);
}
- (SNAnimationsDidStartBlock)sn_didStartBlock {
	return objc_getAssociatedObject(self, _cmd);
}

- (void)setSn_didStopBlock:(SNAnimationsDidStopBlock)sn_didStopBlock {
	objc_setAssociatedObject(self, @selector(sn_didStopBlock), sn_didStopBlock, OBJC_ASSOCIATION_COPY);
}
- (SNAnimationsDidStopBlock)sn_didStopBlock {
	return objc_getAssociatedObject(self, _cmd);
}

- (void)setSn_beforeStopblock:(SNAnimationsBeforeStopblock)sn_beforeStopblock {
	objc_setAssociatedObject(self, @selector(sn_beforeStopblock), sn_beforeStopblock, OBJC_ASSOCIATION_COPY);
}
- (SNAnimationsBeforeStopblock)sn_beforeStopblock {
	return objc_getAssociatedObject(self, _cmd);
}

- (void)setSn_animationKey:(NSString *)sn_animationKey {
	objc_setAssociatedObject(self, @selector(sn_animationKey), sn_animationKey, OBJC_ASSOCIATION_RETAIN);
}
- (NSString *)sn_animationKey {
    NSString * string = objc_getAssociatedObject(self, _cmd);
    if (!string) {
        string = @"";
    } return string;
}

- (void)setSn_animationValue:(NSString *)sn_animationValue {
	objc_setAssociatedObject(self, @selector(sn_animationValue), sn_animationValue, OBJC_ASSOCIATION_RETAIN);
}
- (NSString *)sn_animationValue {
    NSString * string = objc_getAssociatedObject(self, _cmd);
    if (!string) {
        string = @"";
    } return string;
}

@end
