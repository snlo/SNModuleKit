//
//  UITextField+SNTextField.h
//  AiteCube
//
//  Created by snlo on 2017/12/9.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SNTextField)

/**
 禁止复制
 */
@property (nonatomic, assign) IBInspectable BOOL sn_isMenuInVisible;

/**
 禁止表情输入
 */
@property (nonatomic, assign) IBInspectable BOOL sn_isForbidEmoji;

@end
