//
//  SNScanTool.m
//  SNScanViewController
//
//  Created by snlo on 2018/5/8.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNScanTool.h"

#import <objc/runtime.h>

singletonImplemention(SNScanTool)

+ (NSString *)localizedString:(NSString *)key {
    return [NSString sn_localizedStringForKey:key table:@"SNScanViewControllerStrings" bundle:@"SNScanViewController"];
}

+ (void)scanAddMaskToView:(UIView *)view withRoundedRect:(CGRect)roundedRect cornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
    
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:cornerRadius] bezierPathByReversingPath]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    
    [view.layer setMask:shapeLayer];
}

@end
