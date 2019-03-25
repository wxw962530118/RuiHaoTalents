//
//  HZTChangePwdView.h
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/21.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZTChangePwdView : UIView

@property (nonatomic, copy) NSString *leftImgName;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) NSString *text;

/** 是否隐藏右边的箭头 */
@property (nonatomic, assign) BOOL hiddenView;

/** 是否隐藏右边的获取验证码按钮 */
@property (nonatomic, assign) BOOL hiddenCodeView;

/** UITextField是否可以编辑 */
@property (nonatomic, assign) BOOL isEnabled;

/** view是否可以点击 */
@property (nonatomic, assign) BOOL isAddTarget;

/** 最大限制文本长度, 默认不限制长度 */
@property (nonatomic, assign) NSUInteger maxLength;

@property (nonatomic, assign) UIKeyboardType keyboardType;
/** 是否暗文输入 */
@property (nonatomic, assign) BOOL secureTextEntry;


/**
 给View添加点击事件
 */
- (void)addTargetWithView:(void(^)(void))target;

- (void)addTargetWithGetCode:(void(^)(UIButton *button))target;

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
