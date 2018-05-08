//
//  SNDBManager.h
//  Ljiamm
//
//  Created by snlo on 16/8/26.
//  Copyright © 2016年 snlo. All rights reserved.
//

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
/////////////////                    ///////////////////////
/////////////////   暂时对FMDB做管理   ///////////////////////
/////////////////                    ///////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

#import <FMDB.h>

@interface SNDBManager : NSObject


/**
 *  打开数据库，新建一张表（当该表存在时就不再新建，并且不会添加字段内容contentInfo）
 *
 *  @param db          目标数据库
 *  @param tableName   新建表名
 *  @param contentInfo 新建表的内容字段（key为字段名，value为该字段的属性及约束）
 *  @return 成功与否
 */
+ (BOOL)db:(FMDatabase *)db creatTableWithName:(NSString *)tableName contentInfo:(NSDictionary *)contentInfo;

/**
 *  判断表中字段是否真的存在
 *
 *  @param db         目标数据库
 *  @param columnName 字段名
 *  @param tableName  目标表名
 *  @return YES存在，NO不存在
 */
+ (BOOL)db:(FMDatabase *)db columnExistsed:(NSString *)columnName inTable:(NSString *)tableName;


/**
 更改表结构
 */
+ (void)db:(FMDatabase *)db updateTableWithName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo;

/**
 *  删除一张表,整张表包括表内容
 *
 *  @param db        目标数据库
 *  @param tableName 目标表名
 */
+ (void)db:(FMDatabase *)db deleteTable:(NSString *)tableName;

//删除数据
/**
 *  删除表中数据，不包括表
 *
 *  @param db          目标数据库
 *  @param tableName   目标表名
 *  @param whereColumnInfo 要删除的数据的主键以对应的数据（key为主键名<只能唯一>，value为要删除的的主键值得数组<>）
 */
+ (void)db:(FMDatabase *)db clearTable:(NSString *)tableName whereColumnInfo:(NSDictionary *)whereColumnInfo with_sql:(NSString *)sql;

/**
 *  添加新的字段到已有表中
 *
 *  @param db         指定数据库
 *  @param tableName  指定数据库中的表名
 *  @param columnInfo 新的字段信息：key——>名字 ，value——>属性
 */
+ (BOOL)db:(FMDatabase *)db addColumnToTable:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo;




//插入数据
/**
 *  线程安全的插入数据，强制使用事务
 *
 *  @param db               目标数据库
 *  @param tableName        目标表名
 *  @param insertDataArray  要插入的数据，一个数组元素为一条数据，每条数据只能为字典。
 *  @param transactionBlock 事务的回调
 *
 *  在插入NSArray、NSDictionary、Model等对象时需要将对象序列化（归档，将对象转换成二进制流）查询时才能反序列化（解档）<sqlite所储存的数据以文本文件的形式存在的>
 */
+ (void)db:(FMDatabase *)db insertDataToTable:(NSString *)tableName insertDataArray:(NSArray <NSDictionary *>*)insertDataArray transactionBlock:(void(^)(FMDatabase *db, BOOL *rollback))transactionBlock;

/**
 *  修改/更新数据
 *
 *  @param db              目标数据库
 *  @param tableName       目标表名
 *  @param updateDataArray 要更新的数据，指定那条数据用sql_update_where e.g：
                           @[@{sql_update_where:@{@"id":@"1"},
                             @"age":@"new_12",@"name":@"new_names"}]
 */
+ (void)db:(FMDatabase *)db updateDataAtTable:(NSString *)tableName updateDataArray:(NSArray <NSDictionary *>*)updateDataArray with_sql:(NSString *)sql;

/**
 *  查询操作
 *
 *  @param sreachedBlock 查询后的结果，需要自己截获结果
 *  @param sql           输入查询sql语句
 *  @param db            目标数据库
 */
+ (void)sreached:(void(^)(FMDatabase *DB, BOOL *Rollback, FMResultSet * ResultSet))sreachedBlock with_sql:(NSString *)sql fromDB:(FMDatabase *)db;

@end

/**
 *  sqlite语法参考自:http://www.runoob.com/sqlite/sqlite-alias.html
 *
 *  NOT NULL 约束：确保某列不能有 NULL 值。
 *  DEFAULT 约束：当某列没有指定值时，为该列提供默认值。
 *  UNIQUE 约束：确保某列中的所有值是不同的。
 *  PRIMARY Key 约束：唯一标识数据库表中的各行/记录。
 *  CHECK 约束：CHECK 约束确保某列中的所有值满足一定条件。
 *
 *  SQLite 数据类型 http://www.runoob.com/sqlite/sqlite-data-types.html
 */
//更新位置主键
static NSString * sql_update_where = @"sql_where";


