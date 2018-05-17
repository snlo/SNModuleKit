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

@end
