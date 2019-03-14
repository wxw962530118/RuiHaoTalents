//
//  HZTCityModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"
#import "HZTDistrictModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTCityModel : HZTBaseModel
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * code;
@property (nonatomic,copy)NSArray  <HZTDistrictModel *>* district;
@end

NS_ASSUME_NONNULL_END
