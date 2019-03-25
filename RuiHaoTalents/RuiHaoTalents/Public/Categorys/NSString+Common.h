//
//  NSString+Common.h
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/20.
//  Copyright © 2019 王新伟. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSString (Common)

/**
 获取当前版本号

 @return 版本号
 */
+ (NSString *)appVersion;

/**
 判断字符串是否为空
 */
- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
