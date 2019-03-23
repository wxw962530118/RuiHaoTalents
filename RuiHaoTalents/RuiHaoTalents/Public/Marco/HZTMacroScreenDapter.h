//
//  HZTMacroScreenDapter.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#ifndef HZTMacroScreenDapter_h
#define HZTMacroScreenDapter_h

#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height
/**状态栏高度*/
#define StatusHeight  [[UIApplication sharedApplication] statusBarFrame].size.height
/**等比例缩放 基准为 9.7 ipad air2 || 4.7 iphone6*/
#define HZTAdHeight(t)         kScreenH*(t * 1.0/667)
#define HZTAdWidth(t)          kScreenW*(t * 1.0/375)
/**字体按比例缩放*/
#define HZTAdaptFont(R)        [UIFont systemFontOfSize:HZTAdWidth(R)]
#define HZTAdaptBoldFont(R)    [UIFont boldSystemFontOfSize:HZTAdWidth(R)]

// 字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

#endif /* HZTMacroScreenDapter_h */
