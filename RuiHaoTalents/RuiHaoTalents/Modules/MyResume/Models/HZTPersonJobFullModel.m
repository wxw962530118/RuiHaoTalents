//
//  HZTPersonJobFullModel.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTPersonJobFullModel.h"

@implementation HZTPersonJobFullModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"skillList" : [HZTSkillModel class],@"projiectList" : [HZTProjiectModel class],@"resumeList" : [HZTResumeModel class],@"trainList" : [HZTTrainModel class]};
}
@end
