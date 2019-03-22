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

- (NSString *)formateMobile {
    NSString *mobile = @"";
    if ([ToolBaseClass checkPhoneNumberInput:self.mobile]) {
        mobile = [self.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    } else {
        mobile = self.mobile;
    }
    return mobile;
}
@end
