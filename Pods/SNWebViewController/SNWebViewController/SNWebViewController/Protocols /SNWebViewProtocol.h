//
//  SNWebViewProtocol.h
//  SNWebViewController
//
//  Created by snlo on 2018/5/16.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SNConcreteProtocol.h>

@protocol SNWebViewProtocol <NSObject>

@required

/**
 设置NSURLProtocol
 */
- (void)setURLProtocolClass:(Class)class;

@end
