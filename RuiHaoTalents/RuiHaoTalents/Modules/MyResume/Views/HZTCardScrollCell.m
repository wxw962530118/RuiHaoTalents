//
//  HZTCardScrollCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/17.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCardScrollCell.h"
#import "HZTHorScrollCardView.h"
@interface HZTCardScrollCell ()
/***/
@property (nonatomic, strong) UIScrollView * mainScrollView;

@end

@implementation HZTCardScrollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addMainScrollView];
}

-(void)addMainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:_mainScrollView];
        [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.contentView);
        }];
        
        for (int i = 0; i< 4; i++) {
            HZTHorScrollCardView * view = [HZTHorScrollCardView createHorScrollCardView];
            view.layer.cornerRadius = 5;
            view.frame = CGRectMake((i+1)*15 + i*344,0, 344, 114);
            view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
            [_mainScrollView addSubview:view];
            if (i==3) {
                _mainScrollView.contentSize = CGSizeMake(CGRectGetMaxX(view.frame),0);
            }
        }
    }
}

@end
