//
//  NSString+SNNetworkingJSON.h
//  NeighborMom
//
//  Created by snlo on 16/4/29.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SNNetworkingJSON)

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;
+ (NSString *)jsonStringWithArray:(NSArray *)array;
+ (NSString *)jsonStringWithString:(NSString *) string;
+ (NSString *)jsonStringWithObject:(id) object;

@end
