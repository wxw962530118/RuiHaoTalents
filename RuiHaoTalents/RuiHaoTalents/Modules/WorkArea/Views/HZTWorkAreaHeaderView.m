//
//  HZTWorkAreaHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTWorkAreaHeaderView.h"

@interface HZTWorkAreaHeaderView ()
/***/
@property (nonatomic, strong) UILabel * currentAddressLabel;
/***/
@property (nonatomic, strong) UIView * lineView;
/***/
@property (nonatomic, strong) UILabel * currentCityLabel;
@end

@implementation HZTWorkAreaHeaderView
-(instancetype )initWithFrame:(CGRect)frame{
    //49 + 24 + 20
    if (self = [super initWithFrame:frame]) {
        [self addCurrentAddressLabel];
        [self addLineView];
        [self addCurrentCityLabel];
    }
    return self;
}

-(void)addCurrentAddressLabel{
    if (!_currentAddressLabel) {
        _currentAddressLabel = [[UILabel alloc] init];
        _currentAddressLabel.text = @"";
        _currentAddressLabel.font = HZTFontSize(15);
        _currentAddressLabel.textColor = RGBColor(102, 102, 102);
        [self addSubview:_currentAddressLabel];
        [_currentAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.top.equalTo(self.mas_top).offset(20);
        }];
    }
}

-(void)addLineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HZTColorComponentLine;
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.top.equalTo(_currentAddressLabel.mas_bottom).offset(20);
        }];
    }
}

-(void)addCurrentCityLabel{
    
}

@end
