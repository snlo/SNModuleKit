//
//  SNFileManager.h
//  Ljiamm
//
//  Created by snlo on 16/8/22.
//  Copyright © 2016年 snlo. All rights reserved.
//

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
/////////////                            ///////////////////
/////////////   此文件助手是对线程不安全的   ///////////////////
/////////////                            ///////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@interface SNFileManager : NSObject


/**
 *  app box path
 *  工程沙盒根路径
 */
+ (NSString *)HomePath;

/**
 *  documents
 *  APP运行时生成的需要持久化的数据，iTunes自动备份,
 *  用来保存应由程序运行时生成的需要持久化的数据， iTunes会自动备份该目录（苹果公司建议将程序中创建的和浏览过的程序存放在这里，iTunes在备份和回复时会自动包含此目录）。
 */
+ (NSString *)DocumentsPath;

/**
 *  library
 *  存储程序的默认设置和其他状态信息，iTunes会自动备份该目录（除了Caches子目录外）。
 *  用来存储程序的默认设置和其他状态信息，iTunes也会自动备份该目录。
 */
+ (NSString *)LibraryPath;

/**
 *  library/Caches
 *  缓存文件，iTunes不会备份，不会在APP退出删除
 *  用来存放缓存文件，iTunes不会备份此目录，此目录下的文件不会在程序退出后删除，一般存放体积比较大但又不太重要的文件。
 */
+ (NSString *)LibraryPathCachesPath;

/**
 *  library/Preferences
 *  所有偏好设置,iTunes会自动备份,应用NSUserDefaults来获得设置APP偏好所以不用创建偏好设置文件
 *  用来存储用户的偏好设置，iOS的setting（设置）会在这个目录中查找应用程序的设置信息，iTunes会自动备份该目录，通常这个文件夹都是由系统进行维护的，建议不要操作他。注意：不要直接写偏好设置到这个文件夹，而是通过NSUserDefaults来进行偏好设置的保存和读取。
 */
+ (NSString *)LibraryPathPreferencesPath;

/**
 *  Tmp
 *  临时数据,iTunes不会自动备份，APP退出会自动清除
 *  保存应用程序的临时文件夹，使用完毕后，将相应的文件从这个目录中删除，如果空间不够，系统也可能会删除这个目录下的文件，iTunes不会同步这个文件夹，在iPhone重启的时候，该目录下的文件会被删除。
 */
+ (NSString *)TmpPath;











////////////文件目录操作/////////////////////////////////////////////\n//////////////////////////////////////////////////////////////////////////////////

/**
 *  新建建文件目录
 *
 *  @param atPath        目标文件目录路径
 *  @param directoryName 新建的文件目录名
 *  @param newFilePath   新建的文件目录路径
 *
 *  @return YES为新建成功,return NO为新建失败或文件目录已经存在（SNFileManager不允许覆盖同名文件目录）
 */
+ (BOOL)createDirectoryAtPath:(NSString *)atPath directoryName:(NSString *)directoryName newFilePath:(NSString **)newFilePath;

/**
 *  获取上级目录
 *
 *  @param atPath 目标文件、文件目录
 *
 *  @return 上级目录路径
 */
+ (NSString *)parentPathAtPath:(NSString *)atPath;

/**
 *  获取文件夹下级所有文件路径
 *
 *  @param atPath 目标文件夹
 *  @return 下级所有文件路径集
 */
+ (NSArray *)pathOfDirctoryEnumemberAtPath:(NSString *)atPath;

/**
 *  删除文件、文件目录
 *
 *  @param atPath 目标文件、文件目录路径
 *
 *  @return 成功与否
 */
+ (BOOL)deleteDirectoryOrFileAtPath:(NSString *)atPath;











////////////文件操作/////////////////////////////////////////////\n//////////////////////////////////////////////////////////////////////////////////

/**
 *  新建文件
 *
 *  @param atPath      目标文件目录路径
 *  @param fileName    新建文件名
 *  @param newFilePath 新建的文件路径
 *
 *  @return YES为新建成功,return NO为新建失败或文件目录已经存在（SNFileManager不允许覆盖同名文件）
 */
+ (BOOL)createFileAtPath:(NSString *)atPath fileName:(NSString *)fileName newFilePath:(NSString **)newFilePath;

/**
 *  替换某文件
 *
 *  @param atPath      目标文件
 *  @param intoPath    被替换的文件（之后销毁）
 *  @param newFilePath 替换之后目标文件的新路径
 *
 *  @return 成功与否
 */
+ (BOOL)replaceAtPath:(NSString *)atPath intoPath:(NSString *)intoPath newFilePath:(NSString **)newFilePath;

/**
 *  移动文件(剪切文件到)
 *
 *  @param atPath          被移动的文件
 *  @param toDirectoryPath 将要移动到的文件目录
 *  @param newFileName     重命名
 *  @param newFilePath     被移动的文件最终
 *
 *  @return 成功与否
 */
+ (BOOL)cutFileAtPath:(NSString *)atPath toDirectoryPath:(NSString *)toDirectoryPath WithFileNewName:(NSString *)newFileName newFilePath:(NSString **)newFilePath;

/**
 *  获取文件名
 *
 *  @param path 目标文件
 *  @return 文件名
 */
+ (NSString *)nameFromPath:(NSString *)path;

/**
 *  获取文件路径
 *
 *  @param fileName 目标文件名
 *  @param fileType 目标文件后缀
 *  @return 文件路径
 */
+ (NSURL *)filePathWithfileName:(NSString *)fileName fileType:(NSString *)fileType;

/**
 *  拷贝文件到某文件目录
 *
 *  @param atPath          目标文件
 *  @param toDirectoryPath 目标文件目录
 *  @param newFilePath     拷贝后文件的新路径
 *
 *  @return 成功与否
 */
+ (BOOL)copyFileAtPath:(NSString *)atPath toDirectoryPath:(NSString *)toDirectoryPath newFilePath:(NSString **)newFilePath;













////////////文件、目录大小操作/////////////////////////////////////////////\n//////////////////////////////////////////////////////////////////////////////////

/**
 *  获取文件大小
 *
 *  @param atPath 目标文件
 *  @return 文件大小（单位是byte、KB、MB...）
 */
+ (NSString *)fileSizeAtPath:(NSString *)atPath;

/**
 *  获取文件、文件目录大小
 *
 *  @param atPath 目标文件、文件目录
 *  @return 文件、文件目录大小
 */
+ (NSString *)directorySizeAtPath:(NSString *)atPath;

/**
 *  获取多个文件、不同文件目录大小
 *
 *  @param atPathArray 目标文件、文件目录数组
 *  @return 总的大小
 */
+ (NSString *)allSizeAtPathArray:(NSArray *)atPathArray;

/**
 *  清理文件内容（不是删除）
 *
 *  @param atPath 目标文件
 *  @return 成功与否
 */
+ (BOOL)clearFileAtPath:(NSString *)atPath;

/**
 *  清理文件目录（不是删除）
 *
 *  @param atPath 目标文件目录
 *  @return 成功与否
 */
+ (BOOL)clearDirectoryAtPath:(NSString *)atPath;



@end
