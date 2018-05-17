//
//  UILabel+SNLabel.m
//  snlo
//
//  Created by snlo on 2017/11/22.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "UILabel+SNLabel.h"
#import <objc/runtime.h>

@implementation UILabel (SNLabel)

- (void)setSn_isAdjustsFontSizeToFitWidth:(BOOL)sn_isAdjustsFontSizeToFitWidth {
    self.adjustsFontSizeToFitWidth = YES;
    self.minimumScaleFactor = 5 / self.font.pointSize;
    
    NSNumber * number = [NSNumber numberWithBool:sn_isAdjustsFontSizeToFitWidth];
    objc_setAssociatedObject(self, @selector(sn_isAdjustsFontSizeToFitWidth), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)sn_isAdjustsFontSizeToFitWidth {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}

@end
