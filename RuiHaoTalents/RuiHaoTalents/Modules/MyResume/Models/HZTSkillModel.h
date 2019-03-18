//
//  HZTSkillModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTSkillModel : HZTBaseModel
/**主键ID*/
@property (nonatomic, copy) NSString * personSkillId;
/**技能ID*/
@property (nonatomic, copy) NSString * skillsId;
/**技能名称*/
@property (nonatomic, copy) NSString * skillsName;
/**技能值*/
@property (nonatomic, copy) NSString * skillsValue;

@end

NS_ASSUME_NONNULL_END
