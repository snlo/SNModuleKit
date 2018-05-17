//
//  UITableViewHeaderFooterView+SNHeaderFooterView.m
//  snlo
//
//  Created by snlo on 2017/12/13.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UITableViewHeaderFooterView+SNHeaderFooterView.h"

#import <objc/runtime.h>

@implementation UITableViewHeaderFooterView (SNHeaderFooterView)

+ (instancetype)sn_nibHeaderFooterViewWithTabelView:(UITableView *)tabelView section:(NSUInteger)section {
    
    NSString * identifier = NSStringFromClass([self class]);
    
    [tabelView registerNib:[UINib nibWithNibName:identifier bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];
    
    UITableViewHeaderFooterView * view = [tabelView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    return view;
}

+ (instancetype)sn_headerFooterViewWithTabelView:(UITableView *)tabelView section:(NSUInteger)section {
    
    NSString * identifier = NSStringFromClass([self class]);
    
    [tabelView registerClass:self forHeaderFooterViewReuseIdentifier:identifier];
    
    UITableViewHeaderFooterView * view = [tabelView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    return view;
}

@end
