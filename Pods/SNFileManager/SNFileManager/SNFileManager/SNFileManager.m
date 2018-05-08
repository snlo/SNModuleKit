//
//  SNFileManager.m
//  Ljiamm
//
//  Created by snlo on 16/8/22.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import "SNFileManager.h"

@implementation SNFileManager

//appBox
+ (NSString *)HomePath
{
    NSString *path = NSHomeDirectory();
    return [NSString stringWithFormat:@"%@/",path];
}
//daocuments
+ (NSString *)DocumentsPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/",path];
}
//library
+ (NSString *)LibraryPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/",path];
}
//library/Caches
+ (NSString *)LibraryPathCachesPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/",path];
}
//library/Preferences
+ (NSString *)LibraryPathPreferencesPath
{
    NSString *path = [self LibraryPath];
    return [NSString stringWithFormat:@"%@Preferences/",path];
}
//Tmp
+ (NSString *)TmpPath
{
    return NSTemporaryDirectory();
}







//新建建文件目录
+ (BOOL)createDirectoryAtPath:(NSString *)atPath directoryName:(NSString *)directoryName newFilePath:(NSString **)newFilePath
{
    NSString * path = [NSString stringWithFormat:@"%@%@/",atPath,directoryName];
    
    if (newFilePath) * newFilePath = path; BOOL isDirectory = YES;
    
    if  (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    } else return NO;
}

//获取上级目录
+ (NSString *)parentPathAtPath:(NSString *)atPath
{
    return [NSString stringWithFormat:@"%@/",[atPath stringByDeletingLastPathComponent]];
}

//获取文件夹下级所有文件路径
+ (NSArray *)pathOfDirctoryEnumemberAtPath:(NSString *)atPath
{
    NSMutableArray * pathArray = [NSMutableArray array];
    //文件夹下所有的文件，包括其子文件夹中的文件和子文件夹
    NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager] enumeratorAtPath:atPath];
    for (NSString * subPath in enumerator) {
        if ([subPath rangeOfString:@".DStore"].location != NSNotFound) continue;
        NSString * fullSubPath = [atPath stringByAppendingString:subPath];
        BOOL isDirectory = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullSubPath isDirectory:&isDirectory]) {
            if (isDirectory) {
                /*[pathArray addObject:[fullSubPath stringByAppendingString:@"/"]];*/
            } else {
                [pathArray addObject:fullSubPath];
            }
        }
    }
    return pathArray;
}

//删除文件、文件夹
+ (BOOL)deleteDirectoryOrFileAtPath:(NSString *)atPath
{
    NSError * error;
    if (![[NSFileManager defaultManager] removeItemAtPath:atPath error:&error]) {
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
        return NO;
    } return YES;
}








//新建文件
+ (BOOL)createFileAtPath:(NSString *)atPath fileName:(NSString *)fileName newFilePath:(NSString **)newFilePath
{
    NSString *path = [atPath stringByAppendingPathComponent:fileName];
    if (newFilePath) * newFilePath = path;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    } else return NO;
}

//替换文件
+ (BOOL)replaceAtPath:(NSString *)atPath intoPath:(NSString *)intoPath newFilePath:(NSString **)newFilePath
{
    [[NSFileManager defaultManager] removeItemAtPath:intoPath error:nil];
    //找回名字
    NSString * newFileName = [self nameFromPath:atPath];
    intoPath = [[self parentPathAtPath:intoPath] stringByAppendingString:newFileName];
    if (newFilePath) * newFilePath = intoPath;
    NSError * error;
    if(![[NSFileManager defaultManager] moveItemAtPath:atPath toPath:intoPath error:&error]) {
        NSLog(@"Unable to move file: %@", [error localizedDescription]);
        return NO;
    } else return YES;
}

//移动文件(剪切文件到)
+ (BOOL)cutFileAtPath:(NSString *)atPath toDirectoryPath:(NSString *)toDirectoryPath WithFileNewName:(NSString *)newFileName newFilePath:(NSString **)newFilePath
{
    NSString * transitionPath;
    if (![self createFileAtPath:toDirectoryPath fileName:newFileName newFilePath:&transitionPath]) {
        NSLog(@"\"%@\"`s file exists",newFileName); return NO;
    }
    if (newFilePath) * newFilePath = transitionPath;
    NSError * error;
    if (![[NSFileManager defaultManager] moveItemAtPath:atPath toPath:transitionPath error:&error]) {
        NSLog(@"Unable to move file: %@", [error localizedDescription]);
        return NO;
    } else {
        return YES;
    }
    
}

//获取文件名
+ (NSString *)nameFromPath:(NSString *)path
{
    return [path lastPathComponent];
}

//获取文件路径
+ (NSURL *)filePathWithfileName:(NSString *)fileName fileType:(NSString *)fileType
{
    NSURL *fileUrl = [[NSBundle mainBundle]URLForResource:fileName withExtension:fileType];
    return fileUrl;
}

//拷贝文件到某文件目录
+ (BOOL)copyFileAtPath:(NSString *)atPath toDirectoryPath:(NSString *)toDirectoryPath newFilePath:(NSString **)newFilePath
{
    NSString * intoPath = [toDirectoryPath stringByAppendingString:[self nameFromPath:atPath]];
    if (newFilePath) * newFilePath = intoPath;
    NSError *error;
    if (![[NSFileManager defaultManager] copyItemAtPath:atPath toPath:intoPath error:&error]) {
        NSLog(@"Unable to copy file: %@", [error localizedDescription]);
        return NO;
    } else {
        return YES;
    }
}









//获取文件大小
+ (NSString *)fileSizeAtPath:(NSString *)atPath
{
    NSError * error;
    unsigned long long size = 0;
    size = [[NSFileManager defaultManager] attributesOfItemAtPath:atPath error:&error].fileSize;
    if (error) NSLog(@"Unable to get size of %@ file: %@",atPath ,[error localizedDescription]);
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
}

//获取文件、文件目录大小
+ (NSString *)directorySizeAtPath:(NSString *)atPath
{
    NSError * error;
    unsigned long long size = 0;
    BOOL isDirectory = NO;
    
    //判断路径
    if ([[NSFileManager defaultManager] fileExistsAtPath:atPath isDirectory:&isDirectory]) {
        //判断文件夹
        if (isDirectory) {
            NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager] enumeratorAtPath:atPath];
            for (NSString * subPath in enumerator) {
                NSString * fullSubPath = [atPath stringByAppendingString:subPath];
                size += [[NSFileManager defaultManager] attributesOfItemAtPath:fullSubPath error:&error].fileSize;
                if (error) NSLog(@"Unable to get size of %@ file: %@",fullSubPath ,[error localizedDescription]);
            }
        } else {
            size += [[NSFileManager defaultManager] attributesOfItemAtPath:atPath error:&error].fileSize;
        }
    }
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
}

//获取多个文件、不同文件目录大小
+ (NSString *)allSizeAtPathArray:(NSArray *)atPathArray
{
    unsigned long long size = 0;
    for (int i = 0; i < atPathArray.count; ++i) {
        BOOL isDirectory = NO;
        NSError * error;
        //判断路径
        if ([[NSFileManager defaultManager] fileExistsAtPath:atPathArray[i] isDirectory:&isDirectory]) {
            //判断文件夹
            if (isDirectory) {
                NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager] enumeratorAtPath:atPathArray[i]];
                for (NSString * subPath in enumerator) {
                    NSString * fullSubPath = [atPathArray[i] stringByAppendingString:subPath];
                    size += [[NSFileManager defaultManager] attributesOfItemAtPath:fullSubPath error:&error].fileSize;
                    if (error) NSLog(@"Unable to get size of %@ file: %@",fullSubPath ,[error localizedDescription]);
                }
            } else {
                size += [[NSFileManager defaultManager] attributesOfItemAtPath:atPathArray[i] error:&error].fileSize;
            }
        }
    }
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
}

//清理文件内容（不是删除）
+ (BOOL)clearFileAtPath:(NSString *)atPath
{
    return [[NSFileManager defaultManager] createFileAtPath:atPath contents:nil attributes:nil];
}

//清理文件目录（不是删除）
+ (BOOL)clearDirectoryAtPath:(NSString *)atPath
{
    NSError * error;
    BOOL isDirectory = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:atPath isDirectory:&isDirectory]) {
        if (isDirectory) {
            NSArray * pathArray = [self pathOfDirctoryEnumemberAtPath:atPath];
            for (int i = 0; i < pathArray.count; ++i) {
                [[NSFileManager defaultManager] removeItemAtPath:pathArray[i] error:&error];
            }
            return YES;
        } else {
            NSLog(@"\"%@\" -- %@",atPath,@"no directory");
            return NO;
        }
    } else {
        NSLog(@"\"%@\" -- %@",atPath,@"NSNotFound");
        return NO;
    }
}



@end
