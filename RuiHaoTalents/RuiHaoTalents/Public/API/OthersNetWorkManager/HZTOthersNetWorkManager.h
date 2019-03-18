//
//  HZTOthersNetWorkManager.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "NetWorkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTOthersNetWorkManager : NetWorkManager
+ (instancetype)manager;

/**
 获取个人简历基本信息
 @param humanId  用户ID
 */
-(NSURLSessionDataTask *)requestMeProfileWithHumanId:(NSString *)humanId succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;

/**
 获取个人教育经历信息
 @param humanId  用户ID
 */
-(NSURLSessionDataTask *)requestEducationExperienceWithHumanId:(NSString *)humanId succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;
@end

NS_ASSUME_NONNULL_END
