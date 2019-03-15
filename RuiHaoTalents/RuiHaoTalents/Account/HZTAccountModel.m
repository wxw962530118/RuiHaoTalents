//
//  HZTAccountModel.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/15.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTAccountModel.h"

@implementation HZTAccountModel
+ (NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"mobile":@"userName"};
}
@end
