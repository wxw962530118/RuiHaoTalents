//
//  HZTImmediateMatchController.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTImmediateMatchController : HZTBaseViewController
-(instancetype)initWithWorkArdess:(NSString *)workArdess workType:(NSString *)workType startDate:(NSString *)startDate endDate:(NSString *)endDate payId:(NSString *)payId industry:(NSString *)industry personFunction:(NSString *)personFunction;
@end

NS_ASSUME_NONNULL_END
