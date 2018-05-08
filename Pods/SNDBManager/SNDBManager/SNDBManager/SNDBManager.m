//
//  SNDBManager.m
//  Ljiamm
//
//  Created by snlo on 16/8/26.
//  Copyright © 2016年 snlo. All rights reserved.
//

#import "SNDBManager.h"

@implementation SNDBManager

//打开数据库，创建一张表
+ (BOOL)db:(FMDatabase *)db creatTableWithName:(NSString *)tableName contentInfo:(NSDictionary *)contentInfo
{
    NSMutableString * muColumnString = [NSMutableString string];
    if (contentInfo && contentInfo.allKeys.count > 0) {
        for (NSString * key in contentInfo.allKeys) {
            [muColumnString appendFormat:@",%@ %@",key, contentInfo[key]];
        }
        muColumnString = (NSMutableString *)[muColumnString substringFromIndex:1];
    }
    if ([db open]) {
        BOOL success = [db executeUpdate:[NSString stringWithFormat:@"create table if not exists '%@' (id integer primary key autoincrement, %@);",tableName ,muColumnString]];
        if (success) {
            NSLog(@"create table success");
        } else {
            NSLog(@"create table faile");
        }
        return success;
    } else {
        NSLog(@"open db success");
        return NO;
    }
}

//判断表中字段是否真的存在
+ (BOOL)db:(FMDatabase *)db columnExistsed:(NSString *)columnName inTable:(NSString *)tableName
{
    return [db columnExists:columnName inTableWithName:tableName];
}

//添加字段到表中
+ (BOOL)db:(FMDatabase *)db addColumnToTable:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo
{
    BOOL success = NO;
    if (columnInfo && columnInfo.allKeys.count > 0) {
        for (id key in columnInfo.allKeys) {
            //判定表中 key 字段是否存在
            if (![db columnExists:key inTableWithName:tableName]){
                success = [db executeUpdate:[NSString stringWithFormat:@"alter table '%@' add column '%@' '%@';",tableName,key,columnInfo[key]]];
            }
        }
    } return success;
}

//删除一张表
+ (void)db:(FMDatabase *)db deleteTable:(NSString *)tableName
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[db databasePath]];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:[NSString stringWithFormat:@"drop table if exists '%@';",tableName]];
    }];
}

//删除数据
+ (void)db:(FMDatabase *)db clearTable:(NSString *)tableName whereColumnInfo:(NSDictionary *)whereColumnInfo with_sql:(NSString *)sql
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[db databasePath]];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (sql) {
            [db executeUpdate:[NSString stringWithFormat:@"UPDATE sqlite_sequence set seq = 0 where name ='%@';",tableName]];
            if (![db executeUpdate:sql]) {
                *rollback = YES;
                return;
            } return;
        }
        if (whereColumnInfo && whereColumnInfo.allKeys.count > 0) {
            NSString * key = whereColumnInfo.allKeys.firstObject;
            for (id value in whereColumnInfo[key]) {
                BOOL success = NO;
                [db executeUpdate:[NSString stringWithFormat:@"UPDATE sqlite_sequence set seq = 0 where name ='%@';",tableName]];
                success = [db executeUpdate:[NSString stringWithFormat:@"delete from '%@' where %@ = '%@';",tableName, key, value]];
                if (!success) {
                    *rollback = YES;
                    return;
                }
            }
        } else {
            BOOL success = NO;
            //自动清零表sqlite_sequence中的seq序列
            success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE sqlite_sequence set seq = 0 where name ='%@';",tableName]];
            success = [db executeUpdate:[NSString stringWithFormat:@"delete from '%@';",tableName]];
            if (!success) {
                *rollback = YES;
                return;
            }
        }
    }];
}



//更改表结构
+ (void)db:(FMDatabase *)db updateTableWithName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo
{
    NSLog(@"\n1.把表改成临时表:[db executeUpdate: [NSString stringWithFormat:@\"alter table '?' rename to tmp\",tableName]];\n2.创建新表\n3.导入旧数据\n4.BUT:SQLite 支持 ALTER TABLE 的有限子集。在 SQLite 中，ALTER TABLE 命令允许用户重命名表，或向现有表添加一个新的列。重命名列，删除一列，或从一个表中添加或删除约束都是不可能的。");
}

//插入数据
+ (void)db:(FMDatabase *)db insertDataToTable:(NSString *)tableName insertDataArray:(NSArray <NSDictionary *>*)insertDataArray transactionBlock:(void(^)(FMDatabase *db, BOOL *rollback))transactionBlock
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[db databasePath]];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (transactionBlock) {
            transactionBlock(db, rollback);
        }
        for (int i = 0; i < insertDataArray.count; ++i) {
            BOOL success = NO;
            NSMutableString * keyString = [NSMutableString string];
            NSMutableString * valuesString = [NSMutableString string];
            NSMutableArray * valueArray = [NSMutableArray array];
            for (NSString * key in insertDataArray[i].allKeys) {
                [keyString appendFormat:@",%@",key];
                id values = insertDataArray[i][key];
                [valueArray addObject:values];
                [valuesString appendFormat:@",%@",@"?"];
            }
            NSString * sqlString = [NSString stringWithFormat:@"insert into test(%@) values(%@);",
                                    [keyString substringFromIndex:1],
                                    [valuesString substringFromIndex:1]];
            success = [db executeUpdate:sqlString withArgumentsInArray:valueArray];
            if (!success) {
                *rollback = YES;
                return;
            }
        }
    }];
}


//修改数据
+ (void)db:(FMDatabase *)db updateDataAtTable:(NSString *)tableName updateDataArray:(NSArray <NSDictionary *>*)updateDataArray with_sql:(NSString *)sql
{
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[db databasePath]];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (sql) {
            if (![db executeUpdate:sql]) {
                *rollback = YES;
                return;
            } return;
        }
        for (int i = 0; i < updateDataArray.count; ++i) {
            BOOL success = YES;
            for (NSString * string in updateDataArray[i].allKeys) {
                if ([string isEqualToString:sql_update_where]) {
                    success = YES;
                } else success = NO;
            }
            if (!success) {
                NSLog(@"no such sql 'sq_where'");
                *rollback = YES;
                return;
            }
            for (NSString * key in updateDataArray[i].allKeys) {
                if (![key isEqualToString:sql_update_where]) {
                    NSDictionary * dicWhere = updateDataArray[i][sql_update_where];
                    NSString * whereKey = dicWhere.allKeys.firstObject;
                    
                    success = [db executeUpdate:[NSString stringWithFormat:
                                       @"update '%@' set %@ = '%@' where %@ = '%@';",
                                       tableName,
                                       key,
                                       updateDataArray[i][key],
                                       whereKey,
                                       dicWhere[whereKey]]];
                }
                if (!success) {
                    *rollback = YES;
                    return;
                }
            }
        }
    }];
}

//查询操作
+ (void)sreached:(void(^)(FMDatabase *DB, BOOL *Rollback, FMResultSet * ResultSet))sreachedBlock with_sql:(NSString *)sql fromDB:(FMDatabase *)db
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[db databasePath]];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet * resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            if (sreachedBlock) {
                sreachedBlock(db, rollback, resultSet);
            }
        }
        [resultSet close];
    }];
}

@end
