//
//  HZTTagView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTTagView.h"
#import "HZTTagViewCell.h"
@interface HZTTagView ()<UICollectionViewDataSource,UICollectionViewDelegate>
/***/
@property (nonatomic, strong) UICollectionView * mainCollectionView;
/***/
@property (nonatomic,assign) float height;
@end

@implementation HZTTagView
+ (instancetype)createCollectionView{
    HZTTagView * cView = [[HZTTagView alloc] init];
    return cView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _height = 0;
        HZTFlowLayout * layout = [[HZTFlowLayout alloc]initWithType:AlignWithLeft betweenOfCell:13];
        self.mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        self.mainCollectionView.backgroundColor = HZTColorWhiteGround;
        self.mainCollectionView.delegate = self;
        self.mainCollectionView.dataSource = self;
        [self.mainCollectionView registerClass:[HZTTagViewCell class] forCellWithReuseIdentifier:@"HZTTagViewCell"];
        [self addSubview:self.mainCollectionView];
        [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.mainCollectionView.superview).with.insets(UIEdgeInsetsMake(28,0,0,0));
        }];
        [self.mainCollectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)(self.mainCollectionView)];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    CGFloat height = self.mainCollectionView.contentSize.height;
    if (height > 0) {
        [self.mainCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height).priority(500);
        }];
        int nowHeight = (int)height;
        int oldHeight = (int)_height;
        if (nowHeight != oldHeight) {
            if (_changed) _changed(nowHeight);
        }
    }
    _height = self.mainCollectionView.contentSize.height;
}

-(void)setDataArray:(NSArray<HZTTagViewModel *> *)dataArray{
    _dataArray = dataArray;
    [self.mainCollectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HZTTagViewCell * cell = [HZTTagViewCell creatListCell:collectionView indexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

#pragma mark --- 每个items的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    /**默认size 宽度根据文字内容计算*/
    CGFloat width = [ToolBaseClass getWidthWithString:self.dataArray[indexPath.item].name font:HZTFontSize(15)] + 20;
    if (width > kScreenW - 40) {
        width = kScreenW - 40;
    }
    CGFloat height = 30;
    return CGSizeMake(width,height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"currentTitle:%@",self.dataArray[indexPath.item].name);
}

#pragma mark --- 整体边距的优先级 始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0, 0, 0);
}

-(void)dealloc{
    [self.mainCollectionView removeObserver:self forKeyPath:@"contentSize"];
}

@end
