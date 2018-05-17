//
//  SNSafeCategory.m
//  SNTool
//
//  update by snlo on 2018/5/10.
//  Copyright (C) 2012 Justin Spahr-Summers.
//  Released under the MIT license.
//

#import "SNSafeCategory.h"
#import "SNRuntimeExtensions.h"
#import <stdlib.h>

static
void safeCategoryMethodFailed (Class cls, Method method) {
    const char *methodName = sel_getName(method_getName(method));
    const char *className = class_getName(cls);

    BOOL isMeta = class_isMetaClass(cls);
    if (isMeta)
        fprintf(stderr, "ERROR: Could not add class method +%s to %s (a method by the same name already exists)\n", methodName, className);
    else
        fprintf(stderr, "ERROR: Could not add instance method -%s to %s (a method by the same name already exists)\n", methodName, className);
}

/**
 * This loads a safe category into the destination class, making sure not to
 * overwrite any methods that already exist. \a methodContainer is the class
 * containing the methods defined in the safe category. \a targetClass is the
 * destination of the methods.
 *
 * Returns \c YES if all methods loaded without conflicts, or \c NO if
 * loading failed, whether due to a naming conflict or some other error.
 */
BOOL sn_loadSafeCategory (Class methodContainer, Class targetClass) {
    if (!methodContainer || !targetClass)
        return NO;

    return sn_injectMethodsFromClass(
        methodContainer,
        targetClass,
        sn_methodInjectionFailOnAnyExisting | sn_methodInjectionIgnoreLoad,
        &safeCategoryMethodFailed
    );
}

