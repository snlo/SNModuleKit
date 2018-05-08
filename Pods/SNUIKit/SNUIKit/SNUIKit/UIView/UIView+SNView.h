//
//  UIView+SNView.h
//  AiteCube
//
//  Created by sunDong on 2017/9/28.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSubject;

@interface UIView (SNView)

/**
 加载XIB文件
 */
+ (instancetype)sn_viewWithNib;

/**
 显示阴影，默认为NO
 */
@property (nonatomic, assign) IBInspectable BOOL sn_showShadow;

/**
 阴影颜色
 */
@property (nonatomic, copy) IBInspectable UIColor * sn_shadowColor;

/**
 添加圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat sn_radius;

/**
 设置边框线宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat sn_borderWidth;

/**
 设置边框线颜色
 */
@property (nonatomic, copy) IBInspectable UIColor * sn_borderColor;

/**
 失败视图
 */
@property (nonatomic, readonly) UIView * sn_viewFailed;

/**
 重新加载
 */
- (void)sn_reloadBlock:(void(^)(RACSubject * commandReload))block;

/**
 空载视图
 */
@property (nonatomic, readonly) UIView * sn_viewEmpty;



@end
