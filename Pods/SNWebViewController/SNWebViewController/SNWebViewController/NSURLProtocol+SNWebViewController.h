//
//  NSURLProtocol+SNWebViewController.h
//  NSURLProtocol+SNWebViewController
//
//  Created by snlo on 2016/10/11.
//  Copyright © 2016年 Yeatse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLProtocol (SNWebViewController)

+ (void)sn_registerScheme:(NSString*)scheme;

+ (void)sn_unregisterScheme:(NSString*)scheme;

@end
