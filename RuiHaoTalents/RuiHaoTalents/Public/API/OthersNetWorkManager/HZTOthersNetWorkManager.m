//
//  HZTOthersNetWorkManager.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTOthersNetWorkManager.h"
#define URL_ME_PROFILE              @"%@/person/job/record/get"
#define URL_EDUCATION_EXPERIENCE    @"%@/person/jobbasic/train/get"
#define URL_POST_LIST               @"%@/funbasic/getbasic"
#define URL_PAY_LIST                @"%@/dicbasic/getbasic"

@implementation HZTOthersNetWorkManager

+(instancetype)manager{
    static HZTOthersNetWorkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

-(NSURLSessionDataTask *)requestMeProfileWithHumanId:(NSString *)humanId succeed:(void (^)(id _Nonnull))succeed failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:humanId forKey:@"humanId"];
    NSString * URLString = [NSString stringWithFormat:URL_ME_PROFILE,HZT_HOST];
    NSURLSessionDataTask * task = [[NetWorkManager sharedInstance]POST:URLString parameters:param success:^(id response) {
        succeed(response[@"data"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    return  task;
}

-(NSURLSessionDataTask *)requestEducationExperienceWithHumanId:(NSString *)humanId succeed:(void (^)(id _Nonnull))succeed failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:humanId forKey:@"humanId"];
    NSString * URLString = [NSString stringWithFormat:URL_EDUCATION_EXPERIENCE,HZT_HOST];
    NSURLSessionDataTask * task = [[NetWorkManager sharedInstance]POST:URLString parameters:param success:^(id response) {
        succeed(response[@"data"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    return  task;
}

-(NSURLSessionDataTask *)requestPostListWithId:(NSString *)Id succeed:(void (^)(id _Nonnull))succeed failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:Id forKey:@"id"];
    NSString * URLString = [NSString stringWithFormat:URL_POST_LIST,HZT_HOST];
    NSURLSessionDataTask * task = [[NetWorkManager sharedInstance]POST:URLString parameters:param success:^(id response) {
        succeed(response[@"data"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    return  task;
}

-(NSURLSessionDataTask *)requestPayListWithId:(NSString *)Id succeed:(void (^)(id _Nonnull))succeed failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:Id forKey:@"id"];
    NSString * URLString = [NSString stringWithFormat:URL_PAY_LIST,HZT_HOST];
    NSURLSessionDataTask * task = [[NetWorkManager sharedInstance]POST:URLString parameters:param success:^(id response) {
        succeed(response[@"data"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    return  task;
}

@end
