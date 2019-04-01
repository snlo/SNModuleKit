//
//  SNMediator.m
//  AiteCube
//
//  Created by snlo on 2017/9/22.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import "SNMediator.h"
#import <objc/runtime.h>

#import "SNMediatorTool.h"

@interface SNMediator ()

@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

@end

singletonImplemention(SNMediator)

#pragma mark - public methods

- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(id responseObject))completion {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	NSString *urlString = [url query];
	for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
		NSArray *elts = [param componentsSeparatedByString:@"="];
		if([elts count] < 2) continue;
		[params setObject:[elts lastObject] forKey:[elts firstObject]];
	}
	
	NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
	if ([actionName hasPrefix:@"native"]) { //安全逻辑
		return @(NO);
	}
	
    /*
     路由逻辑:target-action
     */
	id responseObject = [self performTarget:url.host action:actionName params:params shouldCacheTarget:NO];
	if (completion) {
		if (responseObject) {
			completion(responseObject);
		} else {
			completion(nil);
		}
	}
	return responseObject;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget {
	NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
	NSString *actionString = [NSString stringWithFormat:@"Action_%@:", actionName];
	Class targetClass;
	
	NSObject *target = self.cachedTarget[targetClassString];
	if (target == nil) {
		targetClass = NSClassFromString(targetClassString);
		target = [[targetClass alloc] init];
	}
	
	SEL action = NSSelectorFromString(actionString);
	
	if (target == nil) {
        //异常处理
		return nil;
	}
	
	if (shouldCacheTarget) {
		self.cachedTarget[targetClassString] = target;
	}
	
	if ([target respondsToSelector:action]) {
		return [self safePerformAction:action target:target params:params];
	} else {
		// target兼容Swift对象
		actionString = [NSString stringWithFormat:@"Action_%@WithParams:", actionName];
		action = NSSelectorFromString(actionString);
		if ([target respondsToSelector:action]) {
			return [self safePerformAction:action target:target params:params];
		} else {
			SEL action = NSSelectorFromString(@"notFound:");
			if ([target respondsToSelector:action]) {
				return [self safePerformAction:action target:target params:params];
			} else {
				[self.cachedTarget removeObjectForKey:targetClassString];
				return nil;
			}
		}
	}
}

- (void)releaseCachedTargetWithTargetName:(NSString *)targetName {
	NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
	[self.cachedTarget removeObjectForKey:targetClassString];
}

#pragma mark - private methods
- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params {
	NSMethodSignature * methodSig = [target methodSignatureForSelector:action];
	if(methodSig == nil) {
		return nil;
	}
	const char * retType = [methodSig methodReturnType];
	
	if (strcmp(retType, @encode(void)) == 0) {
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
		[invocation setArgument:&params atIndex:2];
		[invocation setSelector:action];
		[invocation setTarget:target];
		[invocation invoke];
		return nil;
	}
	if (strcmp(retType, @encode(NSInteger)) == 0) {
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
		[invocation setArgument:&params atIndex:2];
		[invocation setSelector:action];
		[invocation setTarget:target];
		[invocation invoke];
		NSInteger result = 0;
		[invocation getReturnValue:&result];
		return @(result);
	}
	if (strcmp(retType, @encode(BOOL)) == 0) {
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
		[invocation setArgument:&params atIndex:2];
		[invocation setSelector:action];
		[invocation setTarget:target];
		[invocation invoke];
		BOOL result = 0;
		[invocation getReturnValue:&result];
		return @(result);
	}
	if (strcmp(retType, @encode(CGFloat)) == 0) {
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
		[invocation setArgument:&params atIndex:2];
		[invocation setSelector:action];
		[invocation setTarget:target];
		[invocation invoke];
		CGFloat result = 0;
		[invocation getReturnValue:&result];
		return @(result);
	}
	if (strcmp(retType, @encode(NSUInteger)) == 0) {
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
		[invocation setArgument:&params atIndex:2];
		[invocation setSelector:action];
		[invocation setTarget:target];
		[invocation invoke];
		NSUInteger result = 0;
		[invocation getReturnValue:&result];
		return @(result);
	}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

#pragma mark - getters and setters
- (NSMutableDictionary *)cachedTarget {
	if (_cachedTarget == nil) {
		_cachedTarget = [[NSMutableDictionary alloc] init];
	}
	return _cachedTarget;
}

#pragma mark -- 扩展

+ (id)module:(NSString *)module url:(NSURL *)url action:(NSString *)action params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget {
    
    if (url) {
        return [[SNMediator sharedManager] performActionWithUrl:url completion:nil];
    } else {
        return [[SNMediator sharedManager] performTarget:module action:action params:params shouldCacheTarget:shouldCacheTarget];
    }
    return nil;
}

+ (id)mediateModule:(NSString *)module url:(NSURL *)url action:(NSString *)action params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget __attribute__((warn_unused_result)) {
	
	id response = nil;
	
	if (url) {
		response = [SNMediator module:nil url:url action:nil params:nil shouldCacheTarget:shouldCacheTarget];
	} else {
		response = [SNMediator module:module url:nil action:action params:params shouldCacheTarget:shouldCacheTarget];
	}
	
	if ([response isKindOfClass:[UIViewController class]]) {
		return response;
	} else if ([response isKindOfClass:[UIView class]]) {
		return response;
	} else if ([response isKindOfClass:[NSDictionary class]]) {
		return response;
	} else if ([response isKindOfClass:[NSMutableDictionary class]]) {
		return response;
    } else if ([response isKindOfClass:[NSArray class]]) {
        return response;
    } else if ([response isKindOfClass:[NSMutableArray class]]) {
        return response;
    } else if ([response isKindOfClass:[NSNumber class]]) {
        return response;
    } else if ([response isKindOfClass:[NSSet class]]) {
        return response;
    } else if ([response isKindOfClass:[NSMutableSet class]]) {
        return response;
    } else if ([response isKindOfClass:[NSString class]]) {
        return response;
    } else {
		return [SNMediator mediatErrorViewController];
	}
	
	return nil;
}

+ (id)mediateModule:(NSString *)module url:(NSURL *)url signal:(NSString *)signal params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget {
	
	id response = nil;
	
	if (url) {
		response = [SNMediator module:nil url:url action:nil params:nil shouldCacheTarget:shouldCacheTarget];
	} else {
		response = [SNMediator module:module url:nil action:signal params:params shouldCacheTarget:shouldCacheTarget];
	}
	if ([response isKindOfClass:NSClassFromString(@"RACCommand")]) {
		return response;
	} else if ([response isKindOfClass:NSClassFromString(@"RACSignal")]) {
		return response;
	} else if ([response isKindOfClass:NSClassFromString(@"RACSubject")]) {
		return response;
	} else {
		[SNMediator mediatErrorViewController];
		
		return nil;
	}
}

+ (UIViewController *)mediatErrorViewController {
	__block UIViewController * errorViewController = [UIViewController new];
	errorViewController.view.backgroundColor = [UIColor whiteColor];
	[[SNTool topViewController] presentViewController:errorViewController animated:YES completion:^{
		[SNTool showAlertStyle:UIAlertControllerStyleAlert title:@"提示" msg:@"敬请期待相关功能，感谢您的支持" chooseBlock:^(NSInteger actionIndx) {
			[errorViewController dismissViewControllerAnimated:YES completion:^{
				
			}];
		} actionsStatement:@"确认", nil];
	}];
	return errorViewController;
}


@end


