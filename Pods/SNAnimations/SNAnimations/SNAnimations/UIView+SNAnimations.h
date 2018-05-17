//
//  UIView+SNAnimations.h
//  SNAnimations
//
//  Created by snlo on 2018/5/12.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_3
@interface UIView (SNAnimations) <CAAnimationDelegate>
#else
@interface UIView (SNAnimations)
#endif

- (void)sn_addAnimation:(CAAnimation *)animation didStartBlock:(void(^)(CAAnimation *Animation))didStartBlock didStopBlock:(void(^)(CAAnimation *Animation))didStopBlock beforeStopblock:(void(^)(CAAnimation *Animation))beforeStopblock;

@end
