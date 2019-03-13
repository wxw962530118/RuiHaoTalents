//
//  HZTMacroColors.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#ifndef HZTMacroColors_h
#define HZTMacroColors_h

/**不包含透明度*/
#define RGBColor(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/**包含透明度*/
#define RGBColorAlpha(r,g,b,a)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
/**重点文字色  黑色*/
#define HZTColorEmphasis            RGBColor(33, 33, 33)
/**默认主色调 蓝色*/
#define HZTMainColor                RGBColor(33,150,243)
/** App 页面背景色   淡灰*/
#define HZTColorBackGround          RGBColor(246, 246, 246)
/** App 控件描边灰色 淡灰*/
#define HZTColorComponentBorder     RGBColor(216, 216, 216)
/** App 分割线 淡灰*/
#define HZTColorComponentLine       RGBColor(214, 214, 214)
/** App 页面白色背景 白色*/
#define HZTColorWhiteGround         RGBColor(255, 255, 255)
/**清除颜色*/
#define HZTClearColor               [UIColor clearColor]

#endif /* HZTMacroColors_h */
