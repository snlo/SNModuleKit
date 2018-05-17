//
//  UITableViewRowAction+SNTableViewRowAction.h
//  MIX
//
//  Created by snlo on 10/23/15.
//  Copyright © 2015 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewRowAction (SNTableViewRowAction)

@property (nonatomic, strong, nullable) UIImage * sn_image;

@property (nonatomic, assign) BOOL sn_enabled;

+ (nonnull instancetype)sn_rowActionWithStyle:(UITableViewRowActionStyle)style image:(nullable UIImage *)image handler:(nullable void (^)(UITableViewRowAction * _Nullable action, NSIndexPath * _Nullable indexPath))handler;

@end
