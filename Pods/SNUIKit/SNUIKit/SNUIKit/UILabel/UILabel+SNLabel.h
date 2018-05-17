//
//  UILabel+SNLabel.h
//  snlo
//
//  Created by snlo on 2017/11/22.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SNLabel)

/**
 是否调整字体大小以使用label宽度，默认为‘NO’
 */
@property (nonatomic, assign) IBInspectable BOOL sn_isAdjustsFontSizeToFitWidth;

@end
