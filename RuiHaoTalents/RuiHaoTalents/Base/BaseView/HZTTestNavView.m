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
@property (nonatomic, strong) UIVisualEffectView * effectView;
@end

@implementation HZTTestNavView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addEffectView];
        [self configInit];
    }
    return self;
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

@end
