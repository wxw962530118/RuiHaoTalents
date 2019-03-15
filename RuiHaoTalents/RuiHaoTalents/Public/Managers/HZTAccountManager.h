//
//  HZTAccountManager.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/15.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZTAccountModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTAccountManager : NSObject
+ (instancetype)manager;
/**
 *  获取用户信息
 */
+ (HZTAccountModel *)getUser;
/**
 *  退出登录 */
+ (void)signOutUser;
/**
 *  存储用户信息 */
+ (BOOL)saveUserWithAccount:(HZTAccountModel *)account;
/**
 *  清除用户信息 */
+ (BOOL)signOutEven;
/**
 *  获取当前登录用户的手机号码
 */
+(NSString *)getLoginPhoneNumber;
/**
 *  存储用户最后一次登录的手机号码
 */
+ (BOOL)saveLastLoginPhoneWithAccount:(HZTAccountModel *)account;
/**
 *  存储用户最后一次登录的密码
 */
+ (BOOL)saveLastPassWordWithAccount:(HZTAccountModel *)account;
/**
 获取上一次登录成功的账号 */
+ (NSString *)getLastLoginPhone;
/**
 *  获取上一次登录成功的账户密码
 */
+(NSString *)getLastLoginPassWord;
/**
 *  清空当前登录用户的手机号码
 */
+(void)removeLoginPhoneNumber;
@end

NS_ASSUME_NONNULL_END
