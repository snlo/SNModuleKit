//
//  SNNetworkCachePool.m
//  AFNetworkingTest
//
//  Created by snlo on 16/7/1.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import "SNNetworkCachePool.h"

#import "SNNetworkTransformer.h"
#import "SNFileNetworkManager.h"

@interface SNNetworkCachePool ()

@property (nonatomic,strong) NSMutableDictionary * operationCachePool;    //初始化操作缓存池

@property (nonatomic,copy  ) NSString            * cacheName;               //缓存名

@property (nonatomic,assign) BOOL                isCanceled;             //是否取消网络请求

@end

@implementation SNNetworkCachePool

//init
// 初始化操作缓存池
- (NSMutableDictionary *)operationCachePool {
    if (!_operationCachePool) {
        _operationCachePool = [[NSMutableDictionary alloc] init];
    }
    return _operationCachePool;
}
//before net
- (NSString *)urlBeforeRequestFromUrl:(NSString *)url baseURL:(NSString *)baseURL
{
    url = [NSString stringWithFormat:@"%@%@",baseURL,url];
    self.cacheName = url;
    if ([self.operationCachePool objectForKey:self.cacheName]) {
        NSLog(@"正在请求");
    }
    return url;
}

//net succesed
- (void)requestSuccesedWithUrl:(NSString *)url responseObject:(id)responseObject requestSuccess:(void(^)(id responseObject))requestSuccess
{
    
}

//net failured
- (void)requestFailuredWithError:(NSError *)error cacheSuccess:(void(^)(id responseObject))cacheSuccess cacheFailure:(void(^)(NSError *error))cacheFailure
{
    
}

//net brokened
- (void)requestBrokened
{
    
}


@end
