//
//  UILabel+TextHelper.h
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/22.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (TextHelper)

@property (nonatomic, copy) void (^hzt_tapBlock)(NSInteger index, NSAttributedString *charAttributedString);

@end

NS_ASSUME_NONNULL_END
