//
//  HZTAboutMeViewController.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/20.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTAboutMeViewController.h"

@interface HZTAboutMeViewController ()

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) UIImageView *logoImgView;

@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, strong) UILabel *versionLabel;

@property (nonatomic, strong) UILabel *verNoLabel;

@end

@implementation HZTAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self addSubviews];
}

#pragma mark --- private

- (void)setupNav {
    self.navigationItem.title = @"关于我们";
}

- (void)addSubviews {
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.logoImgView];
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.verNoLabel];
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(65);
        make.size.mas_equalTo(CGSizeMake(83, 83));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.logoImgView.mas_bottom).offset(40);
        make.left.equalTo(self.view);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(34);
        make.left.equalTo(self.view);
    }];
    
    [self.verNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.versionLabel.mas_bottom).offset(9);
        make.left.equalTo(self.view);
    }];
}

#pragma mark --- 懒加载相关

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.image = [UIImage imageNamed:@"profile_aboutme_bg"];
        _bgImgView.userInteractionEnabled = YES;
    }
    return _bgImgView;
}

- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] init];
        _logoImgView.image = [UIImage imageNamed:@"default_logo"];
    }
    return _logoImgView;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.textColor = [UIColor gray];
        _tipsLabel.text = @"精准高效的互联网招聘神器";
        _tipsLabel.font = [UIFont systemFontOfSize:16];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

- (UILabel *)versionLabel {
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.text = @"version";
        _versionLabel.textColor = [UIColor fucDark];
        _versionLabel.font = [UIFont systemFontOfSize:13];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLabel;
}

- (UILabel *)verNoLabel {
    if (!_verNoLabel) {
        _verNoLabel = [[UILabel alloc] init];
        _verNoLabel.text = [NSString appVersion];
        _verNoLabel.textColor = [UIColor fucDark];
        _verNoLabel.font = [UIFont systemFontOfSize:13];
        _verNoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _verNoLabel;
}

@end
