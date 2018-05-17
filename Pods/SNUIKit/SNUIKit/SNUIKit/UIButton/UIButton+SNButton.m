//
//  UIButton+SNButton.m
//  snlo
//
//  Created by snlo on 2017/9/23.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UIButton+SNButton.h"
#import <objc/runtime.h>

@implementation UIButton (SNButton)

- (void)setSn_radius:(CGFloat)sn_radius {
	self.layer.cornerRadius = sn_radius;
	
	self.layer.masksToBounds = YES;

	NSNumber * number = [NSNumber numberWithFloat:sn_radius];
	objc_setAssociatedObject(self, @selector(sn_radius), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)sn_radius {
	NSNumber * number = objc_getAssociatedObject(self, _cmd);
	return [number floatValue];
}

- (void)sn_setNormalStateTitle:(NSString *)title {
    [self.titleLabel setText:title];
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)sn_PlumpCornerRadius {
    self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
    self.layer.borderColor = self.currentTitleColor.CGColor;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
}

- (void)sn_setTitleImageType:(SNButtonTitleImageType)type imageTitleSpace:(CGFloat)space {
    
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }

    switch (type) {
        case SNButtonTitleImageTypeTop: {
            [self setImageEdgeInsets:UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0)];
        } break;
        case SNButtonTitleImageTypeLeft: {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0)];
        } break;
        case SNButtonTitleImageTypeBottom: {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0)];
        } break;
        case SNButtonTitleImageTypeRight: {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0)];
        } break;
        default:
            break;
    }
}

@end
