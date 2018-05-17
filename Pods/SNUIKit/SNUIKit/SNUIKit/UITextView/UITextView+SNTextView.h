//
//  UITextView+SNTextView.h
//  snlo
//
//  Created by snlo on 2017/11/26.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (SNTextView)

/**
 textView的 Placeholder.支持tableviewCell上展示
 */
@property (nonatomic, strong) NSString * sn_placeholder;

/**
 文本输入框内容变化的回调，⚠️与 ‘RACSignal’有副作用 ⚠️
 */
- (void)sn_valueChangeBlock:(void(^)(NSString * value))block;

/**
 禁止复制
 */
@property (nonatomic, assign) IBInspectable BOOL sn_isMenuInVisible;

/**
 禁止表情输入
 */
@property (nonatomic, assign) IBInspectable BOOL sn_isForbidEmoji;

@end
