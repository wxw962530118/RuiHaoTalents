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


/**
 获取行业职能列表
 @param Id  固定参数:1
 */
-(NSURLSessionDataTask *)requestPostListWithId:(NSString *)Id succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;
/**
 获取薪资列表
 @param Id  固定参数:1
 */
-(NSURLSessionDataTask *)requestPayListWithId:(NSString *)Id succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;


/**
 获取职位列表信息
 @param personWorkArdess 区域名称（例如：西安市—雁塔区）
 @param workArdessX      地图坐标经度
 @param workArdessY      地图坐标纬度
 @param reportStart      到岗开始时间
 @param reportEnd        到岗结束时间
 @param personWorkType   职位性质（0、全职）
 @param personPayStart   薪资
 @param personIndustry   行业ID
 @param personFunction   职能ID
 @param sort             排序1、综合排序，2、距离排序，3、薪资排序，4，评分
 @param pageNumber       页码
 */
-(NSURLSessionDataTask *)requestJobListWithPersonWorkArdess:(NSString *)personWorkArdess workArdessX:(double)workArdessX workArdessY:(double)workArdessY reportStart:(NSString *)reportStart reportEnd:(NSString *)reportEnd personWorkType:(NSString *)personWorkType personPayStart:(NSString *)personPayStart personIndustry:(NSString *)personIndustry personFunction:(NSString *)personFunction sort:(NSInteger)sort pageNumber:(NSInteger)pageNumber succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;
@end

NS_ASSUME_NONNULL_END
