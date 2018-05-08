//
//  UITableViewCell+SNCell.h
//  DoorBell
//
//  Created by sunDong on 2017/8/9.
//  Copyright © 2017年 sundong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (SNCell)

/**
 加载xib创建的cell
 */
+ (instancetype)sn_nibCellWithTabelView:(UITableView *)tabelView indexPath:(NSIndexPath *)indexPath;

/**
 加载非xib创建的cell
 */
+ (instancetype)sn_cellWithTabelView:(UITableView *)tabelView indexPath:(NSIndexPath *)indexPath;

/**
 自己的tableview
 */
- (UITableView *)sn_tableView;


@end
