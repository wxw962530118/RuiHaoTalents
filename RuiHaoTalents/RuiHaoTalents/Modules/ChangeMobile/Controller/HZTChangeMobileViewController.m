//
//  HZTChangeMobileViewController.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/22.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTChangeMobileViewController.h"

#import "HZTChangePwdView.h"

#import "UILabel+TextHelper.h"

@interface HZTChangeMobileViewController ()

@property (nonatomic, strong) UILabel *tipsMobileLabel;

@property (nonatomic, strong) UILabel *mobileLabel;

@property (nonatomic, strong) HZTChangePwdView *phoneView;

@property (nonatomic, strong) HZTChangePwdView *verView;

@property (nonatomic, strong) UILabel *serviceLabel;

@property (nonatomic, strong) UIButton *updateBtn;

@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *code;

@end

@implementation HZTChangeMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self addSubviews];
}

#pragma mark --- private

- (void)setupNav {
    self.navigationItem.title = @"更换手机";
}

- (void)addSubviews {
    self.view.backgroundColor = HZTColorBackGround;
    
    [self addTipsMobileLabel];
    [self addMobileLabel];
    [self addPhoneView];
    [self addVerView];
    [self addServiceLabel];
    [self addUpdateBtn];
    [self addTipsLabel];
}

- (void)updateBtnClick {
    // MARK: 修改密码
    NSLog(@"旧手机号码：%@", [HZTAccountManager getUser].mobile);
    NSLog(@"新手机号码：%@", self.mobile);
    NSLog(@"验证码：%@", self.code);
}

- (NSMutableAttributedString *)att {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    NSAttributedString *tipsAtt = [[NSAttributedString alloc] initWithString:@"长时间收不到验证码，" attributes:@{NSFontAttributeName: HZTFontSize(12), NSForegroundColorAttributeName: [UIColor dark], NSObliquenessAttributeName: @(0)}];
    
    NSAttributedString *serviceAtt = [[NSAttributedString alloc] initWithString:@"联系客服" attributes:@{NSFontAttributeName: HZTFontSize(12), NSForegroundColorAttributeName: HZTMainColor, NSObliquenessAttributeName: @(0.01)}];
    
    [attributedString appendAttributedString:tipsAtt];
    [attributedString appendAttributedString:serviceAtt];
    return attributedString;
}

#pragma mark --- 懒加载相关
- (void)addTipsMobileLabel {
    if (!_tipsMobileLabel) {
        _tipsMobileLabel = [[UILabel alloc] init];
        _tipsMobileLabel.text = @"当前绑定手机号";
        _tipsMobileLabel.font = HZTFontSize(12);
        _tipsMobileLabel.textColor = [UIColor gray];
        [self.view addSubview:_tipsMobileLabel];
        [_tipsMobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(42);
        }];
    }
}

- (void)addMobileLabel {
    if (!_mobileLabel) {
        _mobileLabel = [[UILabel alloc] init];
        _mobileLabel.text = [HZTAccountManager getUser].formateMobile;
        _mobileLabel.font = HZTFontSize(18);
        _mobileLabel.textColor = [UIColor dark];
        [self.view addSubview:_mobileLabel];
        [_mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.tipsMobileLabel.mas_bottom).offset(12);
        }];
    }
}

- (void)addPhoneView {
    if (!_phoneView) {
        _phoneView = [[HZTChangePwdView alloc] init];
        _phoneView.placeholder = @"请输入新手机号";
        _phoneView.maxLength = 11;
        _phoneView.keyboardType = UIKeyboardTypeNumberPad;
        WS(weakSelf)
        [_phoneView addTextDidChangeHandler:^(HZTTextField * _Nonnull textField) {
            weakSelf.mobile = textField.text;
        }];
        [_phoneView addTextLengthDidMaxHandler:^(HZTTextField * _Nonnull textField) {
            NSLog(@"手机号输入达到最大限制");
        }];
        [self.view addSubview:_phoneView];
        [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.mobileLabel.mas_bottom).offset(31);
            make.left.equalTo(self.view).offset(15);
            make.height.mas_equalTo(51);
        }];
    }
}

- (void)addVerView {
    if (!_verView) {
        _verView = [[HZTChangePwdView alloc] init];
        _verView.leftImgName = @"profile_setting_ver";
        _verView.placeholder = @"验证码";
        _verView.keyboardType = UIKeyboardTypeNumberPad;
        _verView.hiddenCodeView = NO;
        _verView.maxLength = 6;
        WS(weakSelf)
        [_verView addTextDidChangeHandler:^(HZTTextField * _Nonnull textField) {
            weakSelf.code = textField.text;
            
        }];
        [_verView addTextLengthDidMaxHandler:^(HZTTextField * _Nonnull textField) {
            NSLog(@"验证码输入达到最大限制");
        }];
        [self.view addSubview:_verView];
        [_verView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.phoneView.mas_bottom).offset(21);
            make.left.equalTo(self.view).offset(15);
            make.height.mas_equalTo(51);
        }];
    }
}

- (void)addServiceLabel {
    if (!_serviceLabel) {
        _serviceLabel = [[UILabel alloc] init];
        _serviceLabel.attributedText = [self att];
        _serviceLabel.font = HZTFontSize(12);
        _serviceLabel.hzt_tapBlock = ^(NSInteger index, NSAttributedString * _Nonnull charAttributedString) {
            NSRange ra = NSMakeRange(0, 1);
            NSNumber *obliqueness = [charAttributedString attribute:NSObliquenessAttributeName atIndex:0 effectiveRange:&ra];
            if ([obliqueness isEqualToNumber:@(0.01)]) {
                NSLog(@"联系客服");
            }
        };
        [self.view addSubview:_serviceLabel];
        [_serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.verView.mas_bottom).offset(20);
        }];
    }
}

- (void)addUpdateBtn {
    if (!_updateBtn) {
        _updateBtn = [[UIButton alloc] init];
        [_updateBtn setTitle:@"确认修改手机号" forState:(UIControlStateNormal)];
        [_updateBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _updateBtn.titleLabel.font = HZTFontSize(16);
        _updateBtn.backgroundColor = HZTMainColor;
        _updateBtn.layer.cornerRadius = 5;
        _updateBtn.layer.masksToBounds = YES;
        [_updateBtn addTarget:self action:@selector(updateBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_updateBtn];
        [_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.serviceLabel.mas_bottom).offset(50);
            make.right.equalTo(self.view).offset(-15);
            make.height.mas_equalTo(46);
        }];
    }
}

- (void)addTipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.text = @"修改手机号码后将使用新手机号进行登录\n\n个人简历的电话联系方式也一同改为新手机号码";
        _tipsLabel.font = HZTFontSize(12);
        _tipsLabel.textColor = [UIColor gray];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_tipsLabel];
        [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.updateBtn.mas_bottom).offset(28);
        }];
    }
}

@end
