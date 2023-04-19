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