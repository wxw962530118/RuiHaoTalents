//
//  HZTWorkAreaViewController.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTWorkAreaViewController : HZTBaseViewController
-(instancetype)initWithCityName:(NSString *)cityName areaName:(NSString *)areaName callBack:(void (^)(NSString * result))callBack;
@end

NS_ASSUME_NONNULL_END
