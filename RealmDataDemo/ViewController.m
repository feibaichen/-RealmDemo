//
//  ViewController.m
//  RealmDataDemo
//
//  Created by MacOS on 2019/2/22.
//  Copyright © 2019 MacOS. All rights reserved.
//

#import "ViewController.h"
#import "StudentRLM.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1.快速Realm创建对象
    
    //创建方法一
    //[self fristCreatRealm];
    //[self fristCreatRealm1];
    
    //创建方法二
    //[self secCreatRealm];
    
    //创建方法三
    //[self threeCreatRealm];
    
    //通过主键 查找和更新 数据库值
    //[self changeDataViaValue];
    
    //根据某一个值来删除
    //[self deleDataViaValue];
    
    //根据主键来删除
    //[self deleDataViaPrimaryKey];
    
    
    //循环删除一张模型表 置空
    //[self deleOneModel];
    
    
    //数据迁移
    //[self moveData];
    
}

- (void)fristCreatRealm{
    
//    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
//    config.schemaVersion = 1;
//    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    //创建方法一
    StudentRLM *student = [[StudentRLM alloc] initWithValue:@{@"studentNum":@"121928112",@"number":@2,@"name":@"feibaichen",@"age":@99}];
    //2.存储对象(realm种存储对象一定要开启事务)
    
    //拿到操作realm的数据库对象写入
    RLMRealm *realm = [RLMRealm defaultRealm];
    //开始写入事务
    [realm beginWriteTransaction];
    //存储对象
    [realm addObject:student];
    //提交事务
    [realm commitWriteTransaction];
}

- (void)fristCreatRealm1{
    
    //创建方法一
    StudentRLM *student = [[StudentRLM alloc] initWithValue:@{@"studentNum":@"121928113",@"number":@3,@"name":@"feibaichen1",@"age":@991}];
    //2.存储对象(realm种存储对象一定要开启事务)
    
    //拿到操作realm的数据库对象写入
    RLMRealm *realm = [RLMRealm defaultRealm];
    //开始写入事务
    [realm beginWriteTransaction];
    //存储对象
    [realm addObject:student];
    //提交事务
    [realm commitWriteTransaction];
    
    
}

- (void)secCreatRealm{
    
    StudentRLM *student = [[StudentRLM alloc] init];
    student.name = @"网二";
    student.number = 9;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    //第二种方法
    [realm transactionWithBlock:^{
        [realm addObject:student];
    }];
}

- (void)threeCreatRealm{
    //(顺序是和声明的顺序一致)
    StudentRLM *student  = [[StudentRLM alloc] initWithValue:@[@"zhangsan",@26]];
    RLMRealm *realm = [RLMRealm defaultRealm];
    //第三种
    [realm transactionWithBlock:^{
        [realm addObject:student];
    }];
}

- (void)changeDataViaValue{
    // 1.查询所有类对象
    //RLMResults *results = [StudentRLM allObjects];
    RLMRealm *realm = [RLMRealm defaultRealm];
    // 2.主键查询
    StudentRLM *student = [StudentRLM objectInRealm:realm forPrimaryKey:@"121928113"];
    [realm transactionWithBlock:^{
        student.name = @"change Value";
    }];
}

//根据某一个值来删除
- (void)deleDataViaValue{
    //被删除的模型一定是要求被Realm所管理的
    //第一步取出来需要删除的对象
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *results = [StudentRLM objectsWhere:@"number = 2"];
    StudentRLM *lisi = results.firstObject;//这里就存了一个对象
    
    //删除单条数据
    [realm transactionWithBlock:^{
        [realm deleteObject:lisi];
    }];

}

//根据主键来删除
- (void)deleDataViaPrimaryKey{
    //被删除的模型一定是要求被Realm所管理的
    //第一步取出来需要删除的对象
    RLMRealm *realm = [RLMRealm defaultRealm];
   
    StudentRLM *stuDelete = [StudentRLM objectInRealm:realm forPrimaryKey:@"121928113"];
    [realm transactionWithBlock:^{
        [realm deleteObject:stuDelete];
    }];
}

- (void)deleOneModel{
    //删除1张模型表数据
    RLMResults *stuResult = [StudentRLM allObjects];
     RLMRealm *realm = [RLMRealm defaultRealm];
    for (StudentRLM *stu in stuResult) {
        [realm transactionWithBlock:^{
            [realm deleteObject:stu];
        }];
      }
}

- (void)moveData{
//    // 获取默认配置, 迁移数据结构
//    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
//    
//    // 1. 设置新的架构版本。这个版本号必须高于之前所用的版本号（如果您之前从未设置过架构版本，那么这个版本号设置为 0）
//    int newVersion = 4;
//    config.schemaVersion = newVersion;
//    
//    // 2. 设置闭包，这个闭包将会在打开低于上面所设置版本号的 Realm 数据库的时候被自动调用
//    [config setMigrationBlock:^(RLMMigration *migration, uint64_t oldSchemaVersion){
//        if (oldSchemaVersion < newVersion) {
//            
//            NSLog(@"数据结构会自动迁移");
//            
//            // enumerateObjects:block: 遍历了存储在 Realm 文件中的每一个“Person”对象
//            [migration enumerateObjects:@"DataMigration" block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
//                // 只有当 Realm 数据库的架构版本为 0 的时候，才添加 “fullName” 属性
//                if (oldSchemaVersion < 1) {
//                    newObject[@"fullName"] = [NSString stringWithFormat:@"%@ %@", oldObject[@"firstName"], oldObject[@"lastName"]];
//                }
//                // 只有当 Realm 数据库的架构版本为 0 或者 1 的时候，才添加“email”属性
//                if (oldSchemaVersion < 2) {
//                    newObject[@"email"] = @"";
//                }
//                // 替换属性名(原字段重命名)
//                if (oldSchemaVersion < 3) { // 重命名操作应该在调用 `enumerateObjects:` 之外完成
//                    [migration renamePropertyForClass:Person.className oldName:@"yearsSinceBirth" newName:@"age"];
//                }
//            }];
//        }
//    }];
//    
//    // 3. 告诉 Realm 为默认的 Realm 数据库使用这个新的配置对象
//    [RLMRealmConfiguration setDefaultConfiguration:config];
//    
//    // 4. 现在我们已经告诉了 Realm 如何处理架构的变化，打开文件之后将会自动执行迁移
//    [RLMRealm defaultRealm];
}

//注1:Realm里面没有回滚,可以通过检查error来判断是否添加成功
- (BOOL)commitWriteTransaction:(NSError **)outError{
//注2:一旦将对象存入Realm中就意味着这个对象已经被Realm管理,并且已经和磁盘上的对象进行了地址映射
    return YES;
}

@end
