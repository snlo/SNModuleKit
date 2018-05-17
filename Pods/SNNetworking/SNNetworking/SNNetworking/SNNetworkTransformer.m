//
//  SNNetworkTransformer.m
//  AFNetworkingTest
//
//  Created by snlo on 16/7/1.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import "SNNetworkTransformer.h"

#import "SNNetworkTool.h"

@implementation SNNetworkTransformer

+ (NSString *)stringFromResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        
        responseObject = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    } else if ([responseObject isKindOfClass:[NSURL class]]) {
        
        responseObject = [NSString stringWithFormat:@"%@",responseObject];
        
    } else {
        
        responseObject = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    }
    return responseObject;
}

+ (NSDictionary *)dictionaryFromDataPath:(NSString *)path
{
    NSData *data = [[NSMutableData alloc]initWithContentsOfFile:path];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    NSDictionary *dic = [unarchiver decodeObjectForKey:@"talkData"];
    
    [unarchiver finishDecoding];
    
    return dic;
}

+ (NSDictionary *)dictionaryFromData:(NSData *)data
{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    NSDictionary *dic = [unarchiver decodeObjectForKey:@"talkData"];
    
    [unarchiver finishDecoding];
    
    return dic;
}

//遍历error，找出错误信息
+ (NSMutableDictionary *)valueFromError:(NSError *)error
{
    NSMutableDictionary * errorDic = [NSMutableDictionary dictionary];
    if ([error isKindOfClass:[NSString class]]) {
		
		[SNTool showAlertStyle:UIAlertControllerStyleAlert title:nil msg:(NSString *)error chooseBlock:nil actionsStatement:nil, nil];
        
        [errorDic setObject:@"unknown error" forKey:@"unknown error"];
        return errorDic;
    }
    if (error.userInfo.allKeys.count == 0) {
        
        [errorDic setObject:@"unknown error" forKey:@"unknown error"];
        
        return errorDic;
    }
    for (NSString * key in error.userInfo.allKeys) {
        
        //if key begin with "com.alamofire", break;
        if (![key hasPrefix:@"com.alamofire"])
            [errorDic setObject:error.userInfo[key] forKey:key];

    }
    
    BOOL has_error = NO;
    for (id  _Nonnull key in errorDic.allKeys) {
        if ([key hasSuffix:@"Description"]) {
            [SNTool showAlertStyle:UIAlertControllerStyleAlert title:nil msg:(NSString *)error chooseBlock:nil actionsStatement:nil, nil];
            has_error = YES;
            break;
        }
    }
    if (!has_error) {
		[SNTool showAlertStyle:UIAlertControllerStyleAlert title:nil msg:@"当前网络状态不佳" chooseBlock:nil actionsStatement:nil, nil];
    }

    return errorDic;
}

@end
