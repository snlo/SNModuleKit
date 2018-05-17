//
//  SNMediatorProtocol.h
//  SNMediator
//
//  Created by snlo on 2018/5/7.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SNMediatorProtocol <NSObject>

/**
 调度辅助函数，会包含一些特殊处理
 
 @param module 本地组件名
 @param url 远程调度链接
 @param action 事件名
 @param params 附带参数
 @param shouldCacheTarget 是否缓存本地组件名
 @return 可能是'UIViewController'、‘UIView’、‘NSDictionary’、‘NSMutableDictionary’
 */
+ (id)mediateModule:(NSString *)module url:(NSURL *)url acrion:(NSString *)action params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

/**
 调度辅助函数，会包含一些特殊处理
 
 @param module 本地组件名
 @param url 远程调度链接
 @param signal signal:信号名
 @param params 附带参数
 @param shouldCacheTarget 是否缓存本地组件名
 @return 返回信号‘RACSignal’、‘RACCommand’、‘RACSubject’
 */
+ (id)mediateModule:(NSString *)module url:(NSURL *)url signal:(NSString *)signal params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget __attribute__((warn_unused_result));

@end
