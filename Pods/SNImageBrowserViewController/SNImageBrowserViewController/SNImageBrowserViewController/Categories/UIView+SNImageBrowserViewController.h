//
//  UIView+XMGExtension.h
//  SNImageBrowserViewController
//
//  Created by snlo on 15/7/22.
//  Copyright (c) 2015年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SNImageBrowserViewController)
@property (nonatomic, assign) CGSize yy_size;
@property (nonatomic, assign) CGFloat yy_width;
@property (nonatomic, assign) CGFloat yy_height;
@property (nonatomic, assign) CGFloat yy_x;
@property (nonatomic, assign) CGFloat yy_y;
@property (nonatomic, assign) CGFloat yy_centerX;
@property (nonatomic, assign) CGFloat yy_centerY;

//判断是否包含某个类的subview
- (BOOL)doHaveSubViewOfSubViewClassName:(NSString *)subViewClassName;

//删除某个类的subview
- (void)removeSomeSubViewOfSubViewClassName:(NSString *)subViewClassName;

//得到某个类的subview
- (void)getTheSubViewOfSubViewClassName:(NSString *)subViewClassName block:(void(^)(UIView *subView))block;

@end
