//
//  HZTLoginWorkManager.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/15.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "NetWorkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTLoginWorkManager : NetWorkManager
+ (instancetype)manager;

/**
 注册获取验证码
 @param mobile  手机号码
 */
-(NSURLSessionDataTask *)requestRegisterMobileCodeWithMobile:(NSString *)mobile succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;

/**
 新用户注册
 @param mobile   手机号码
 @param code     验证码
 @param password 密码
 */
-(NSURLSessionDataTask *)requestRegisterCreateWithMobile:(NSString *)mobile code:(NSString *)code password:(NSString *)password succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;

/**
 登录 验证码登录
 @param mobile   手机号码
 @param code     验证码
 */
-(NSURLSessionDataTask *)requestSigninWithMobile:(NSString *)mobile code:(NSString *)code succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;

/**
 登录 密码登录
 @param mobile   手机号码
 @param password 密码
 */
-(NSURLSessionDataTask *)requestSigninWithMobile:(NSString *)mobile password:(NSString *)password succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;

-(NSURLSessionDataTask *)requestLoginOutSucceed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;
@end

NS_ASSUME_NONNULL_END
