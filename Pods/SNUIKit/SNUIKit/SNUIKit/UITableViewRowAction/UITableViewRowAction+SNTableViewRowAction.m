//
//  UITableViewRowAction+SNTableViewRowAction.m
//  SwipeToDeleteDemo
//
//  Created by snlo on 11/11/15.
//  Copyright © 2015 snlo. All rights reserved.
//

#import "UITableViewRowAction+SNTableViewRowAction.h"
#import <objc/runtime.h>

@implementation UITableViewRowAction (SNTableViewRowAction)

+ (instancetype)sn_rowActionWithStyle:(UITableViewRowActionStyle)style image:(UIImage *)image handler:(void (^)(UITableViewRowAction * _Nullable, NSIndexPath * _Nullable))handler {
    UITableViewRowAction *rowAction = [self rowActionWithStyle:style title:@"holder" handler:handler];
    rowAction.sn_enabled = image;
    return rowAction;
}

- (void)setSn_image:(UIImage *)sn_image {
    objc_setAssociatedObject(self, @selector(sn_image), sn_image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSn_enabled:(BOOL)sn_enabled {
    objc_setAssociatedObject(self, @selector(sn_enabled), @(sn_enabled), OBJC_ASSOCIATION_ASSIGN);
}

- (UIImage *)sn_image {
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)sn_enabled {
    id sn_enabled = objc_getAssociatedObject(self, _cmd);
    return sn_enabled ? [sn_enabled boolValue] : true;
}

@end
