//
//  PublicProtocol.h
//  SNMediatorKit
//
//  Created by snlo on 2018/5/1.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PublicMacroHeader.h"
#import "PublicUtilsHeader.h"
#import "PublicVenderHeader.h"
#import "PublicCategoriesHeader.h"

#import <SNConcreteProtocol.h>

static NSString * const kPublic = @"Public";

static NSString * const kNativeFetchPublicViewController = @"nativeFetchPublicViewController";

@protocol PublicProtocol <NSObject>

@concrete

@end
