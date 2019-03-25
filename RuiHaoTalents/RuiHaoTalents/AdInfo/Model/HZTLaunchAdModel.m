//
//  HZTLaunchAdModel.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTLaunchAdModel.h"

@implementation HZTLaunchAdModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.content = dict[@"content"];
        self.openUrl = dict[@"openUrl"];
        self.duration = [dict[@"duration"] integerValue];
        self.contentSize = dict[@"contentSize"];
    }
    return self;
}
-(CGFloat)width{
    return [[[self.contentSize componentsSeparatedByString:@"*"] firstObject] floatValue];
}

-(CGFloat)height{
    return [[[self.contentSize componentsSeparatedByString:@"*"] lastObject] floatValue];
}
@end
