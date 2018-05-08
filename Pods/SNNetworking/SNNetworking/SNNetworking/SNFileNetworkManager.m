//
//  SNFileNetworkManager.m
//  AFNetworkingTest
//
//  Created by snlo on 16/7/1.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import "SNFileNetworkManager.h"

#define kSNCachePath @""

@implementation SNFileNetworkManager

// 获取沙盒路径
+ (NSString *)cachePathForDocumentWithComponent:(NSString *)folderName {
    
    NSString *fullPath = nil;
    
    NSString * path = NSHomeDirectory();
    NSString * cacheDiretory = [path stringByAppendingPathComponent:@"Library/Caches/"];
    cacheDiretory = [cacheDiretory stringByAppendingPathComponent:kSNCacheName];
    
    if (folderName && [folderName length] > 0) {
        fullPath = [cacheDiretory stringByAppendingPathComponent:folderName];
    } else {
        fullPath = cacheDiretory;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:fullPath]) {
        NSError *err = nil;
        if ([fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&err]) {
            
            return fullPath;
        } else {
            return cacheDiretory;
        }
    } else {
        return fullPath;
    }
}



#pragma mark -- 小秘
+ (NSString *)currentTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

@end
