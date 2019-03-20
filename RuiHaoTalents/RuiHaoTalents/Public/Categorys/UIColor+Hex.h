//
//  UIColor+Hex.h
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/20.
//  Copyright © 2019 王新伟. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
