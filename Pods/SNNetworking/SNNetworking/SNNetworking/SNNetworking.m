//
//  SNNetworking.m
//  SNNetworking
//
//  Created by snlo on 16/6/30.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import "SNNetworking.h"

#import "SNNetworkTool.h"

typedef void(^BrokenSourceBlock)(void);
typedef void(^TimeOutSourceBlock)(void);
typedef void(^UpdataSourceBlock)(void);

@interface SNNetworking ()

@property (nonatomic, copy) BrokenSourceBlock brokenSourceBlock;
@property (nonatomic, copy) TimeOutSourceBlock timeOutSourceBlock;
@property (nonatomic, copy) UpdataSourceBlock updataSourceBlock;

@end

@implementation SNNetworking

static id instanse;

- (void)dealloc {
    if (_manager) {
        [_manager invalidateSessionCancelingTasks:YES];
    }
}


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



#pragma mark -- network methods
//GET
+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url
                          parameters:(id)parameters
                            progress:(void(^)(double percentage))progress
                             success:(void(^)(id responseObject))success
                             failure:(void(^)(NSError *error))failure {
    
    NSURLSessionDataTask * task = [[SNNetworking sharedManager].manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

        if (progress) progress(downloadProgress.fractionCompleted);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [SNNetworking handleNetWorkingSuccessTask:task];
        
        if (success)  {
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [SNNetworking handleNetWorkingFailureError:error task:task url:url parameters:parameters];
        
        if (failure) {
            failure(error);
        }
    }];
    [SNNetworking handleNetWorkingStartTask:task];
    return task;
}
//POST
+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url
                           parameters:(id)parameters
                             progress:(void(^)(double percentage))progress
                              success:(void(^)(id responseObject))success
                              failure:(void(^)(NSError *error))failure {
    
    NSURLSessionDataTask * task = [[SNNetworking sharedManager].manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SNNetworking handleNetWorkingSuccessTask:task];
        
        if (success)  {
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SNNetworking handleNetWorkingFailureError:error task:task url:url parameters:parameters];
        
        if (failure) {
            failure(error);
        }
    }];
    [SNNetworking handleNetWorkingStartTask:task];
    return task;
}
//POST AND GET
+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url
                            getParams:(id)getParams
                           parameters:(id)parameters
                             progress:(void(^)(double percentage))progress
                              success:(void(^)(id responseObject))success
                              failure:(void(^)(NSError *error))failure {
    
    __block NSString * urls = url;
    
    if ([getParams isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:getParams];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            urls = [urls stringByAppendingFormat:@"?%@=%@",key,obj];
        }];
    }
    
    NSURLSessionDataTask * task = [[SNNetworking sharedManager].manager POST:urls parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SNNetworking handleNetWorkingSuccessTask:task];
        
        if (success)  {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SNNetworking handleNetWorkingFailureError:error task:task url:url parameters:parameters];
        
        if (failure) {
            failure(error);
        }
    }];
    [SNNetworking handleNetWorkingStartTask:task];
    return task;
}
//upload
+ (NSURLSessionDataTask *)uploadWithUrl:(NSString *)url
                             parameters:(id)parameters
                              dataArray:(NSArray <NSData *> *)dataArray
                                   name:(NSString *)name
                         fileSuffixName:(NSString *)fileSuffixName
                                   type:(NSString *)type
                               progress:(void(^)(double percentage))progress
                                success:(void(^)(id responseObject))success
                                failure:(void(^)(NSError *error))failure {
    
    
    NSURLSessionDataTask * task = [[SNNetworking sharedManager].manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSData * data in dataArray) {

            NSString * names = [[SNTool fetchCurrentTimeFormat:@"yyyyMMddHHmmssSSS" fromDate:[NSDate date]] md5String];
            NSString * fileName = [NSString stringWithFormat:@"%@.%@",names,fileSuffixName];
            
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SNNetworking handleNetWorkingSuccessTask:task];
        
        if (success)  {
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SNNetworking handleNetWorkingFailureError:error task:task url:url parameters:parameters];
        
        if (failure) {
            failure(error);
        }
    }];
    [SNNetworking handleNetWorkingStartTask:task];
    return task;
}
//download
+ (NSURLSessionDownloadTask *)downloadWithUrl:(NSString *)url
                                 fileDownPath:(NSString *)fileDownPath
                                     progress:(void(^)(double percentage))progress
                                      success:(void(^)(id responseObject))success
                                      failure:(void(^)(NSError *error))failure {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    __block NSURLSessionDownloadTask * task = nil;
    task = [[SNNetworking sharedManager].manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:[fileDownPath stringByAppendingPathComponent:response.suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            
            [SNNetworking handleNetWorkingSuccessTask:task];
            
            if (success)  {
                success(response);
            }

        } else {
            
            [SNNetworking handleNetWorkingFailureError:error task:task url:url parameters:response];
            
            if (failure) {
                failure(error);
            } 
        }
    }];
    [task resume];
    [SNNetworking handleNetWorkingStartTask:task];
    return task;
}

#pragma mark -- handle
+ (void)handleNetWorkingStartTask:(NSURLSessionTask *)task {
    
    [SNNetworking startNetMonitoring];
    [SNNetworking netMonitoringWithResultBlock:^(AFNetworkReachabilityStatus status, NSString *statusValue) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                
            } break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                
            } break;
            default: {
                if ([SNNetworking sharedManager].brokenSourceBlock) {
                    [SNNetworking sharedManager].brokenSourceBlock();
                } else {
                    [SNTool showHUDalertMsg:@"网络连接似乎出了点问题" completion:nil];
                }
                [SNNetworking cancelRequest];
            } break;
        }
    }];
    
    [[SNNetworking sharedManager].networkingCountedSet addObject:task];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([SNNetworking sharedManager].networkingCountedSet.count > 0) {
            [SNTool showLoading:nil];
        }
    });
}
+ (void)handleNetWorkingSuccessTask:(NSURLSessionTask *)task {
    
    [[SNNetworking sharedManager].networkingCountedSet removeObject:task];
    
    if ([SNNetworking sharedManager].networkingCountedSet.count < 1) {
        [SNTool dismissLoading];
    }
}
+ (void)handleNetWorkingFailureError:(NSError *)error task:(NSURLSessionTask *)task url:(NSString *)url parameters:(id)parameters  {
    
    [[SNNetworking sharedManager].networkingCountedSet removeObject:task];
    
    if ([SNNetworking sharedManager].networkingCountedSet.count < 1) {
        [SNTool dismissLoading];
    }
    [task cancel];
    if (error.code == -1001) {
        if ([SNNetworking sharedManager].timeOutSourceBlock) {
            [SNNetworking sharedManager].timeOutSourceBlock();
        } else {
            [SNTool showHUDalertMsg:@"网络可能有点缓慢" completion:nil];
        }
    }
    if (error.code == -1009) {
        if ([SNNetworking sharedManager].brokenSourceBlock) {
            [SNNetworking sharedManager].brokenSourceBlock();
        } else {
            [SNTool showHUDalertMsg:@"网络连接似乎出了点问题" completion:nil];
        }
    }
    
    NSLog(@"%@",error.description);
    NSLog(@" - url - %@",url);
    NSLog(@" - parameters - %@",parameters);
}

+ (void)donotShowLoadingViewAtTask:(NSURLSessionTask *)task {
    [[SNNetworking sharedManager].networkingCountedSet removeObject:task];
}

#pragma mark -- network Monitoring
+ (void)cancelRequest {
    [[SNNetworking sharedManager].networkingCountedSet removeAllObjects];
    [[SNNetworking sharedManager].manager.operationQueue cancelAllOperations];
}

+ (void)startNetMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)netMonitoringWithResultBlock:(void(^)(AFNetworkReachabilityStatus status,NSString * statusValue))resultBlock {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
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
    [manager startMonitoring];
}

//结束监听
+ (void)stopNetMonitoring {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

#pragma mark -- update

+ (BOOL)updateSourceFrom:(id)fromUpdateMark {
    if ([[SNNetworking sharedManager].networkingUpateCountedSet containsObject:fromUpdateMark]) {
        [[SNNetworking sharedManager].networkingUpateCountedSet removeObject:fromUpdateMark];
        return YES;
    } else {
        return NO;
    }
}

+ (void)willUpdataSourceSetMark:(id)updateMark {
    [[SNNetworking sharedManager].networkingUpateCountedSet addObject:updateMark];
}
+ (void)brokenSource:(void (^)(void))block {
    if (block) {
        [SNNetworking sharedManager].brokenSourceBlock = block;
    }
}
+ (void)timeOutSource:(void (^)(void))block {
    if (block) {
        [SNNetworking sharedManager].timeOutSourceBlock = block;
    }
}

#pragma mark -- getter
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _manager.securityPolicy.allowInvalidCertificates = YES;
        _manager.securityPolicy.validatesDomainName = NO;
        
        _manager.requestSerializer.timeoutInterval = 30.f;//sn_超时
    }
    
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

@synthesize baseUrl = _baseUrl;
- (void)setBaseUrl:(NSString *)baseUrl {
    _baseUrl = baseUrl;
    if ([_baseUrl hasPrefix:@"https://"]) {
        
    }
}
- (NSString *)baseUrl {
    if (!_baseUrl) {
        _baseUrl = @"setting in AppDelegate.m";
    } return _baseUrl;
}

- (NSCountedSet *)networkingCountedSet {
    if (!_networkingCountedSet) {
        _networkingCountedSet = [[NSCountedSet alloc] init];
    } return _networkingCountedSet;
}
- (NSCountedSet *)networkingUpateCountedSet {
    if (!_networkingUpateCountedSet) {
        _networkingUpateCountedSet = [[NSCountedSet alloc] init];
    } return _networkingUpateCountedSet;
}

#pragma mark -- 证书
+ (AFHTTPSessionManager *)verificationNoCertificate {
    return [SNNetworking sharedManager].manager;
}
+ (AFHTTPSessionManager *)verificationServerCertificateWith:(NSSet <NSData *> *)certificate {
    
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    [securityPolicy setAllowInvalidCertificates:YES]; //允许无效证书s
    securityPolicy.validatesDomainName = NO; //不验证域名

    if (certificate && certificate.count > 0) {
        securityPolicy.pinnedCertificates = certificate;
        [SNNetworking sharedManager].manager.securityPolicy = securityPolicy;
        return [SNNetworking sharedManager].manager;
    } else {
        return [SNNetworking verificationNoCertificate];
    }
}
+ (AFHTTPSessionManager *)verificationClientCertificateWith:(NSSet <NSData *> *)certificate p12:(NSString *)p12 pas:(NSString *)pas {
    __block AFHTTPSessionManager * manager = [SNNetworking sharedManager].manager;
    __weak typeof(manager) manager_weak = manager;
    
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential = nil;
        
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            
            if([manager_weak.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                
                if(credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
                
            } else {
                
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            // client authentication
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            if(![fileManager fileExistsAtPath:p12]) {
                NSLog(@"client.p12:not exist");
            } else {
                NSData * PKCS12Data = [NSData dataWithContentsOfFile:p12];
                //#加载PKCS12证书，pfx或p12
                if ([SNNetworking extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data pas:pas]) {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void * certs[] = {certificate};
                    CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    disposition = NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *_credential = credential;
        return disposition;
    }];
    
    return manager;
}

/**
 **加载PKCS12证书，pfx或p12
 **
 **/
+ (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data pas:(NSString *)pas {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:pas forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items,0);
        const void * tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void * tempTrust = NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}


@end
