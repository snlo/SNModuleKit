//
//  SNPopupView.m
//  AiteCube
//
//  Created by snlo on 2017/12/7.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import "SNPopupView.h"

#import "SNPopupTool.h"

typedef void(^ReceiveDismissBlock)(void);

@interface SNPopupView () <UIGestureRecognizerDelegate>

@property (nonatomic, copy) ReceiveDismissBlock receiveDismissBlock;

@end

@implementation SNPopupView

- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark -- <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //防止自视图触发点击回退事件
    if ([touch.view isDescendantOfView:self.subviews.firstObject]) {
        return NO;
    }
    return YES;
}

#pragma mark -- event response
- (void)touchesBlank:(UITapGestureRecognizer *)sender {
    if (!self.isBlankTouchInVisible) {
        [self dismissFromSuperView:nil];
    }
}

#pragma mark -- public methods
- (void)dismissFromSuperView:(void(^)(void))block {
    //退场动画
    [self.subviews.firstObject.layer addAnimation:[self fadeOutAnimation] forKey:nil];
    
    self.alpha = 1;
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [SNPopupTool topViewController].snPopup_isAbleEdgeGesture = YES;
        if (self.receiveDismissBlock) {
            self.receiveDismissBlock();
        } else {
            if (block) {
                block();
            }
        }
    }];
}

- (void)showInSuperView:(void(^)(void))block {
    self.frame = CGRectMake(0, 0, SNPOPUP_SCREEN_WIDTH, SNPOPUP_SCREEN_HEIGHT);
    
    //加载单击回退手势
    UITapGestureRecognizer * touchBlankGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBlank:)];
    touchBlankGesture.numberOfTapsRequired = 1;
    touchBlankGesture.delegate = self;
    [self addGestureRecognizer:touchBlankGesture];
    
    //入场动画
    [self.subviews.firstObject.layer addAnimation:[self zoomOutAnimation] forKey:nil];
    
    self.alpha = 0;
    [[SNPopupTool getNextViewController].view endEditing:YES];
    [[SNPopupTool getNextViewController].view addSubview:self];
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [SNPopupTool topViewController].snPopup_isAbleEdgeGesture = NO;
        if (block) {
            block();
        }
    }];
}

- (void)receiveDismissBlock:(void(^)(void))block {
    if (block) {
        self.receiveDismissBlock = block;
    }
}
#pragma mark -- private methods

- (CABasicAnimation *)zoomOutAnimation {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.15;
    animation.fromValue = @1.2;
    animation.toValue = @1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

- (CABasicAnimation *)fadeOutAnimation {
	CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	animation.duration = 3.0;
	animation.toValue = @0;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	//    animation.delegate = self;
	return animation;
}

@end
