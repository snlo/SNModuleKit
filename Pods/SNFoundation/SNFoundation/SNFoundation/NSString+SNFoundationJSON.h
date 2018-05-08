//
//  NSString+SNFoundationJSON.h
//  NeighborMom
//
//  Created by snlo on 16/4/29.
//  Copyright © 2016年 WAYOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SNFoundationJSON)

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;
+ (NSString *)jsonStringWithArray:(NSArray *)array;
+ (NSString *)jsonStringWithString:(NSString *) string;
+ (NSString *)jsonStringWithObject:(id) object;

@end
