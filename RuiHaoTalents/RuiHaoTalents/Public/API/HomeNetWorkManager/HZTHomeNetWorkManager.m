//
//  HZTHomeNetWorkManager.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTHomeNetWorkManager.h"

@implementation HZTHomeNetWorkManager
#define URL_LEFT_USER_INFO         @"%@/human/basic/personal/get"

+(instancetype)manager{
    static HZTHomeNetWorkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

-(NSURLSessionDataTask *)requestLeftUserinfoWithHumanId:(NSString *)humanId succeed:(void (^)(id _Nonnull))succeed failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:humanId forKey:@"humanId"];
    NSString * URLString = [NSString stringWithFormat:URL_LEFT_USER_INFO,HZT_HOST];
    NSURLSessionDataTask * task = [[NetWorkManager sharedInstance]POST:URLString parameters:param success:^(id response) {
        succeed(response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    return  task;
}

@end
