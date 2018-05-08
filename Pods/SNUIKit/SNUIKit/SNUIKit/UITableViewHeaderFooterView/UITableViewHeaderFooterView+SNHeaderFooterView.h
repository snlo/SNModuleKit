//
//  UITableViewHeaderFooterView+SNHeaderFooterView.h
//  AiteCube
//
//  Created by snlo on 2017/12/13.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewHeaderFooterView (SNHeaderFooterView)

/**
 加载xib创建的headerFooterView
 */
+ (instancetype)sn_nibHeaderFooterViewWithTabelView:(UITableView *)tabelView section:(NSUInteger)section;

/**
 加载非xib创建的headerFooterView
 */
+ (instancetype)sn_headerFooterViewWithTabelView:(UITableView *)tabelView section:(NSUInteger)section;

@end
