//
//  HZTChoosePostController.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZTChoosePostController : HZTBaseViewController
/***/
@property (nonatomic, copy) void (^callBack)(NSString * secondId,NSString * thirdId,NSString * thirdName);
@end

NS_ASSUME_NONNULL_END
