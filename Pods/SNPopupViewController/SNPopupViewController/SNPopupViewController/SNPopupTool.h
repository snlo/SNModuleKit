//
//  SNPopupTool.h
//  SNPopupViewController
//
//  Created by sunDong on 2018/5/6.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "UIViewController+SNPopupViewController.h"

#define SNPOPUP_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SNPOPUP_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SNPopupTool : NSObject

+ (UIViewController *)topViewController;

+ (UIViewController *)getNextViewController;

@end
