//
//  HZTChangePwdView.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/21.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTChangePwdView.h"

#import "UIButton+Countdown.h"

@interface HZTChangePwdView()

@property (nonatomic, strong) UIImageView *leftImgView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) HZTTextField *textField;

@property (nonatomic, strong) UIImageView *rightImgView;

@property (nonatomic, strong) UIButton *getCodeBtn;

@property (nonatomic, copy) HZTTextFieldHandler changeHandler;

@property (nonatomic, copy) HZTTextFieldHandler maxHandler;

@property (nonatomic, copy) void(^target)(void);

@end

@implementation HZTChangePwdView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    [self addLeftImgView];
    [self addLineView];
    [self addTextField];
    [self addRightImgView];
    [self addGetCodeBtn];
}

- (void)getCodeBtnClick {
    [self.getCodeBtn countdownWithSec:60];
}

- (void)viewClick {
    self.target();
}

#pragma mark - public
- (void)addTextDidChangeHandler:(HZTTextFieldHandler)changeHandler {
    _changeHandler = [changeHandler copy];
}

- (void)addTextLengthDidMaxHandler:(HZTTextFieldHandler)maxHandler {
    _maxHandler = [maxHandler copy];
}

- (void)addTargetWithView:(void(^)(void))target {
    self.target = target;
}

#pragma mark --- setter
- (void)setLeftImgName:(NSString *)leftImgName {
    _leftImgName = leftImgName;
    self.leftImgView.image = [UIImage imageNamed:leftImgName];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textField.text = text;
}

- (void)setHiddenView:(BOOL)hiddenView {
    _hiddenView = hiddenView;
    self.rightImgView.hidden = hiddenView;
}

- (void)setHiddenCodeView:(BOOL)hiddenCodeView {
    _hiddenCodeView = hiddenCodeView;
    self.getCodeBtn.hidden = hiddenCodeView;
}

- (void)setIsEnabled:(BOOL)isEnabled {
    _isEnabled = isEnabled;
    self.textField.enabled = isEnabled;
}

- (void)setMaxLength:(NSUInteger)maxLength {
    _maxLength = maxLength;
    self.textField.maxLength = maxLength;
}

- (void)setIsAddTarget:(BOOL)isAddTarget {
    _isAddTarget = isAddTarget;
    if (isAddTarget) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
        [self addGestureRecognizer:tap];
    }
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    self.textField.keyboardType = keyboardType;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    self.textField.secureTextEntry = secureTextEntry;
}

#pragma mark --- 懒加载相关
- (void)addLeftImgView {
    if (!_leftImgView) {
        _leftImgView = [[UIImageView alloc] init];
        _leftImgView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImgView.image = [UIImage imageNamed:@"profile_setting_phone"];
        [self addSubview:_leftImgView];
        [_leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(25);
            make.size.mas_equalTo(CGSizeMake(19, 22));
        }];
    }
}

- (void)addLineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HZTColorComponentLine;
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.leftImgView.mas_right).offset(15);
            make.top.equalTo(self).offset(16);
            make.width.mas_equalTo(1);
        }];
    }
}

- (void)addTextField {
    if (!_textField) {
        _textField = [[HZTTextField alloc] init];
        _textField.font = HZTFontSize(15);
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.enabled = YES;
        WS(weakSelf)
        [_textField addTextDidChangeHandler:^(HZTTextField * _Nonnull textField) {
            weakSelf.changeHandler(textField);
        }];
        [_textField addTextLengthDidMaxHandler:^(HZTTextField * _Nonnull textField) {
            weakSelf.maxHandler(textField);
        }];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.lineView.mas_right).offset(8);
            make.right.equalTo(self).offset(-100);
            make.top.equalTo(self).offset(10);
        }];
    }
}

- (void)addRightImgView {
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] init];
        _rightImgView.image = [UIImage imageNamed:@"default_gree_arrow"];
        _rightImgView.hidden = YES;
        [self addSubview:_rightImgView];
        [_rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-14);
            make.size.mas_equalTo(CGSizeMake(6, 10));
        }];
    }
}

- (void)addGetCodeBtn {
    if (!_getCodeBtn) {
        _getCodeBtn = [[UIButton alloc] init];
        [_getCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [_getCodeBtn setTitleColor:HZTMainColor forState:(UIControlStateNormal)];
        _getCodeBtn.titleLabel.font = HZTFontSize(15);
        _getCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _getCodeBtn.hidden = YES;
        [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_getCodeBtn];
        [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-13);
            make.size.mas_equalTo(CGSizeMake(90, 30));
        }];
    }
}

@end
