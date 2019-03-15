//
//  HZTLoginWorkManager.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/15.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTLoginWorkManager.h"
#define URL_CODE_LOGIN        @"%@/loginuser/quick/login"
#define URL_PASSWORD_LOGIN    @"%@/loginuser/login"
#define URL_GET_CODE          @"%@/loginuser/code/get"
#define URL_REGISTER          @"%@/loginuser/register/user"
@implementation HZTLoginWorkManager

+(instancetype)manager{
    static HZTLoginWorkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

-(NSURLSessionDataTask *)requestRegisterMobileCodeWithMobile:(NSString *)mobile succeed:(void (^)(id))succeed failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:mobile forKey:@"userName"];
    NSString * URLString = [NSString stringWithFormat:URL_GET_CODE,HZT_HOST];
    NSURLSessionDataTask * task = [[NetWorkManager sharedInstance]POST:URLString parameters:param success:^(id response) {
        succeed(response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    return  task;
}

-(NSURLSessionDataTask *)requestRegisterCreateWithMobile:(NSString *)mobile code:(NSString *)code password:(NSString *)password succeed:(void (^)(id))succeed failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:mobile forKey:@"userName"];
    [param setObject:code forKey:@"verifyCode"];
    [param setObject:password forKey:@"password"];
    NSString * URLString = [NSString stringWithFormat:URL_REGISTER,HZT_HOST];
    NSURLSessionDataTask * task = [[NetWorkManager sharedInstance]POST:URLString parameters:param success:^(id response) {
        succeed(response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    return  task;
}

/***
 state 0:成功 1:手机号不能为空 2:密码不能为空 3:登录属性不能为空 4:账号不存在 5:为开通个人账号 6:个人账号已冻结 7:未开通企业账号 8:企业账号已冻结 9:密码不正确 10登录失败
 */
-(NSURLSessionDataTask *)requestSigninWithMobile:(NSString *)mobile password:(NSString *)password succeed:(void (^)(id))succeed failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:mobile forKey:@"userName"];
    [param setObject:password forKey:@"password"];
    NSString * URLString = [NSString stringWithFormat:URL_PASSWORD_LOGIN,HZT_HOST];
    NSURLSessionDataTask * task = [[NetWorkManager sharedInstance]POST:URLString parameters:param success:^(id response) {
        if ([[response objectForKey:@"state"] intValue] == 0) {
            succeed(response);
        }else{
            [MBProgressHUD showError:[response objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    return  task;
}

-(NSURLSessionDataTask *)requestSigninWithMobile:(NSString *)mobile code:(NSString *)code succeed:(void (^)(id _Nonnull))succeed failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:mobile forKey:@"userName"];
    [param setObject:code forKey:@"verifyCode"];
    NSString * URLString = [NSString stringWithFormat:URL_CODE_LOGIN,HZT_HOST];
    NSURLSessionDataTask * task = [[NetWorkManager sharedInstance]POST:URLString parameters:param success:^(id response) {
        succeed(response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
    return  task;
}

@end
