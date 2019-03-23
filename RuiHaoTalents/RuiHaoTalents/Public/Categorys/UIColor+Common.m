//
//  UIColor+Common.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/20.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "UIColor+Common.h"

@implementation UIColor (Common)

+ (UIColor *)dark {
    return [UIColor colorWithHexString:@"#333333"];
}

+ (UIColor *)gray {
    return [UIColor colorWithHexString:@"#666666"];
}

+ (UIColor *)fucDark {
    return [UIColor colorWithHexString:@"#999999"];
}

+ (UIColor *)placeholder {
    return [UIColor colorWithHexString:@"#D4D4D4"];
}

+ (UIColor *)line {
    return [UIColor colorWithHexString:@"#E8E8E8"];
}
@end
