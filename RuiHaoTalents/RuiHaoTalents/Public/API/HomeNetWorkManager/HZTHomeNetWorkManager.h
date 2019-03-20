//
//  HZTHomeNetWorkManager.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "NetWorkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTHomeNetWorkManager : NetWorkManager
+ (instancetype)manager;

/**
 首页左边菜单数据
 @param humanId 用户id
 */
-(NSURLSessionDataTask *)requestLeftUserInfoWithHumanId:(NSString *)humanId succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;

/**
 区域获取列表数据
 @param ID
 */
-(NSURLSessionDataTask *)requestAreaInfoWithId:(NSString *)ID succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;

@end

NS_ASSUME_NONNULL_END
