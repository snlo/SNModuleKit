//
//  UIImageView+SNImageView.m
//  AiteCube
//
//  Created by snlo on 2017/10/23.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import "UIImageView+SNImageView.h"
#import <objc/runtime.h>

@implementation UIImageView (SNImageView)

- (void)setSn_radius:(CGFloat)sn_radius {
    self.layer.cornerRadius = sn_radius;
    
//    self.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.layer.borderWidth = 2;
    self.layer.masksToBounds = YES;
    
    
    NSNumber * number = [NSNumber numberWithFloat:sn_radius];
    objc_setAssociatedObject(self, @selector(sn_radius), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)sn_radius {
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number floatValue];
}

//- (void)setSnSVGname:(NSString *)snSVGname {
//    self.image = [SVGKImage imageNamed:snSVGname].UIImage;
//    objc_setAssociatedObject(self, @selector(snSVGname), snSVGname, OBJC_ASSOCIATION_COPY);
//}
//- (NSString *)snSVGname {
//    return objc_getAssociatedObject(self, _cmd);
//}

@end
