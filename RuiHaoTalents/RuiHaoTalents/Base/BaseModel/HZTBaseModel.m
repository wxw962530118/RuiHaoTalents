//
//  HZTBaseModel.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

@implementation HZTBaseModel

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
-(void)encodeWithCoder:(NSCoder *)encoder{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i< count; i++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        //将C 字符串 转成 OC 字符串
        NSString * key = [NSString stringWithUTF8String:name];
        //归档
        [encoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法（在other文件夹中HWAppDelegate.m中解档中调用）
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (instancetype)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i< count; i++) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            //将C 字符串 转成 OC 字符串
            NSString * key = [NSString stringWithUTF8String:name];
            //解档
            id  value = [decoder decodeObjectForKey:key];
            //设置成员变量
            if (!value) continue;
            [self setValue:value forKey:key];
        }
        //释放C
        free(ivars);
    }
    return self;
}

@end
