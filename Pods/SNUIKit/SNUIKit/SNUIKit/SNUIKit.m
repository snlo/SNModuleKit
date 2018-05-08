//
//  SNUIKit.m
//  SNUIKit
//
//  Created by sunDong on 2018/5/8.
//  Copyright © 2018年 snloveydus. All rights reserved.
//

#import "SNUIKit.h"

#import "SNUIKitTool.h"

@implementation SNUIKit

#pragma mark -- setter

- (void)setContentColor:(UIColor *)contentColor {
	_contentColor = contentColor;
	[SNUIKitTool sharedManager].contentColor = _contentColor;
}
- (void)setBlackColor:(UIColor *)blackColor {
	_blackColor = blackColor;
	[SNUIKitTool sharedManager].blackColor = _blackColor;
}
- (void)setHintColor:(UIColor *)hintColor {
	_hintColor = hintColor;
	[SNUIKitTool sharedManager].hintColor = _hintColor;
}
- (void)setMainColor:(UIColor *)mainColor {
	_mainColor = mainColor;
	[SNUIKitTool sharedManager].mainColor = _mainColor;
}
- (void)setSeparatorColor:(UIColor *)separatorColor {
	_separatorColor = separatorColor;
	[SNUIKitTool sharedManager].separatorColor = _separatorColor;
}

@end
