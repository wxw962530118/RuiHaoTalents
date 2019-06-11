//
//  HZTNavView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/26.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTNavView.h"

@interface HZTNavView ()
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UILabel  * titleLabel;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, copy) void (^Block)(void);
@end

@implementation HZTNavView

-(instancetype)initWithFrame:(CGRect)frame callBack:(void(^)(void))callBack{
    if (self = [super initWithFrame:frame]) {
        self.Block = callBack;
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    [self addBackButton];
    [self addTitleLabel];
}

-(void)addBackButton{
    if (!_backButton) {
        _backButton = [[UIButton alloc]init];
        [_backButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        _backButton.minHitTestWidth = 54;
        _backButton.minHitTestHeight = 54;
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.equalTo(self.mas_left).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
    }
}

-(void)addTitleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = HZTFontSize(17);
        _titleLabel.textColor = [HZTColorEmphasis colorWithAlphaComponent:0];;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(_backButton.mas_centerY);
        }];
    }
}

-(void)clickBack{
    if (self.Block) self.Block();
}

-(void)setNavBarWithAlpha:(CGFloat )alpha{
    self.backgroundColor = [HZTColorWhiteGround colorWithAlphaComponent:alpha];
    self.titleLabel.textColor = [HZTColorEmphasis colorWithAlphaComponent:alpha];
}

-(void)setNavTitle:(NSString *)title{
    self.titleLabel.text = title;
}

@end
