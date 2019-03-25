//
//  HZTMyWalletHeaderView.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/25.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTMyWalletHeaderView.h"

@interface HZTMyWalletHeaderView ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIButton *withdrawalBtn;

@end

@implementation HZTMyWalletHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    [self addImgView];
    [self addBalance];
    [self addLineView];
    [self addMoneyLabel];
    [self addWithdrawalBtn];
}

- (void)withdrawalClick {
    NSLog(@"提现");
}

- (void)addImgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"profile_mywallet_bg"];
        _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

- (void)addBalance {
    if (!_balanceLabel) {
        _balanceLabel = [[UILabel alloc] init];
        _balanceLabel.text = @"账户余额(元)";
        _balanceLabel.font = HZTFontSizeBold(18);
        _balanceLabel.textColor = RGBColor(155, 255, 235);
        _balanceLabel.textAlignment = NSTextAlignmentCenter;
        [self.imgView addSubview:_balanceLabel];
        [_balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.imgView);
            make.top.equalTo(self.imgView).offset(27);
        }];
    }
}

- (void)addLineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGBColor(155, 255, 235);
        [self.imgView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.imgView);
            make.top.equalTo(self.balanceLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(19, 1));
        }];
    }
}

- (void)addMoneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.text = @"1234.55";
        _moneyLabel.font = HZTFontSizeBold(40);
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        [self.imgView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.imgView);
            make.top.equalTo(self.lineView.mas_bottom).offset(10);
        }];
    }
}

- (void)addWithdrawalBtn {
    if (!_withdrawalBtn) {
        _withdrawalBtn = [[UIButton alloc] init];
        [_withdrawalBtn setImage:[UIImage imageNamed:@"profile_mywallet_withdrawal"] forState:(UIControlStateNormal)];
        [_withdrawalBtn addTarget:self action:@selector(withdrawalClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.imgView addSubview:_withdrawalBtn];
        [_withdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.imgView);
            make.top.equalTo(self.moneyLabel.mas_bottom).offset(19);
            make.size.mas_equalTo(CGSizeMake(113, 45));
        }];
    }
}

@end
