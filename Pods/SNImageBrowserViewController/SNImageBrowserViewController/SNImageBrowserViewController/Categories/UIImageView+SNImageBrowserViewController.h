//
//  UIImageView+SNPhotoBrowsing.h
//  SNImageBrowserViewController
//
//  Created by snlo on 2018/4/16.
//  Copyright © 2018年 snlo All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SNImageBrowserViewController)

@property (nonatomic, readonly, assign) NSUInteger indexBrowse;

/**
 原始浏览图片的函数，支持网络图片数据源

 @param can 是否能浏览图片
 @param doBlock 打开浏览器前
 @param tapGestureBlock imageview tap 事件具体内容
 */
- (void)sn_canBrowse:(BOOL)can doBlock:(void(^)(void))doBlock tapGestureBlock:(void(^)(UITapGestureRecognizer * sender))tapGestureBlock;

/**
 浏览图片（预先知道图片数据）

 @param nameArray 图片名数组
 @param viewArray 图片视图数组
 */
- (void)sn_browsingWithImageNameArray:(NSArray <NSString *> *)nameArray viewArray:(NSArray <UIImageView *> *)viewArray;

/**
 浏览图片（使用于动态改变的图片数据）

 @param dataSource 数据源，key:图片名 value:图片视图
 @param nameArray  有序的图片名数组，旨在为数据源排序
 */
- (void)sn_browsingWithDataSource:(NSMutableDictionary <NSString *, UIImageView *>* )dataSource orderlyImageNameArray:(NSMutableArray <NSString *> *)nameArray;


@end
