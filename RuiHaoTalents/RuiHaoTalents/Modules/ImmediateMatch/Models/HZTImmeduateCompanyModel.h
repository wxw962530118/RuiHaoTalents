//
//  HZTImmeduateCompanyModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/23.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTImmeduateCompanyModel : HZTBaseModel
/**公司融资情况A B C 轮*/
@property (nonatomic, copy) NSString * enterFinancName;
/**公司类型: 个人 合资*/
@property (nonatomic, copy) NSString * enterNatureName;
/**公司logo*/
@property (nonatomic, copy) NSString * enterLogo;
/**公司名称*/
@property (nonatomic, copy) NSString * enterName;
/**公司ID*/
@property (nonatomic, copy) NSString * enterId;
/**公司评分*/
@property (nonatomic, copy) NSString * compSincerity;
/**公司简称*/
@property (nonatomic, copy) NSString * enterShortName;
@end

NS_ASSUME_NONNULL_END
