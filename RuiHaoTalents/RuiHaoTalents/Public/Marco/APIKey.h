//
//  APIKey.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#ifndef APIKey_h
#define APIKey_h
#import <UIKit/UIKit.h>

/**新浪微博Key*/
static NSString *const APISinaKey          =  @"817270931";
/**新浪微博Secret*/
static NSString *const APISinaSecret       =  @"3167923b317c53cfd582a7b3d809d2a6";
/**UmengKey*/
static NSString *const APIKeyUMeng         =  @"59cb3a0f5312dd01bf00001c";
/**微信Key*/
static NSString *const APIKeyWeiXin        =  @"wx1b451c9e9bbb4fb3";
/**微信Secret*/
static NSString *const APIKeyWeiXinSecret  =  @"392c213ffd8d177c1ae16f55e2c898b6";

#ifdef DEBUG // 开发阶段

static BOOL isDebug = YES;

static BOOL isRelease = NO;

/**JpushKey*/
static NSString *const APIKeyJpush          =  @"3a3bb30155bc2483a52b5e18";

#else
// 发布阶段

static BOOL isDebug = NO;

static BOOL isRelease = YES;

static NSString *const APIKeyJpush          = @"1853a8e3ab8cbf5c23e6ce12";

#endif


#endif /* APIKey_h */
