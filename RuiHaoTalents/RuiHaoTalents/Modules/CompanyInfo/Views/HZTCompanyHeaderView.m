//
//  HZTCompanyHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/26.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCompanyHeaderView.h"

@interface HZTCompanyHeaderView ()
/***/
@property (nonatomic, strong) UIImageView * headerBackView;
@end

@implementation HZTCompanyHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addHeaderBackView];
    }
    return self;
}

-(void)addHeaderBackView{
    if (!_headerBackView) {
        _headerBackView = [[UIImageView alloc] init];
        _headerBackView.frame = self.bounds;
        _headerBackView.image = [UIImage imageNamed:@"company_logo"];
        [self addSubview:_headerBackView];
    }
}

-(void)setOffSetY:(CGFloat)offSetY{
    _offSetY = offSetY;
    CGFloat totalOffset = self.height + ABS(offSetY);
    CGFloat f = totalOffset / self.height;
    /**拉伸后的图片的frame应该是同比例缩放*/
    _headerBackView.frame = CGRectMake(- (self.width * f - self.width) / 2, offSetY, self.width * f, totalOffset);
}

@end
