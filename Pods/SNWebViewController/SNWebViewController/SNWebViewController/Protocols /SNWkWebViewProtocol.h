//
//  SNWkWebViewProtocol.h
//  SNWebViewController
//
//  Created by snlo on 2018/5/16.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SNConcreteProtocol.h>

@protocol SNWkWebViewProtocol <NSObject>

@required

/**
 设置NSURLProtocol、addScriptMessageHandler
 */
- (void)setURLProtocolClass:(Class)class scriptMessageHandlerNames:(NSArray <NSString *> *)names;

/**
 处理post请求
 @param body 键必须包含‘url’的字典
 */
- (void)handlePostJsByNative:(id)body;

@end
