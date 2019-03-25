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
#define URL_PERSON_JOB_LIST         @"%@/person/wanfed/jobfull/get"

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

-(NSURLSessionDataTask *)requestJobListWithPersonWorkArdess:(NSString *)personWorkArdess workArdessX:(NSString *)workArdessX workArdessY:(NSString *)workArdessY reportStart:(NSString *)reportStart reportEnd:(NSString *)reportEnd personWorkType:(NSString *)personWorkType personPayStart:(NSString *)personPayStart personIndustry:(NSString *)personIndustry personFunction:(NSString *)personFunction sort:(NSInteger)sort pageNumber:(NSInteger)pageNumber succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[ToolBaseClass isNullClass:personWorkArdess] ? @"西安市-新城区" : personWorkArdess forKey:@"personWorkArdess"];
    [param setObject:workArdessX forKey:@"workArdessX"];
    [param setObject:workArdessY forKey:@"workArdessY"];
    [param setObject:reportStart forKey:@"reportStart"];
    [param setObject:reportEnd forKey:@"reportEnd"];
    [param setObject:personWorkType forKey:@"personWorkType"];
    [param setObject:personPayStart forKey:@"personPayStart"];
    [param setObject:personIndustry forKey:@"personIndustry"];
    [param setObject:personFunction forKey:@"personFunction"];
    [param setObject:@(sort) forKey:@"sort"];
    [param setObject:@(pageNumber) forKey:@"pageNumber"];
    NSString * URLString = [NSString stringWithFormat:URL_PERSON_JOB_LIST,HZT_HOST];
    NSURLSessionDataTask * task = [[NetWorkManager sharedInstance]POST:URLString parameters:param success:^(id response) {
        succeed(response[@"data"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    return  task;
}

@end
