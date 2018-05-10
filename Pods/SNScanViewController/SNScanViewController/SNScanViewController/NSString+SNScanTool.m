//
//  NSString+SNScanTool.m
//  SNScanViewController
//
//  Created by snlo on 2018/5/11.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "NSString+SNScanTool.h"

@implementation NSString (SNScanTool)

+ (NSString *)SNScanTool_localizedStringForKey:(NSString *)key {
	NSString *language = [NSLocale preferredLanguages].firstObject;
	if ([language hasPrefix:@"en"]) {
		language = @"en";
	} else if ([language hasPrefix:@"zh"]) {
		if ([language rangeOfString:@"Hans"].location != NSNotFound) {
			language = @"zh-Hans";
		}
	} else {
		language = @"en";
	}
	
	NSBundle * bundleKit = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"SNScanViewController" ofType:@"bundle"]];
	NSBundle * bundles = [NSBundle bundleWithPath:[bundleKit pathForResource:language ofType:@"lproj"]];
	
	NSString * value = [bundles localizedStringForKey:key value:nil table:@"SNScanViewControllerStrings"];
	
	return [[NSBundle mainBundle] localizedStringForKey:key value:value table:@"SNScanViewControllerStrings"];
}

@end
