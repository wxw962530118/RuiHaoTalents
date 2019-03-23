//
//  HZTMacroMeasurement.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#ifndef HZTMacroMeasurement_h
#define HZTMacroMeasurement_h

/***下载的zip文件主目录*/
#define HZTZipFileCacheDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HZTZipFileCache"]
/**解压缩后的文件主目录*/
#define HZTUnzipFileCacheDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HZTUnzipFileCache"]
/**解压缩后 主目录下保存文件的文件夹名称*/
#define HZTUnzipFileName(url) [HZTUnzipFileCacheDirectory stringByAppendingPathComponent:url.md5String]
/**下载的zip 主目录下保存文件的文件夹名称*/
#define HZTZipFileCacheName(url) [HZTZipFileCacheDirectory stringByAppendingPathComponent:url.md5String]

/** 存储在 UserDefault 里的上一次打开的版本号 */
#define kDefaultLastVerson @"CFBundleShortVersionString"
/**cell的标识符*/
#define kTCCellIdentifier NSStringFromClass(self)
#define WS(weakSelf)      __weak __typeof(&*self)weakSelf = self;
#define HZTNotServers     @"服务器维护中,请稍后再试!"
#define HZTNotNetWork     @"请检查网络连接！"
/**存储用户当前经度*/
#define LocationLongitude @"UserLongitude"
/**存储用户当前纬度*/
#define LocationLatitude  @"UserLatitude"

/**系统10*/
#define iOS10 [[UIDevice currentDevice].systemVersion floatValue] >= 10.0
/**系统11*/
#define iOS11 [[UIDevice currentDevice].systemVersion floatValue] >= 11.0

#endif /* HZTMacroMeasurement_h */
