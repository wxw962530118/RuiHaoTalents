//
//  HZTTopTabView.m
//  KidsEvaluation
//
//  Created by 王新伟 on 2018/12/17.
//  Copyright © 2018年 haizitong. All rights reserved.
//

#import "HZTTopTabView.h"
#import "HZTTopTabCollectionCell.h"

@interface HZTTopTabView ()<UICollectionViewDelegate,UICollectionViewDataSource>
/***/
@property (nonatomic, strong) UICollectionView * mainCollectionView;
/**选中回调*/
@property (nonatomic, copy) void (^Block)(HZTTopTabModel * model);
/**/
@property (nonatomic, strong) HZTTopTabCollectionCell * lastSelectCell;
/***/
@property (nonatomic, assign) NSInteger didSelIndex;
@end

@implementation HZTTopTabView

-(instancetype)initWithCallBack:(void (^)(HZTTopTabModel * _Nonnull))callBack{
    if (self = [super init]) {
        self.didSelIndex = 0;
        self.Block = callBack;
        self.itemMargin = 15;
    }
    return self;
}

-(void)setDataArray:(NSArray<HZTTopTabModel *> *)dataArray{
    _dataArray = dataArray;
    if (self.isUserHandel) {
        [self handleDefaultSelectedFitstItem];
        return;
    }
    if (self.alignType == AlignmentType_Center) {
        /**针对居中样式特殊处理*/
        CGFloat totalW = 0;
        for (int i = 0; i< dataArray.count; i++) {
            HZTTopTabModel * model = dataArray[i];
            model.itemW = [ToolBaseClass getWidthWithString:model.title font:HZTFontSize(16)];
            totalW += model.itemW;
        }
        /**所有的item的宽度 + 所有item的间距 + 左右边距 collection的总宽度*/
        totalW += (dataArray.count - 1) * self.itemMargin + 2 * 25;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.superview.mas_centerX);
            make.bottom.equalTo(self.superview.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(totalW,60));
        }];
    }else{
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.superview).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    [self handleDefaultSelectedFitstItem];
}

#pragma mark --- 默认选中第一个
-(void)handleDefaultSelectedFitstItem{
    [self.mainCollectionView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self collectionView:self.mainCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    });
}

-(void)layoutSubviews{
    [super layoutSubviews];
    /**重新布局*/
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    [self collectionView:self.mainCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
}

#pragma mark --- 懒加载控件
-(UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        _mainCollectionView.showsHorizontalScrollIndicator = false;
        _mainCollectionView.showsVerticalScrollIndicator = false;
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        [_mainCollectionView registerClass:[HZTTopTabCollectionCell class] forCellWithReuseIdentifier:@"HZTTopTabCollectionCell"];
        [self addSubview:_mainCollectionView];
        [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0,0,0, 0));
        }];
    }
    return _mainCollectionView;
}

#pragma mark --- UICollectionView代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HZTTopTabCollectionCell * cell = [HZTTopTabCollectionCell creatListCell:collectionView indexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

#pragma mark --- 每个items的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.dataArray[indexPath.item].itemW;
    CGFloat height = self.dataArray[indexPath.item].itemH;
    return CGSizeMake(width,height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (HZTTopTabModel * model in self.dataArray) {
        model.isSelectd = false;
    }
    self.dataArray[indexPath.item].isSelectd = true;
    [self.mainCollectionView reloadData];
    if (self.Block && self.didSelIndex != indexPath.item) {
        self.Block(self.dataArray[indexPath.item]);
    }
    if (self.dataArray[indexPath.item].isSelectd) {
        self.didSelIndex = indexPath.item;
    }
}

#pragma mark --- 整体边距的优先级 始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark --- 横向items的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.itemMargin;
}

@end

