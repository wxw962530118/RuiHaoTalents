//
//  NetWorkManager.h
//  KidsDigitalLibrary
//
//  Created by 王新伟 on 2018/6/12.
//  Copyright © 2018年 haizitong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FileType){
    FileType_Image,  /**图片*/
    FileType_Voice,  /**音频*/
    FileType_Video   /**视频*/
};

typedef NS_ENUM(NSInteger,RequestType){
    RequestType_Get,  /***/
    RequestType_Post, /***/
};

/**
 进度回调
 @param completedCount 完成进度
 @param totalCount     总量进度
 */
typedef void(^ProgressBlock)(CGFloat completedCount,CGFloat totalCount);

@interface NetWorkManager : NSObject

/**
 *  创建单例
 *  @return NetworkManager
 */
+ (instancetype)sharedInstance;

/**
 *  检查网络是否可用
 *  @return YES/NO
 */
- (BOOL)isNetworkReachable;

/**
 GET请求
 @param URLString  URL
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */

-(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id response))success failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 POST请求
 @param URLString  URL
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id response))success failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 上传媒体文件
 @param URLString  URL
 @param fileType   媒体类型
 @param fileData   二进制流
 @param parameters 参数
 */
-(NSURLSessionDataTask *)POST:(NSString *)URLString fileType:(FileType)fileType fileData:(NSData *)fileData parameters:(NSDictionary *)parameters success:(void(^)(id response))success failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 下载文件
 @param urlString 文件URL
 @param downloadProgressBlock 下载进度回调
 @param completionHandler  完成的回调
 @param failure  失败的回调
 */
-(NSURLSessionDownloadTask *)DOWN:(NSString *)urlString
                                           progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                  completionHandler:(void (^)(NSURL *filePath))completionHandler
                                     failureHandler:(void (^)(NSError *error))failure;

/**
 DELETE请求
 @param URLString URL
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 PUT请求
 @param URLString URL
 @param parameters 参数
 @param success 成功回调
 @param failur 失败回调
 */
-(NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failur;

@end
