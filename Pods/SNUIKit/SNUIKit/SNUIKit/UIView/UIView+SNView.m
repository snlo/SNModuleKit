//
//  UIView+SNView.m
//  snlo
//
//  Created by snlo on 2017/9/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UIView+SNView.h"
#import <objc/runtime.h>

typedef void(^ReloadBlock)(RACSubject * commanReload);

@interface UIView ()

@property (nonatomic, strong) UIView * sn_viewFailed;
@property (nonatomic, strong) UIView * sn_viewEmpty;

@property (nonatomic, copy) ReloadBlock reloadBlock;

@end

@implementation UIView (SNView)

+ (instancetype)sn_viewWithNib {
    UIView * view = [[UIView alloc] init];
    view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    return view;
}

- (void)setSn_showShadow:(BOOL)sn_showShadow {
    
    if (sn_showShadow) {
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        
        self.layer.shadowOpacity = 0.5f;
        
        self.layer.shadowOffset = CGSizeMake(0, 2);
        
        self.layer.shadowRadius = 8;
    }
    
    NSNumber * number = [NSNumber numberWithFloat:sn_showShadow];
    objc_setAssociatedObject(self, @selector(sn_showShadow), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSn_shadowColor:(UIColor *)sn_shadowColor {
	self.layer.shadowColor = sn_shadowColor.CGColor;
	objc_setAssociatedObject(self, @selector(sn_shadowColor), sn_shadowColor, OBJC_ASSOCIATION_COPY);
}
- (UIColor *)sn_shadowColor {
	return objc_getAssociatedObject(self, _cmd);
}

- (void)setSn_radius:(CGFloat)sn_radius {
    self.layer.cornerRadius = sn_radius;
    
    NSNumber * number = [NSNumber numberWithFloat:sn_radius];
    objc_setAssociatedObject(self, @selector(sn_radius), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sn_showShadow {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}
- (CGFloat)sn_radius {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number floatValue];
}

#pragma mark -- 设置边框线宽度和颜色
- (void)setSn_borderWidth:(CGFloat)sn_borderWidth {
    if (sn_borderWidth > 0) {
        self.layer.borderWidth = sn_borderWidth;
        self.layer.masksToBounds = YES;
    }
    NSNumber * number = [NSNumber numberWithFloat:sn_borderWidth];
    objc_setAssociatedObject(self, @selector(sn_borderWidth), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)sn_borderWidth {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number floatValue];
}
- (void)setSn_borderColor:(UIColor *)sn_borderColor {
    self.layer.borderColor = sn_borderColor.CGColor;
    objc_setAssociatedObject(self, @selector(sn_borderColor), sn_borderColor, OBJC_ASSOCIATION_COPY);
}
- (UIColor *)sn_borderColor {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark -- api
- (void)sn_reloadBlock:(void(^)(RACSubject * commandReload))block {
    if (block) {
        self.reloadBlock = block;
    }
}

#pragma mark -- getter or setter
- (void)setReloadBlock:(ReloadBlock)reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (ReloadBlock)reloadBlock {
    return objc_getAssociatedObject(self, _cmd);
}

@end
