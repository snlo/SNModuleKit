//
//  NSBundle+SNModuleKit.h
//  SNModuleKit
//
//  Created by snlo on 2018/5/10.
//  Copyright © 2018年 AiteCube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (SNModuleKit)

/**
 本地国际化支持
 */
+ (NSString *)sn_localizedStringForKey:(NSString *)key;

@end
