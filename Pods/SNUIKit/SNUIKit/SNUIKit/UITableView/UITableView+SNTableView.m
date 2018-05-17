//
//  UITableView+SNTableView.m
//  snlo
//
//  Created by snlo on 2017/11/10.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UITableView+SNTableView.h"
#import <objc/runtime.h>

#import "SNUIKitTool.h"

#import "UIView+SNView.h"

@interface UITableView ()

@property (nonatomic, strong) UIView * sn_viewNoMoreData;

@end

@implementation UITableView (SNTableView)

- (void)updateConstraints {
    
    self.separatorColor = COLOR_SEPARATOR;
    
    [super updateConstraints];
}

#pragma mark -- setter / getter
- (void)setSn_dataSource:(NSMutableArray *)sn_dataSource {
    if (sn_dataSource.count > 0) {
        [self.sn_viewNoMoreData removeFromSuperview];
        objc_setAssociatedObject(self, @selector(sn_viewNoMoreData), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else { //表单数据为空的界面呈现
        [self sn_viewNoMoreData];
    }
    objc_setAssociatedObject(self, @selector(sn_dataSource), sn_dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)sn_dataSource {
    NSMutableArray * source = objc_getAssociatedObject(self, _cmd);
    if (source == nil) {
        source = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, _cmd, source, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return source;
}


- (void)setSn_viewNoMoreData:(UIView *)sn_viewNoMoreData {
    objc_setAssociatedObject(self, @selector(sn_viewNoMoreData), sn_viewNoMoreData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)sn_viewNoMoreData {
    UIView * view = objc_getAssociatedObject(self, _cmd);
    if (view == nil) {
        
        view = [UIView sn_viewWithNib];
        view.frame = self.frame;
        
        [self insertSubview:view aboveSubview:self.subviews.lastObject];
        
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } return view;
}

- (void)sn_setAutoScrollEnabled {
	if (self.contentSize.height > CGRectGetHeight(self.bounds) - self.contentInset.top) {
		self.scrollEnabled = YES;
	} else { //sn_auto_scroll
		self.scrollEnabled = NO;
	}
}

@end
