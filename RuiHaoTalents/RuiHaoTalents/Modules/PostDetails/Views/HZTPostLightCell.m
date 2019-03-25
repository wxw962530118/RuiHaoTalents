//
//  HZTPostLightCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTPostLightCell.h"
#import "HZTTagView.h"

@interface HZTPostLightCell ()
/***/
@property (nonatomic, strong) HZTTagView * collectionView;

@end

@implementation HZTPostLightCell

-(void)loadWithComponents{
    [self addCollectionView];
}

-(void)addCollectionView{
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top);
    }];
}

-(HZTTagView *)collectionView{
    WS(weakSelf)
    if (!_collectionView) {
        _collectionView = [HZTTagView createCollectionView];
        _collectionView.changed = ^(CGFloat height) {
            weakSelf.changed(height);
        };
    }
    return _collectionView;
}

-(void)setArray:(NSArray<HZTTagViewModel *> *)array{
    _array = array;
    self.collectionView.dataArray = array;
}

@end
