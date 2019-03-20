//
//  NSString+Common.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/20.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

+ (NSString *)appVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

@end
