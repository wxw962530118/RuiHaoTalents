//
//  HZTExpectJobViewController.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTExpectJobViewController : HZTBaseViewController

/**
 初始化期望工作
 @param expectJobName  期望职位
 @param payName        薪资
 */
-(instancetype)initWithExpectJobName:(NSString *)expectJobName payName:(NSString *)payName callBack:(void (^)(NSString * postName,NSString *payName,NSString *payId,NSString * personIndustry,NSString *personFunction))callBack;
@end

NS_ASSUME_NONNULL_END
