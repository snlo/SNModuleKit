//
//  SNUIKit.h
//  SNUIKit
//
//  Created by sunDong on 2018/5/8.
//  Copyright © 2018年 snloveydus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


#import "UINavigationController+SNTabTabBarController.h"
#import "UIImageView+SNImageView.h"
#import "UIViewController+SNViewController.h"
#import "UIView+SNView.h"
#import "UITableViewCell+SNCell.h"
#import "UICollectionViewCell+SNCell.h"
#import "UITableViewHeaderFooterView+SNHeaderFooterView.h"
#import "UITableView+SNTableView.h"
#import "UINavigationBar+SNNavigationBar.h"
#import "UICollectionViewCell+SNCell.h"
#import "UIButton+SNButton.h"
#import "UITabBarController+SNTabBarController.h"
#import "UITextView+SNTextView.h"
#import "UITextField+SNTextField.h"
#import "UITableViewRowAction+SNTableViewRowAction.h"

@interface SNUIKit : NSObject

@property (nonatomic, strong) UIColor * contentColor;

@property (nonatomic, strong) UIColor * blackColor;

@property (nonatomic, strong) UIColor * hintColor;

@property (nonatomic, strong) UIColor * mainColor;

@property (nonatomic, strong) UIColor * separatorColor;

@end
