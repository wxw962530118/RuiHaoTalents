//
//  HZTTestNavView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/6/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTTestNavView.h"

@interface HZTTestNavView ()
/***/
@property (nonatomic, strong) UILabel * titleLabel;
/***/
@property (nonatomic, strong) UIVisualEffectView * effectView;
@end

@implementation HZTTestNavView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addEffectView];
        [self configInit];
        [self addTitleLabel];
    }
    return self;
}

-(void)addTitleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = RGBColor(51, 51, 51);
        _titleLabel.font = HZTFontSizeBold(18);
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
        }];
    }
}

-(void)configInit{
    self.backgroundColor = RGBColorAlpha(255, 255, 255, .5);
}

-(void)addEffectView{
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _effectView.frame = self.bounds;
        [self insertSubview:_effectView atIndex:0];
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

@end
