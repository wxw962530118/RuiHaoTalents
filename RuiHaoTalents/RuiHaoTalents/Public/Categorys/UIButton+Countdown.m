//
//  UIButton+Countdown.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/22.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "UIButton+Countdown.h"

@implementation UIButton (Countdown)

/** 倒计时，s倒计 */
- (void)countdownWithSec:(NSInteger)second {
    __block NSInteger tempSecond = second;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (tempSecond <= 1) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.enabled = YES;
                [strongSelf setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        } else {
            tempSecond--;
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.enabled = NO;
                [strongSelf setTitle:[NSString stringWithFormat:@"剩余%lds", (long)tempSecond] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(timer);
}

@end
