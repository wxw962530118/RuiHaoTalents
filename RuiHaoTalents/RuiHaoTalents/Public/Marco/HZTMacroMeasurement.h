//
//  HZTMacroMeasurement.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#ifndef HZTMacroMeasurement_h
#define HZTMacroMeasurement_h

/** 存储在 UserDefault 里的上一次打开的版本号 */
#define kDefaultLastVerson @"CFBundleShortVersionString"
/**cell的标识符*/
#define kTCCellIdentifier NSStringFromClass(self)
#define WS(weakSelf)      __weak __typeof(&*self)weakSelf = self;
#define HZTNotServerWarning  @"服务器维护中,请稍后再试!"
#define HZTNotNetWarning     @"请检查网络连接！"
/**系统10*/
#define iOS10 [[UIDevice currentDevice].systemVersion floatValue] >= 10.0
/**系统11*/
#define iOS11 [[UIDevice currentDevice].systemVersion floatValue] >= 11.0

#endif /* HZTMacroMeasurement_h */
