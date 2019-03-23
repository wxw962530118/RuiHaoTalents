//
//  HZTImmediateMatchModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"
#import "HZTImmeduateCompanyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTImmediateMatchModel : HZTBaseModel
/***/
@property (nonatomic, copy) NSString * workArdessName;
/***/
@property (nonatomic, strong) NSArray * wanfedList;
/***/
@property (nonatomic, strong) HZTImmeduateCompanyModel * personJobEnterVO;
/**工作年限*/
@property (nonatomic, copy) NSString * workJobLifeName;
/**职位*/
@property (nonatomic, copy) NSString * jobPosition;
/**开始薪资待遇*/
@property (nonatomic, copy) NSString * fullPayStartName;
/**结束薪资待遇*/
@property (nonatomic, copy) NSString * fullPayEndName;
@end

NS_ASSUME_NONNULL_END
