//
//  UIView+XMGExtension.m
//  SNImageBrowserViewController
//
//  Created by snlo on 15/7/22.
//  Copyright (c) 2015年 snlo. All rights reserved.
//

#import "UIView+SNImageBrowserViewController.h"

@implementation UIView (SNImageBrowserViewController)

- (void)setYy_size:(CGSize)yy_size {
    CGRect frame = self.frame;
    frame.size = yy_size;
    self.frame = frame;
}

- (CGSize)yy_size {
    return self.frame.size;
}

- (void)setYy_width:(CGFloat)yy_width {
    if (isnan(yy_width)) {
        
        return;
    }
    CGRect frame = self.frame;
    frame.size.width = yy_width;
    self.frame = frame;
}

- (void)setYy_height:(CGFloat)yy_height {
    if (isnan(yy_height)) {
        
        return;
    }
    CGRect frame = self.frame;
    frame.size.height = yy_height;
    self.frame = frame;
}

- (void)setYy_x:(CGFloat)yy_x {
    if (isnan(yy_x)) {
        
        return;
    }
    CGRect frame = self.frame;
    frame.origin.x = yy_x;
    self.frame = frame;
}

- (void)setYy_y:(CGFloat)yy_y {
    CGRect frame = self.frame;
    frame.origin.y = yy_y;
    self.frame = frame;
}

- (void)setYy_centerX:(CGFloat)yy_centerX {
    CGPoint center = self.center;
    center.x = yy_centerX;
    self.center = center;
}

- (void)setYy_centerY:(CGFloat)yy_centerY {
    CGPoint center = self.center;
    center.y = yy_centerY;
    self.center = center;
}

- (CGFloat)yy_centerY {
    return self.center.y;
}

- (CGFloat)yy_centerX {
    return self.center.x;
}

- (CGFloat)yy_width {
    return self.frame.size.width;
}

- (CGFloat)yy_height {
    return self.frame.size.height;
}

- (CGFloat)yy_x {
    return self.frame.origin.x;
}

- (CGFloat)yy_y {
    return self.frame.origin.y;
}

//判断是否包含某个类的subview
- (BOOL)doHaveSubViewOfSubViewClassName:(NSString *)subViewClassName {
    BOOL doHave = NO;
    for (UIView *subView in self.subviews)
    {
        if ([subView isKindOfClass:NSClassFromString(subViewClassName)])
        {
            doHave = YES;
            break;
        }
    }
    return doHave;
}

//删除某个类的subview
- (void)removeSomeSubViewOfSubViewClassName:(NSString *)subViewClassName {
    for (UIView *subView in self.subviews)
    {
        if ([subView isKindOfClass:NSClassFromString(subViewClassName)])
        {
            [subView removeFromSuperview];
        }
    }
}

//得到某个类的subview
- (void)getTheSubViewOfSubViewClassName:(NSString *)subViewClassName block:(void(^)(UIView *subView))block {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView *subView in self.subviews)
        {
            if ([subView isKindOfClass:NSClassFromString(subViewClassName)])
            {
                block(subView);
            }
        }
        block(nil);
    });
}

@end
