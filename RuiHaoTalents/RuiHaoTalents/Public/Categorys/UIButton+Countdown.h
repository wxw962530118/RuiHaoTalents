//
//  UIButton+Countdown.h
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/22.
//  Copyright © 2019 王新伟. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Countdown)

/**
 倒计时
 
 @param second 执行时间
 */
- (void)countdownWithSec:(NSInteger)second;

@end

NS_ASSUME_NONNULL_END
