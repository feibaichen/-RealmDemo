# -RealmDemo
 Realm数据库简单使用(增删改查和数据迁移)


Realm是由美国YCombinator孵化的创业团队历时几年打造，第一个专门针对移动平台设计的数据库

Realm是一个跨平台的移动数据库引擎，目前支持iOS、Android平台，同时支持Objective-C、Swift、Java、React Native、Xamarin等多种编程语言

Realm并不是对SQLite或者CoreData的简单封装, 是由核心数据引擎C++打造，是拥有独立的数据库存储引擎，可以方便、高效的完成数据库的各种操作

在RLMObject类中，我们可以添加属性，添加的属性类型可以支持如下类型：

------------------------------
NSString：字符串

NSInteger, int, long, float, double：数字型，注意没有CGFloat


BOOL/bool：布尔型

NSDate：日期型

NSData：二进制字符型

NSNumber<X>: 其中X必须RLMInt, RLMFloat, RLMDouble或 RLMBool类型

RLMArray<X>: 其中X必须是RLMObject类的子类, 用于建模多对多关系

RLMObject的子类，用于建模多对一关系

------------------------------
数据库迁移

数据库存储方面的增删改查应该都没有什么大问题，比较蛋疼的应该就是数据迁移了
在版本迭代过程中，很可能会发生表的新增，删除，或者表结构的变化，如果新版本中不做数据迁移，用户升级到新版，很可能就直接crash了
数据迁移一直是困扰各类型数据库的一大问题, 但是对于Realm来说, 却方便很多, 这也是Realm的优点之一

新增删除表，Realm不需要做迁移
新增删除字段，Realm不需要做迁移; Realm会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
