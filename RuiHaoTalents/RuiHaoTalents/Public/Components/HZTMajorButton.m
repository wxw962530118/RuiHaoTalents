//
//  HZTMajorButton.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMajorButton.h"

@interface HZTMajorButton (){
    UIColor *_normalBackgroundColor;
    UIColor *_highlightBackgroundColor;
    UIColor *_invalidBackgroundColor;
    UIColor *_fontNormalColor;
    UIColor *_fontInvalidColor;
    UIFont  *_font;
}

@end

@implementation HZTMajorButton

- (void)initParameter{
    _normalBackgroundColor = HZTMainColor;
    _highlightBackgroundColor = RGBColor(60,170,160);
    _invalidBackgroundColor = RGBColor(181, 181, 181);
    _fontNormalColor = HZTColorWhiteGround;
    _fontInvalidColor = HZTColorEmphasis;
    _font = HZTFontSize(17);
    _isInvalid = NO;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initParameter];
        [self configItems];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initParameter];
        [self configItems];
    }
    return self;
}

- (void)configItems{
    self.titleLabel.font = _font;
    [self setTitleColor:_fontNormalColor forState:UIControlStateNormal];
    [self setBackgroundImage:ToolGetImageWithColor(_normalBackgroundColor) forState:UIControlStateNormal];
    [self setBackgroundImage:ToolGetImageWithColor(_highlightBackgroundColor) forState:UIControlStateHighlighted];
}

- (void)setIsInvalid:(BOOL)isInvalid{
    _isInvalid = isInvalid;
    if (isInvalid) {
        self.userInteractionEnabled = NO;
        [self setTitleColor:_fontInvalidColor forState:UIControlStateNormal];
        [self setBackgroundImage:ToolGetImageWithColor(_invalidBackgroundColor) forState:UIControlStateNormal];
    }else {
        self.userInteractionEnabled = YES;
        [self setTitleColor:_fontNormalColor forState:UIControlStateNormal];
        [self setBackgroundImage:ToolGetImageWithColor(_normalBackgroundColor) forState:UIControlStateNormal];
    }
}

@end
