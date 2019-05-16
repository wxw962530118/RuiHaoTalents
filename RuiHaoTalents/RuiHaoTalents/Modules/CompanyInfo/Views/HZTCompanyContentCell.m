//
//  HZTCompanyContentCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/26.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCompanyContentCell.h"

@interface HZTCompanyContentCell ()<UIScrollViewDelegate>
/**/
@property (nonatomic, strong) UIScrollView * mainScrollView;

@end

@implementation HZTCompanyContentCell

-(void)loadWithComponents{
    //[self addMainScrollView];
}

-(void)addMainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, kScreenW, kScreenH - 214)];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.contentSize = CGSizeMake(0,1000);
        _mainScrollView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_mainScrollView];
        for (int i = 0; i< 2; i++) {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i * kScreenW,0, kScreenW, 1000)];
            view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
            [_mainScrollView addSubview:view];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (self.Block) {
//        self.Block(scrollView.contentOffset.y);
//    }
}

@end
