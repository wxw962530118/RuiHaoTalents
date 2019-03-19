//
//  HZTAccountManager.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/15.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTAccountManager.h"
#define DOUCUMENT_ACCOUNT_ARCHIVE       @"account.archive"
/**JPushID*/
#define JpushRegistrationID             @"JpushRegistrationID"
/**NSUserDefaults - 上一次登录的手机号码*/
#define kLastLoginPhoneNumberDefaults   @"LastLoginPhoneNumber"
/**NSUserDefaults - 上一次登录的密码*/
#define kLastLoginPassWordDefaults      @"LastLoginPassWord"
/**NSUserDefaults - 存储用户输入的手机号码*/
#define kCurrLoginPhoneNumberDefaults   @"textFieldTextDefaults"

static HZTAccountManager *manager = nil;

@implementation HZTAccountManager
+ (instancetype)manager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

+ (HZTAccountModel *)getUser{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [doc stringByAppendingPathComponent:DOUCUMENT_ACCOUNT_ARCHIVE];
    HZTAccountModel * account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return account;
}

+ (BOOL)saveLastLoginPhoneWithAccount:(HZTAccountModel *)account{
    NSUserDefaults * df = [NSUserDefaults standardUserDefaults];
    if (account && account.mobile && account.mobile.length)
        [df setObject:account.mobile forKey:kLastLoginPhoneNumberDefaults];
    else
        [df setObject:@"" forKey:kLastLoginPhoneNumberDefaults];
    return [df synchronize];
}

+ (BOOL)saveLastPassWordWithAccount:(HZTAccountModel *)account{
    NSUserDefaults * df = [NSUserDefaults standardUserDefaults];
    if (account && account.passWord && account.passWord.length)
        [df setObject:account.passWord forKey:kLastLoginPassWordDefaults];
    else
        [df setObject:@"" forKey:kLastLoginPassWordDefaults];
    return [df synchronize];
}

+(NSString *)getLastLoginPassWord{
    NSString * lastLoginPassWord = [[NSUserDefaults standardUserDefaults] objectForKey:kLastLoginPassWordDefaults];
    if (!lastLoginPassWord || ![lastLoginPassWord isKindOfClass:[NSString class]] || !lastLoginPassWord.length)
        return @"";
    return lastLoginPassWord;
}

+ (NSString *)getLastLoginPhone{
    NSString * lastLoginPhoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:kLastLoginPhoneNumberDefaults];
    if (!lastLoginPhoneNumber || ![lastLoginPhoneNumber isKindOfClass:[NSString class]] || !lastLoginPhoneNumber.length)
        return @"";
    return lastLoginPhoneNumber;
}

+(BOOL)saveUserWithAccount:(HZTAccountModel *)account{
    /**沙盒路径*/
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [doc stringByAppendingPathComponent:DOUCUMENT_ACCOUNT_ARCHIVE];
    /**将返回的账号字典数据 --> 模型，存进沙盒 && 保存记录的上一次登录账号名称*/
    return [NSKeyedArchiver archiveRootObject:account toFile:path] && [self saveLastLoginPhoneWithAccount:account];
}

#pragma mark --- 登出成功操作
+ (BOOL)signOutEven{
    [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"login"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [doc stringByAppendingPathComponent:DOUCUMENT_ACCOUNT_ARCHIVE];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL blHave = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (!blHave) {
        NSLog(@"blHave no  have");
    }else {
        NSLog(@"blHave have");
        BOOL blDele = [fileManager removeItemAtPath:path error:nil];
        if (blDele) {
            NSLog(@"blHave dele success");
        }else {
            NSLog(@"blHave dele fail");
        }
    }
    //TCPOST_NOTIFICATION_NAMED_OBJECT(TCNOTIFICATION_SHOULD_LOGIN, nil);
    //TCPOST_NOTIFICATION_NAMED_OBJECT(TCNOTIFICATION_DID_LOGOUT_SUCCEED, nil);
    return [self clearCache];
}

+ (BOOL)clearCache {
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    return YES;
}

+ (NSString *)getRegistrationID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:JpushRegistrationID];
}

+(NSString *)getLoginPhoneNumber{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:kCurrLoginPhoneNumberDefaults];
}

+(void)removeLoginPhoneNumber{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kCurrLoginPhoneNumberDefaults];
}

+(BOOL )setLoginPhoneNumber:(NSString *)phoneNumber{
    [[NSUserDefaults standardUserDefaults] setObject:phoneNumber forKey:kCurrLoginPhoneNumberDefaults];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
