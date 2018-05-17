//
//  UITableViewCell+SNCell.m
//  DoorBell
//
//  Created by snlo on 2017/8/9.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UITableViewCell+SNCell.h"

@implementation UITableViewCell (SNCell)

+ (instancetype)sn_nibCellWithTabelView:(UITableView *)tabelView indexPath:(NSIndexPath *)indexPath {
	NSString * identifier = NSStringFromClass([self class]);
	
	[tabelView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
	
	UITableViewCell * cell = [tabelView dequeueReusableCellWithIdentifier:identifier];

	return cell;
}

+ (instancetype)sn_cellWithTabelView:(UITableView *)tabelView indexPath:(NSIndexPath *)indexPath {
	NSString * identifier = NSStringFromClass([self class]);
	
	[tabelView registerClass:self forCellReuseIdentifier:identifier];
	
	UITableViewCell * cell = [tabelView dequeueReusableCellWithIdentifier:identifier];

	return cell;
}

#pragma mark -- public methods
- (BOOL)findFirstCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return YES;
    } else {
        return NO;
    }
}
- (BOOL)findLastCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark -- getter / setter

- (UITableView *)sn_tableView {
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

@end
