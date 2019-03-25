//
//  NSArray+Common.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/25.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "NSArray+Common.h"

@implementation NSArray (Common)

- (BOOL)isEmpty {
    return self == nil || [self isKindOfClass:[NSNull class]] || self.count == 0;
}

@end
