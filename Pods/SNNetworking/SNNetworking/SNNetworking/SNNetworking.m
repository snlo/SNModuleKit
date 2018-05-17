//
//  SNNetworking.m
//  SNNetworking
//
//  Created by snlo on 16/6/30.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import "SNNetworking.h"

#import "SNNetworkTool.h"

@interface SNNetworking ()

//loading
@property (nonatomic, assign) CGFloat loadingLevel;
@property (nonatomic, assign) CGFloat loadingLeveling;

//update
@property (nonatomic, assign) CGFloat updateLevel;
@property (nonatomic) id updatedObject;

@end

@implementation SNNetworking

static id instanse;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
	static dispatch_once_t onesToken;
	dispatch_once(&onesToken, ^{
		instanse = [super allocWithZone:zone];
	});
	return instanse;
}
+ (instancetype)sharedManager {
	static dispatch_once_t onestoken;
	dispatch_once(&onestoken, ^{
		instanse = [[self alloc] init];
	});
	return instanse;
}
- (id)copyWithZone:(NSZone *)zone {
	return instanse;
};

#pragma mark -- public methods

#pragma mark -- network methods
//GET
+ (void)getWithUrl:(NSString *)url parameters:(id)parameters progress:(void(^)(double percentage))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [SNNetworking netWorkingStart];
    
    [[SNNetworking sharedManager].manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

        if (progress) progress(downloadProgress.fractionCompleted);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [SNNetworking netWorkingSuccess];
        
        if (success)  {
            success(responseObject);
        } else {
            [SNNetworking loadingRecovery];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"get error --> %@",[SNNetworkTransformer valueFromError:error]);
        NSLog(@"%@",error.description);
        [SNNetworking netWorkingFailure];
        
        if (failure) {
            failure(error);
        } else {
            [SNNetworking loadingRecovery];
        }

    }];
    
}

//POST
+ (void)postWithUrl:(NSString *)url parameters:(id)parameters progress:(void(^)(double percentage))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [SNNetworking netWorkingStart];
    
    [[SNNetworking sharedManager].manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SNNetworking netWorkingSuccess];
        
        if (success)  {
            success(responseObject);
        } else {
            [SNNetworking loadingRecovery];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"post error --> %@",[SNNetworkTransformer valueFromError:error]);
        NSLog(@"%@",error.description);
        [SNNetworking netWorkingFailure];
        
        if (failure) {
            failure(error);
        } else {
            [SNNetworking loadingRecovery];
        }

    }];
}

//upload
+ (void)uploadWithUrl:(NSString *)url parameters:(id)parameters dataArray:(NSArray <NSData *> *)dataArray name:(NSString *)name fileSuffixName:(NSString *)fileSuffixName type:(NSString *)type progress:(void(^)(double percentage))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [SNNetworking netWorkingStart];
    [[SNNetworking sharedManager].manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSData * data in dataArray) {

            NSString * names = [[SNTool fetchCurrentTimeFormat:@"yyyyMMddHHmmssSSS" fromDate:[NSDate date]] md5String];
            NSString * fileName = [NSString stringWithFormat:@"%@.%@",names,fileSuffixName];
            
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SNNetworking netWorkingSuccess];
        
        if (success)  {
            success(responseObject);
        } else {
            [SNNetworking loadingRecovery];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"post error --> %@",[SNNetworkTransformer valueFromError:error]);
        
        [SNNetworking netWorkingFailure];
        
        if (failure) {
            failure(error);
        } else {
            [SNNetworking loadingRecovery];
        }

    }];
}

//download
+ (void)downloadWithUrl:(NSString *)url fileDownPath:(NSString *)fileDownPath progress:(void(^)(double percentage))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [SNNetworking netWorkingStart];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    [[[SNNetworking sharedManager].manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:[fileDownPath stringByAppendingPathComponent:response.suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            
            NSLog(@"downloaded response --> %@",response);
            
            [SNNetworking netWorkingSuccess];
            
            if (success)  {
                success(response);
            } else {
                [SNNetworking loadingRecovery];
            }

        } else {
            
            NSLog(@"downloaded error --> %@",[SNNetworkTransformer valueFromError:error]);
            
            [SNNetworking netWorkingFailure];
            
            if (failure) {
                failure(error);
            } else {
                [SNNetworking loadingRecovery];
            }
            
        }
    }] resume];
    
}

#pragma mark -- network state
//cancel request
+ (void)cancelRequest
{
    [[SNNetworking sharedManager].manager.operationQueue cancelAllOperations];
}

//开始监听网络，建议延时开始；
+ (void)startNetMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)dealloc {
    if (_manager) {
        [_manager invalidateSessionCancelingTasks:YES];
    }
}

//监听结果
+ (void)netMonitoringWithResultBlock:(void(^)(AFNetworkReachabilityStatus status,NSString * statusValue))resultBlock
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString * statusValue = [NSString string];
        switch(status) {
            case AFNetworkReachabilityStatusNotReachable:{
                statusValue = @"无网络";
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                statusValue = @"WiFi网络";
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                statusValue = @"无线网络";
                break;
            }
            default:
                statusValue = @"无网络";
                break;
        }
        if (resultBlock) resultBlock(status, statusValue);
    }];
    
}

//结束监听
+ (void)stopNetMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

#pragma mark -- lodaing
+ (void)loadingInvalid {
    [SNNetworking sharedManager].loadingLeveling = 1500;
}
+ (void)loadingRecovery {
    [SNNetworking sharedManager].loadingLeveling = 500;
}

+ (void)netWorkingStart {
    
    [SNNetworking sharedManager].loadingLevel += 1;
    if ([SNNetworking sharedManager].loadingLeveling < 1001) {
        [SNTool showLoading:nil];
    }
}
+ (void)netWorkingSuccess {
    [SNNetworking sharedManager].loadingLevel -= 1;
    if ([SNNetworking sharedManager].loadingLeveling < 1001) {
        if ([SNNetworking sharedManager].loadingLevel <= 0) {
            [SNTool dismisLoding];
            [SNNetworking sharedManager].loadingLevel = 0;
        }
    }
}
+ (void)netWorkingFailure {
    [SNNetworking sharedManager].loadingLevel -= 1;
    if ([SNNetworking sharedManager].loadingLeveling < 1001) {
        if ([SNNetworking sharedManager].loadingLevel <= 0) {
            [SNTool dismisLoding];
            [SNNetworking sharedManager].loadingLevel = 0;
        }
    }
}

#pragma mark -- update
+ (void)updataSource:(void(^)(id object))block {
    if ([SNNetworking sharedManager].updateLevel > 0) {
        if (block) {
            block([SNNetworking sharedManager].updatedObject);
            [SNNetworking sharedManager].updateLevel = 0;
        }
    }
}
+ (void)willUpdataSource:(id(^)(void))block {
    if ([SNNetworking sharedManager].updateLevel < 0) {
        [SNNetworking sharedManager].updateLevel = 0;
    }
    [SNNetworking sharedManager].updateLevel += 1;
    if (block) {
        [SNNetworking sharedManager].updatedObject = block();
    }
}

#pragma mark -- getter

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    _manager.requestSerializer.timeoutInterval = 30.f;//sn_超时
    
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json"
                                                          ,@"text/plain"
                                                          ,@"text/json"
                                                          ,@"text/javascript"
                                                          ,@"text/html"
                                                          ,@"image/png"
                                                          ,@"image/jpeg"
                                                          ,@"application/rtf"
                                                          ,@"image/gif"
                                                          ,@"application/zip"
                                                          ,@"audio/x-wav"
                                                          ,@"image/tiff"
                                                          ,@"application/x-shockwave-flash"
                                                          ,@"application/vnd.ms-powerpoint"
                                                          ,@"video/mpeg"
                                                          ,@"video/quicktime"
                                                          ,@"application/x-javascript"
                                                          ,@"application/x-gzip"
                                                          ,@"application/x-gtar"
                                                          ,@"application/msword"
                                                          ,@"text/css"
                                                          ,@"video/x-msvideo"
                                                          ,@"text/xml"
                                                          , nil];
   
    return _manager;
}

- (NSString *)basrUrl {
    if (!_basrUrl) {
        _basrUrl = @"http://ac.aitelife.com";
    } return _basrUrl;
}

@end
