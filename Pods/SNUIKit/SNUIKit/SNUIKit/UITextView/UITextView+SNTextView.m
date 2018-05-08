//
//  UITextView+SNTextView.m
//  AiteCube
//
//  Created by snlo on 2017/11/26.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import "UITextView+SNTextView.h"
#import <objc/runtime.h>

#import <Masonry.h>

#import <ReactiveObjC.h>

typedef void(^SNValueChnageBlock)(NSString * value);

@interface UITextView () <UITextViewDelegate>

@property (nonatomic, strong) UILabel * placeHolderLabel;

@property (nonatomic, copy) SNValueChnageBlock valueChnageBlock;

@end

@implementation UITextView (SNTextView)

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.placeHolderLabel.text = self.sn_placeholder;
}

#pragma mark -- 设置textView的 Placeholder

- (void)setSn_placeholder:(NSString *)sn_placeholder {
    self.placeHolderLabel.text = sn_placeholder;
    objc_setAssociatedObject(self, @selector(sn_placeholder), sn_placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sn_placeholder {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPlaceHolderLabel:(UILabel *)placeHolderLabel{
    objc_setAssociatedObject(self, @selector(placeHolderLabel), placeHolderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel *)placeHolderLabel {
    UILabel * label = objc_getAssociatedObject(self, _cmd);
    if (label == nil) {
        label = [[UILabel alloc] init];
		//label.autoresizingMask = (UIViewAutoresizingFlexibleHeight);
		label.numberOfLines = 0;
		label.font = self.font;
		label.textAlignment = self.textAlignment;
		label.backgroundColor = [UIColor clearColor];
		label.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
		//[label sizeToFit];
		[self insertSubview:label atIndex:0];
		
		[label mas_updateConstraints:^(MASConstraintMaker *make) {
			make.top.mas_offset(7);
			make.left.mas_offset(5);
			make.width.equalTo(self).offset(-11);
			
			[self setNeedsLayout];
			[self layoutIfNeeded];
		}];
		
		[RACObserve(self, textAlignment) subscribeNext:^(id  _Nullable x) {
			label.textAlignment = self.textAlignment;
		}];
		
		//    遍历私有属性
		BOOL isSettingPlaceholder = NO;
		unsigned int count;
		Ivar *ivars =  class_copyIvarList([UIAlertAction class], &count);
		for (int i = 0; i < count; i++) {
			Ivar ivar = ivars[i];
			const char * cName =  ivar_getName(ivar);
			NSString *ocName = [NSString stringWithUTF8String:cName];
			if ([ocName isEqualToString:@"_placeholderLabel"]) {
				isSettingPlaceholder = YES;
				break;
			}
		}
		free(ivars);
		
		if (isSettingPlaceholder) {
			[self setValue:label forKey:@"_placeholderLabel"];
		} else {
			[RACObserve(self, text) subscribeNext:^(id  _Nullable x) {
				if (self.text.length > 0) {
					label.hidden = YES;
				} else {
					label.hidden = NO;
				}
			}];
			[self.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
				
				if (x.length > 0) {
					label.hidden = YES;
				} else {
					label.hidden = NO;
					
				}
			}];
		}
		
		objc_setAssociatedObject(self, _cmd, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
    return label;
}

#pragma mark -- 设置文本输入框内容变化的回调
- (void)setValueChnageBlock:(SNValueChnageBlock)valueChnageBlock {
     objc_setAssociatedObject(self, @selector(valueChnageBlock), valueChnageBlock, OBJC_ASSOCIATION_COPY);
}
- (SNValueChnageBlock)valueChnageBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)sn_valueChangeBlock:(void(^)(NSString * value))block {
    self.delegate = self;
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    if (block) {
        self.valueChnageBlock = block;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        if ([object isKindOfClass:[UITextView class]]) {
            UITextView * textView = (UITextView *)object;
            if (self.valueChnageBlock) {
                self.valueChnageBlock(textView.text);
            }
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.valueChnageBlock) {
        self.valueChnageBlock(textView.text);
    }
}

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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	//     不让输入表情
	if ([textView isFirstResponder]) {
		if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
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
