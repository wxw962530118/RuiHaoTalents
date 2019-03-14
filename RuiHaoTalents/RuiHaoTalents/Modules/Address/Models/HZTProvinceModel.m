//
//  HZTProvinceModel.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTProvinceModel.h"

@implementation HZTProvinceModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"city" : [HZTCityModel class]};
}
@end
