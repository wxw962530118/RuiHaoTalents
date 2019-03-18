//
//  HZTMyResumeListModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"
#import "HZTPersonJobFullModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HZTMyResumeListModel : HZTBaseModel
/**是否认证0.未认证、1.已认证*/
@property (nonatomic, copy) NSString * nameAuthent;
/**年龄*/
@property (nonatomic, copy) NSString * humanAge;
/**头像*/
@property (nonatomic, copy) NSString * humanImage;
/**性别*/
@property (nonatomic, copy) NSString * humanSex;
/**姓名*/
@property (nonatomic, copy) NSString * humanName;
/**微信号*/
@property (nonatomic, copy) NSString * humanWeChat;
/**生日*/
@property (nonatomic, copy) NSString * humanBirthday;
/**手机号码*/
@property (nonatomic, copy) NSString * humanPhone;
/**邮箱*/
@property (nonatomic, copy) NSString * humanEmail;
/**学历ID*/
@property (nonatomic, copy) NSString * diplomaId;
/**学历名称*/
@property (nonatomic, copy) NSString * diplomaName;
/***/
@property (nonatomic, strong) HZTPersonJobFullModel * personJobFullVO;
@end

NS_ASSUME_NONNULL_END
