//
//  UITextField+SNTextField.m
//  AiteCube
//
//  Created by snlo on 2017/12/9.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import "UITextField+SNTextField.h"
#import <objc/runtime.h>

@interface UITextField () <UITextFieldDelegate>

@end

@implementation UITextField (SNTextField)

#pragma mark -- 禁止复制
- (void)setSn_isMenuInVisible:(BOOL)sn_isMenuInVisible {
    NSNumber * number = [NSNumber numberWithBool:sn_isMenuInVisible];
    objc_setAssociatedObject(self, @selector(sn_isMenuInVisible), number, OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)sn_isMenuInVisible {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController && self.sn_isMenuInVisible) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

#pragma mark -- 禁止表情输入

- (void)setSn_isForbidEmoji:(BOOL)sn_isForbidEmoji {
	NSNumber * number = [NSNumber numberWithBool:sn_isForbidEmoji];
	self.delegate = self;
	objc_setAssociatedObject(self, @selector(sn_isForbidEmoji), number, OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)sn_isForbidEmoji {
	NSNumber * number = objc_getAssociatedObject(self, _cmd);
	return [number boolValue];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	// 不让输入表情
	if ([textField isFirstResponder]) {
		if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
			if (self.sn_isForbidEmoji) {
				return NO;
			} else {
				return YES;
			}
		}
	}
	return YES;
}

@end
