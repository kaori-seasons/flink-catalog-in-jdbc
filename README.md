# flink-catalog-in-jdbc

### 项目背景

1.公司的整库同步功能中，目标端需要支持统一建库建表, 总不能同步源端的所有表，要让业务方手动在目标端建表吧, 那指定您指定需要建物理表 

2.运行环境全面升级到jdk11后，原基于hive catalog的flink catlog不能再使用，原因是现在hive所有版本都不支持jdk11,但在大趋势下jdk版本已不可能回退到jdk1.8了，在这种情况下是否可以开发一个不依赖hive的flink catalog呢？  flink默认catalog是保存在内存中，关键类是GenericInMemoryCatalog.java，这个类实现了元数据管理的所有方法，如果利用这些已实现的方法，只增加对内存中元数据持久化方法可以减少很工作量，同时也避免了重复造轮子。
