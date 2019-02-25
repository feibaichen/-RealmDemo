//
//  StudentRLM.h
//  RealmDataDemo
//
//  Created by MacOS on 2019/2/22.
//  Copyright © 2019 MacOS. All rights reserved.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudentRLM : RLMObject

//对象的属性声明,注意请不要带上nonatomic,assign,strong等这样修饰的词(官方推荐避免引起奇葩错误),readonly可以但是在realm里面有新的作用,后面讲.
@property NSString *name;
@property int number;
@property int age;
@property NSString *studentNum;

@end
// This protocol enables typed collections. i.e.:
// RLMArray<student *><student>
// Realm中需要声明对象
RLM_ARRAY_TYPE(StudentRLM)

NS_ASSUME_NONNULL_END
