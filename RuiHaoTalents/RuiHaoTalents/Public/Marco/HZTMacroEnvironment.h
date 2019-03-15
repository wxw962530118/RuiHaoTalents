//
//  HZTMacroEnvironment.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#ifndef HZTMacroEnvironment_h
#define HZTMacroEnvironment_h

/**处于开发阶段*/
#ifdef DEBUG
#define TCLog(...) NSLog(__VA_ARGS__)
/**处于发布阶段*/
#else
#define TCLog(...)
#endif

#ifndef __OPTIMIZE__

/* -------------- <开发阶段> ---------------- */

#define NSLog(...) NSLog(__VA_ARGS__)
/* 测试环境 */
#define HZT_HOST @"http://ru.ruihaodata.com"

/* ----------------------------------------- */

#else

/* --------------- <发布阶段> --------------- */

#define NSLog(...) {}

#define HZT_HOST @"http://admin.letscharge.cn"

/* ----------------------------------------- */

#endif


#endif /* HZTMacroEnvironment_h */
