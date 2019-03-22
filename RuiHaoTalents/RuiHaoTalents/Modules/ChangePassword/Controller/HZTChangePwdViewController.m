//
//  HZTChangePwdViewController.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/21.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTChangePwdViewController.h"

#import "HZTChangePwdView.h"

#import "UILabel+TextHelper.h"

@interface HZTChangePwdViewController ()

@property (nonatomic, strong) HZTChangePwdView *phoneView;

@property (nonatomic, strong) HZTChangePwdView *pwdView;

@property (nonatomic, strong) HZTChangePwdView *verView;

@property (nonatomic, strong) UILabel *serviceLabel;

@property (nonatomic, strong) UIButton *updateBtn;

@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, copy) NSString *pwd;

@property (nonatomic, copy) NSString *code;

@end

@implementation HZTChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self addSubviews];
    
}

#pragma mark --- private

- (void)setupNav {
    self.navigationItem.title = @"修改密码";
}

- (void)addSubviews {
    self.view.backgroundColor = HZTColorBackGround;
    
    [self addPhoneView];
    [self addPwdView];
    [self addVerView];
    [self addServiceLabel];
    [self addUpdateBtn];
    [self addTipsLabel];
}

- (void)updateBtnClick {
    // MARK: 修改密码
    NSLog(@"手机号码：%@", [HZTAccountManager getUser].mobile);
    NSLog(@"密码：%@", self.pwd);
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
- (void)addPhoneView {
    if (!_phoneView) {
        _phoneView = [[HZTChangePwdView alloc] init];
        _phoneView.text = [HZTAccountManager getUser].formateMobile;
        _phoneView.hiddenView = NO;
        _phoneView.isEnabled = NO;
        _phoneView.isAddTarget = YES;
        [_phoneView addTargetWithView:^{
            NSLog(@"点击手机号码跳转");
        }];
        [self.view addSubview:_phoneView];
        [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(41);
            make.left.equalTo(self.view).offset(25);
            make.height.mas_equalTo(51);
        }];
    }
}

- (void)addPwdView {
    if (!_pwdView) {
        _pwdView = [[HZTChangePwdView alloc] init];
        _pwdView.leftImgName = @"peofile_setting_pwd";
        _pwdView.placeholder = @"请输入新的密码";
        _pwdView.maxLength = 8;
        _pwdView.secureTextEntry = YES;
        WS(weakSelf)
        [_pwdView addTextDidChangeHandler:^(HZTTextField * _Nonnull textField) {
            weakSelf.pwd = textField.text;
        }];
        [_pwdView addTextLengthDidMaxHandler:^(HZTTextField * _Nonnull textField) {
            NSLog(@"密码输入达到最大限制");
        }];
        [self.view addSubview:_pwdView];
        [_pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.phoneView.mas_bottom).offset(21);
            make.left.equalTo(self.view).offset(25);
            make.height.mas_equalTo(51);
        }];
    }
}

- (void)addVerView {
    if (!_verView) {
        _verView = [[HZTChangePwdView alloc] init];
        _verView.leftImgName = @"profile_setting_ver";
        _verView.placeholder = @"验证码";
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
            make.top.equalTo(self.pwdView.mas_bottom).offset(21);
            make.left.equalTo(self.view).offset(25);
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
        [_updateBtn setTitle:@"确认并修改密码" forState:(UIControlStateNormal)];
        [_updateBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _updateBtn.titleLabel.font = HZTFontSize(15);
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
        _tipsLabel.text = @"修改密码后将使用新的密码进行登录";
        _tipsLabel.font = HZTFontSize(12);
        _tipsLabel.textColor = [UIColor gray];
        [self.view addSubview:_tipsLabel];
        [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.updateBtn.mas_bottom).offset(28);
        }];
    }
}

@end
