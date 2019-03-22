//
//  HZTTextField.h
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/21.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HZTTextField;
typedef void(^HZTTextFieldHandler)(HZTTextField *textField);

@interface HZTTextField : UITextField

/** 能否被复制 默认为NO */
@property (nonatomic, assign) BOOL canBeCopied;
/** 能否被粘贴 默认为NO */
@property (nonatomic, assign) BOOL canBePasted;
/** 能否被剪切 默认为NO */
@property (nonatomic, assign) BOOL canBeCut;
/** 能否被选择 默认为YES */
@property (nonatomic, assign) BOOL canBeSelected;
/** 能否被全选 默认为NO */
@property (nonatomic, assign) BOOL canBeAllSelected;

/** 最大限制文本长度, 默认不限制长度 */
@property (nonatomic, assign) NSUInteger maxLength;

/**
 设定文本改变Block回调
 
 @param eventHandler 回调
 */
- (void)addTextDidChangeHandler:(HZTTextFieldHandler)eventHandler;

/**
 设定文本达到最大长度的回调
 
 @param maxHandler 回调
 */
- (void)addTextLengthDidMaxHandler:(HZTTextFieldHandler)maxHandler;

@end

NS_ASSUME_NONNULL_END
