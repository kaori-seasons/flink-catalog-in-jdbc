# flink-catalog-in-jdbc

### 项目背景

1.公司的整库同步功能中，目标端需要支持统一建库建表, 总不能同步源端的所有表，要让业务方手动在目标端建表吧, 那指定您需要建物理表 

2.运行环境全面升级到jdk11后，原基于hive catalog的flink catlog不能再使用，原因是现在hive所有版本都不支持jdk11,但在大趋势下jdk版本已不可能回退到jdk1.8了，在这种情况下是否可以开发一个不依赖hive的flink catalog呢？  flink默认catalog是保存在内存中，关键类是GenericInMemoryCatalog.java，这个类实现了元数据管理的所有方法，如果利用这些已实现的方法，只增加对内存中元数据持久化方法可以减少很工作量，同时也避免了重复造轮子。


### 开发环境
```
<dependency>
    <groupId>org.apache.flink.connector.jdbc</groupId>
    <artifactId>flink-catalog-in-jdbc</artifactId>
    <version>1.14</version>
</dependency>
```

# 在数据库中建表(支持jdbc)

```

CREATE TABLE `flink_catalog_databases` (
  `comment` varchar(100) DEFAULT NULL COMMENT '1',
  `properties` varchar(100) DEFAULT NULL,
  `database_name` varchar(100) DEFAULT NULL,
  UNIQUE KEY `flink_catalog_databases_un` (`database_name`)
) ;

CREATE TABLE `flink_catalog_tables` (
  `script` varchar(5000) DEFAULT NULL COMMENT '1',
  `object_name` varchar(100) DEFAULT NULL,
  `database_name` varchar(100) DEFAULT NULL,
  `kind` varchar(20) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  UNIQUE KEY `flink_catalog_databases_un` (`database_name`,`object_name`)
);

CREATE TABLE `flink_catalog_functions` (
  `database_name` varchar(100) DEFAULT NULL,
  `object_name` varchar(100) DEFAULT NULL,
  `class_name` varchar(200) DEFAULT NULL COMMENT '1',
  `function_language` varchar(20) DEFAULT NULL,
  UNIQUE KEY `flink_catalog_functions_un` (`database_name`,`object_name`)
) ;

CREATE TABLE `flink_catalog_columns` (
  `database_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `object_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `column_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `column_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `column_comment` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `flink_catalog_columns_un` (`database_name`,`object_name`,`column_name`)
)
```

### 使用示例
```
create catalog  my_catalog with ( 'type'='generic_in_jdbc', 'default-database'='test', 'username'='test', 'password'='****',
'url'='jdbc:mysql://*****:3306/lakehouse?useUnicode=true&characterEncoding=utf8&autoReconnect=true');

use catalog my_catalog;
 
create database if not exists my_database;

use  my_database;

CREATE TABLE if not exists `test` (
                      `c1` VARCHAR(2147483647),
                      `id` INT NOT NULL,
                      `stime` TIMESTAMP(3),
                     `cost` as id * 10, "
                      WATERMARK FOR `stime` AS `stime` - INTERVAL '10' SECOND,
                      CONSTRAINT `PK_3386` PRIMARY KEY (`id`) NOT ENFORCED
                    ) "
                     comment 'test' "
                     partitioned by (c1)"
                     WITH (
                      'connector' = 'print'
                    ) ";
                    
 show create table test;                   
```