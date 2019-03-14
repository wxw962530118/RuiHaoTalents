//
//  HZTCustomPickerModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTCustomPickerModel : HZTBaseModel
/**城市地区选择 相关*/
@property(nonatomic,copy)NSString * province_name;

@property(nonatomic,copy)NSString * province_code;

@property(nonatomic,copy)NSString * city_name;

@property(nonatomic,copy)NSString * city_code;

@property(nonatomic,copy)NSString * district_name;

@property(nonatomic,copy)NSString * district_code;

/**其他*/
@property (nonatomic, copy) NSString * name;
@end

NS_ASSUME_NONNULL_END
