//
//  HZTTextHelper.h
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/22.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTTextHelper : NSObject

/**
 获取UILabel点击的字符
 
 @param location 点击label的位置
 @param label 点击的label
 @param selectedBlock 点击返回
 */
- (void)selectorLocation:(CGPoint)location label:(UILabel *)label selectedBlock:(void (^)(NSInteger index, NSAttributedString *charAttributedString))selectedBlock;

@end

NS_ASSUME_NONNULL_END
