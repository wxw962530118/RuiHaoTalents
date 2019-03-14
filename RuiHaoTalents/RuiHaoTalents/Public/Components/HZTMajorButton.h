//
//  HZTMajorButton.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTMajorButton : UIButton
/**
 *  是否是失效状态, YES: 失效(按钮变灰不可选) / NO: 正常(按钮可选)
 */
@property (nonatomic, assign) BOOL isInvalid;

@end

NS_ASSUME_NONNULL_END
