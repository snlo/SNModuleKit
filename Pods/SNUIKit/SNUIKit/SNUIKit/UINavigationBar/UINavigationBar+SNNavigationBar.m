//
//  UINavigationBar+SNNavigationBar.m
//  WisView
//
//  Created by sunDong on 2017/4/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UINavigationBar+SNNavigationBar.h"

#import <objc/runtime.h>

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation UINavigationBar (SNNavigationBar)

- (UIView *)sn_overlay {
	UIView * view = objc_getAssociatedObject(self, _cmd);
	if (!view) {
		view = [[UIView alloc] init];
		
		[self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
		self.shadowImage = [UIImage new];
		
		[[self.subviews firstObject] insertSubview:view atIndex:0];
		
		UIView * parentView = [self.subviews firstObject];
		parentView.layer.masksToBounds = YES;
		
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
		
		// 设置subView相对于VIEW的上左下右各40像素
		NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
		NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
		// 由于iOS坐标系的原点在左上角，所以设置右边距使用负值
		NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
		NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
		// 将四条约束加进数组中
		NSArray *array = [NSArray arrayWithObjects:constraint1, constraint2, constraint3, constraint4 ,nil];
		// 把约束条件设置到父视图的Contraints中
		[parentView addConstraints:array];
		
		objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	} return view;
}
- (void)setSn_overlay:(UIView *)sn_overlay {
	objc_setAssociatedObject(self, @selector(sn_overlay), sn_overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sn_setBackgroundColor:(UIColor *)backgroundColor {
	self.sn_overlay.backgroundColor = backgroundColor;
}

- (void)sn_setTranslationY:(CGFloat)translationY {
	self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)sn_setElementsAlpha:(CGFloat)alpha {
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];

    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];

    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}


@end
