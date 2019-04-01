//
//  SNScanTool.h
//  SNSacnViewController
//
//  Created by snlo on 2018/5/8.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <SNTool.h>

#define SNSACN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SNSACN_SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height

singletonInterface(SNScanTool)

/**
 国际化
 */
+ (NSString *)localizedString:(NSString *)key;

/**
 镂空抠图
 */
+ (void)scanAddMaskToView:(UIView *)view withRoundedRect:(CGRect)roundedRect cornerRadius:(CGFloat)cornerRadius;

@end
