//
//  NSBundle+SNModuleKit.m
//  SNModuleKit
//
//  Created by snlo on 2018/5/10.
//  Copyright © 2018年 AiteCube. All rights reserved.
//

#import "NSBundle+SNModuleKit.h"

@implementation NSBundle (SNModuleKit)

+ (NSString *)sn_localizedStringForKey:(NSString *)key {
    
    static NSBundle *bundle = nil;
    
    if (bundle == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        } else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans";
            } else {
                language = @"zh-Hant";
            }
        } else {
            language = @"en";
        }
        
        NSBundle * bundleKit = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"SNModuleKit" ofType:@"bundle"]];
        bundle = [NSBundle bundleWithPath:[bundleKit pathForResource:language ofType:@"lproj"]];
    }
    
    NSString * value = [bundle localizedStringForKey:key value:nil table:@"SNModuleKitStrings"];
    
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:@"SNModuleKitStrings"];
}

@end
