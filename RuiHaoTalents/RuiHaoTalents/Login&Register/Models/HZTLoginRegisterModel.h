//
//  HZTLoginRegisterModel.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTLoginRegisterModel : HZTBaseModel
/***/
@property (nonatomic, copy) NSString * phone;
/***/
@property (nonatomic, assign) BOOL isShowGetCode;
/***/
@property (nonatomic, copy) NSString * iconName;
/***/
@property (nonatomic, copy) NSString * placeholder;
@end

NS_ASSUME_NONNULL_END
