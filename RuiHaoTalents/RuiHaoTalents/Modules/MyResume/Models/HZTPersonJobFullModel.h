//
//  HZTPersonJobFullModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"
#import "HZTSkillModel.h"
#import "HZTProjiectModel.h"
#import "HZTResumeModel.h"
#import "HZTTrainModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTPersonJobFullModel : HZTBaseModel
/***/
@property (nonatomic, copy) NSString * perInduName;
/***/
@property (nonatomic, copy) NSString * perPayStName;
/***/
@property (nonatomic, copy) NSString * workArdessY;
/***/
@property (nonatomic, copy) NSString * workArdessX;
/***/
@property (nonatomic, copy) NSString * jobWorkYear;
/***/
@property (nonatomic, copy) NSString * personJobId;
/***/
@property (nonatomic, copy) NSString * personJobWork;
/***/
@property (nonatomic, copy) NSString * personToggle;
/***/
@property (nonatomic, copy) NSString * personIndustry;
/***/
@property (nonatomic, copy) NSString * personFunction;
/***/
@property (nonatomic, copy) NSString * perFunName;
/***/
@property (nonatomic, copy) NSString * personPayStart;
/***/
@property (nonatomic, copy) NSString * personWorkArdess;
/***/
@property (nonatomic, copy) NSString * perWorkArName;
/***/
@property (nonatomic, copy) NSString * reportEnd;
/**技能列表*/
@property (nonatomic, strong) NSArray <HZTSkillModel *>* skillList;
/**教育经历*/
@property (nonatomic, strong) NSArray <HZTTrainModel *>* trainList;
/**工作经历*/
@property (nonatomic, strong) NSArray <HZTResumeModel *>* resumeList;
/**项目经验*/
@property (nonatomic, strong) NSArray <HZTProjiectModel *>* projiectList;

@end

NS_ASSUME_NONNULL_END
