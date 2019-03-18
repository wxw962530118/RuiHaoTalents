//
//  HZTAccountModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/15.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTAccountModel : HZTBaseModel
/**用户手机号码*/
@property (nonatomic, copy) NSString * mobile;
/**用户token*/
@property (nonatomic, copy) NSString * token;
/**用户密码*/
@property (nonatomic, copy) NSString * passWord;
/**登录用户类型 0 个人 1 企业*/
@property (nonatomic, assign) int userType;
/***/
@property (nonatomic, copy) NSString * humanId;
/***/
@property (nonatomic, copy) NSString * userIcon;
@end

NS_ASSUME_NONNULL_END
