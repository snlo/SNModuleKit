//
//  UITableView+SNTableView.h
//  AiteCube
//
//  Created by snlo on 2017/11/10.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SNTableView)

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray * sn_dataSource;

@property (nonatomic, readonly) UIView * sn_viewNoMoreData;

/**
 设置动态 scrollEnabled 属性
 */
- (void)sn_setAutoScrollEnabled;

@end
