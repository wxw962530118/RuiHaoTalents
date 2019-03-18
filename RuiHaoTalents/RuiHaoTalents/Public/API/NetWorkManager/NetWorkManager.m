//
//  NetWorkManager.m
//  KidsDigitalLibrary
//
//  Created by 王新伟 on 2018/6/12.
//  Copyright © 2018年 haizitong. All rights reserved.
//

#import "NetWorkManager.h"
/**对请求失败的统一处理 (处理后会继续通知子类, 子类可以进行其他处理)**/
#define HandleFailedWithErrorCode(task,error)  if (HandleFailedWithErrorCode_extern(task,error)) return
#define HZT_TOKEN_INVALID  @"HZT_TOKEN_INVALID"
@interface NetWorkManager()
@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;
@end

@implementation NetWorkManager

+(instancetype )sharedInstance{
    static NetWorkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetWorkManager alloc]init];
        [manager addObserVers];
        [manager openNetObserve];
    });
    return manager;
}

-(void)addObserVers{
    NotificationRegister(HZTNOTIFICATION_DID_LOGIN_SUCCEED, self, @selector(handleHTTPHeaderField), nil);
}

-(void)handleHTTPHeaderField{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    if (![ToolBaseClass isNullClass:[HZTAccountManager getUser].token]){
        [dict setValue:[HZTAccountManager getUser].token forKey:@"token"];
        [dict setValue:[HZTAccountManager getUser].mobile forKey:@"userName"];
        /**基类统一根据客户端设置userType 0 个人 1企业*/
        [dict setValue:@"0" forKey:@"userType"];
        [self.sessionManager.requestSerializer setValue:[ToolBaseClass dictionaryToJson:dict] forHTTPHeaderField:@"baseTokenInfo"];
    }else{
        [self.sessionManager.requestSerializer setValue:@"{}" forHTTPHeaderField:@"baseTokenInfo"];
    }
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        /**最大的超时请求时间*/
        self.sessionManager.requestSerializer.timeoutInterval = 30;
        /**请求队列的最大并发数*/
        self.sessionManager.operationQueue.maxConcurrentOperationCount = 5;
        /**设置可接收服务器返回数据类型*/
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html", nil];
        [self handleHTTPHeaderField];
    }
    return self;
}

#pragma mark --- 开启网络状态监测
-(void)openNetObserve{
    __weak typeof(self) weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NotificationPost(HZTNOTIFICATION_NETWORK_CHANGED, @(status), nil);
        [weakSelf handleEventNetStatusCallBack];
    }];
    [[AFNetworkReachabilityManager sharedManager]  startMonitoring];
}

- (void)handleEventNetStatusCallBack{
    if (![[NetWorkManager sharedInstance]isNetworkReachable]) {
        NSLog(@"请检查网络连接");
        [HZTToastHUD showNormalWithTitle:HZTNotNetWork];
        return;
    }
}

#pragma mark -- Check network reachable
- (BOOL)isNetworkReachable {
    return [self.sessionManager reachabilityManager].isReachable;
}

-(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id response))success failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    NSMutableDictionary *handleDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSURLSessionDataTask * task = [self.sessionManager GET:URLString parameters:handleDict progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        if([responseObject isKindOfClass:[NSArray class]]){
            /**最外层是数组*/
            NSArray * respDict = (NSArray *)responseObject;
            if (success) {
                success(respDict);
            }
        }else{
            /**最外层是字典*/
            NSDictionary *respDict = (NSDictionary *)responseObject;
            if (success) {
                success(respDict);
            }
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        /**拿到失败信息 统一处理*/
        HandleFailedWithErrorCode(task,error);
        failure(task ,error);
    }];
    return task;
}

-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (![HZTAccountManager getUser].token) [dic setValue:@"0" forKey:@"userType"];
    NSURLSessionDataTask * task = [self.sessionManager POST:URLString parameters:dic progress:^(NSProgress * uploadProgress) {
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        if ([[responseObject objectForKey:@"state"] intValue] == 0) {
            success(responseObject);
        }else{
            if ([[responseObject objectForKey:@"state"] intValue] >=1 && [[responseObject objectForKey:@"state"] intValue] <=3) {
                /**处理token问题 重新登录*/
                [MBProgressHUD showError:@"登录失效,请重新登录"];
                NotificationPost(HZTNOTIFICATION_SHOULD_LOGIN, nil, nil);
            }else{
                [MBProgressHUD showError:[responseObject objectForKey:@"msg"]];
            }
            [HZTToastHUD hideLoading];
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)task.response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        if (responseStatusCode == 200) {
            success(nil);
            return ;
        }
        HandleFailedWithErrorCode(task,error);
        failure(task ,error);
    }];
    return task;
}

-(NSURLSessionDataTask *)POST:(NSString *)URLString fileType:(FileType )fileType fileData:(NSData *)fileData parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSURLSessionDataTask * task = [self.sessionManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (fileType == FileType_Image) {
            [formData appendPartWithFileData:fileData name:@"file" fileName:@"pic.jpg" mimeType:@"image/*"];
        } else if (fileType == FileType_Video) {
            [formData appendPartWithFileData:fileData name:@"file" fileName:@"video.mp4" mimeType:@"video/*"];
        } else if (fileType == FileType_Voice) {
            [formData appendPartWithFileData:fileData name:@"file" fileName:@"voice.mp3" mimeType:@"voice/*"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)task.response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        if (responseStatusCode == 200) {
            success(nil);
            return ;
        }
        HandleFailedWithErrorCode(task,error);
        failure(task ,error);
    }];
    return task;
}

-(NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSURLSessionDataTask * task = [self.sessionManager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        failure(task ,error);
    }];
    return task;
}

-(NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSURLSessionDataTask * dataTask = [self.sessionManager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * task, id  responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        failure(task ,error);
    }];
    return dataTask;
}

-(NSURLSessionDownloadTask *)DOWN:(NSString *)urlString progress:(void (^)(NSProgress *))downloadProgressBlock completionHandler:(void (^)(NSURL *))completionHandler failureHandler:(void (^)(NSError *))failure{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask * dataTask = [self.sessionManager downloadTaskWithRequest:request progress:^(NSProgress * downloadProgress) {
        downloadProgressBlock(downloadProgress);
    } destination:^NSURL * (NSURL * targetPath, NSURLResponse * response) {
        /***拼接文件全路径*/
        NSString *fullpath = [[self getZipFileCache:urlString.md5String] stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"fullpath%@",fullpath);
        NSURL *filePathUrl = [NSURL fileURLWithPath:fullpath];
        return filePathUrl;
    } completionHandler:^(NSURLResponse * response, NSURL * filePath, NSError * error) {
        if (error == nil) {
            completionHandler(filePath);
        }else{
            failure(error);
        }
    }];
    [dataTask resume];
    return dataTask;
}

#pragma mark --- 在缓存zip的文件主目录 下 根据url md5 再创建对应文件夹 存放对应文件
-(NSString *)getZipFileCache:(NSString *)fileMd5{
    NSString * directory = [self getZipFileCachePath];
    directory = [HZTZipFileCacheDirectory stringByAppendingPathComponent:fileMd5];
    if (![[NSFileManager defaultManager] fileExistsAtPath:directory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return directory;
}

#pragma mark --- 创建缓存zip的文件主目录
-(NSString *)getZipFileCachePath{
    if (![[NSFileManager defaultManager] fileExistsAtPath:HZTZipFileCacheDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:HZTZipFileCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return HZTZipFileCacheDirectory;
}

#pragma mark --- 请求失败统一处理
/**
 错误码-处理
 @return 是否拦截 请求子类对该错误码的处理（YES:拦截， NO：不拦截）
 注：
 *  拦截后，请求子类和VC中的failureBlock 将不会被调用 */
CG_INLINE BOOL HandleFailedWithErrorCode_extern(NSURLSessionDataTask * task,NSError * error) {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    NSLog(@"responseStatusCode:%ld", (unsigned long)responseStatusCode);
    NSDictionary * errorDict = [ToolBaseClass changeErrorToNSDictionary:error];
    NSLog(@"errorDict:%@",errorDict);
    if(responseStatusCode == 401){
        /**内部处理token失效发出通知*/
        NotificationPost(HZTNOTIFICATION_SHOULD_LOGIN, nil, nil);
        return NO;
    }else if (responseStatusCode == 400 || responseStatusCode == 404) {
        /**交给子类自己处理*/
        return NO;
    }else if (responseStatusCode == 0 || responseStatusCode == 500) {
        return NO;
    }else{
//        if (![ToolBaseClass isNullClass:errMessage]){
//            HZTAlertView(@"提示", errMessage , @"确定", nil, ^(NSUInteger index) {
//            });
//        }errorDict
    }
    return YES;
};

@end
