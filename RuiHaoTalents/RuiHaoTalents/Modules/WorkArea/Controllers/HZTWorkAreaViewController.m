//
//  HZTWorkAreaViewController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTWorkAreaViewController.h"
#import "HZTWorkAreaHeaderView.h"
#import "HZTWorkAreaListCell.h"
#import "HZTWorkAreaModel.h"
#import "HZTHomeNetWorkManager.h"
@interface HZTWorkAreaViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/***/
@property (nonatomic, strong) HZTWorkAreaHeaderView * headerView;
/***/
@property (nonatomic, strong) NSMutableArray <HZTWorkAreaModel *>* dataArray;
/***/
@property (nonatomic, strong) UICollectionView * mainCollectionView;
/***/
@property (nonatomic, copy) NSString * cityName;
/***/
@property (nonatomic, copy) NSString * areaName;
/***/
@property (nonatomic, copy) void (^Block)(NSString * str);
@end

@implementation HZTWorkAreaViewController

-(instancetype)initWithCityName:(NSString *)cityName areaName:(NSString *)areaName callBack:(void (^)(NSString * _Nonnull))callBack{
    if (self = [super init]) {
        self.cityName = cityName;
        self.areaName = areaName;
        self.Block = callBack;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工作区域";
    [self getAreaDataInfo];
}

-(void)getAreaDataInfo{
    [HZTToastHUD showLoading];
    [[HZTHomeNetWorkManager manager] requestAreaInfoWithId:@"" succeed:^(id  _Nonnull responseObject) {
        [self.dataArray addObjectsFromArray:[HZTWorkAreaModel mj_objectArrayWithKeyValuesArray:responseObject[@"content"]]];
        for (HZTWorkAreaModel * model in self.dataArray) {
            model.isSelected = [model.name isEqualToString:self.areaName];
        }
        [HZTToastHUD hideLoading];
        [self.mainCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark --- UICollectionView代理
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        HZTWorkAreaHeaderView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HZTWorkAreaHeaderView" forIndexPath:indexPath];
        [header setCityName:self.cityName areaName:self.areaName];
        return header;
    }
    return nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HZTWorkAreaListCell * cell = [HZTWorkAreaListCell creatListCell:collectionView indexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

#pragma mark --- 每个items的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    /**默认size 98*37*/
    CGFloat width  = (kScreenW - 2*20 - 2 * 22)/3;
    CGFloat height = (37 * width)/98;
    return CGSizeMake(width,height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.Block) {
        self.Block(self.dataArray[indexPath.item].name);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 整体边距的优先级 始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(24,20, 0, 20);
}

#pragma mark --- 横向items的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 22;
}

#pragma maek --- 懒加载相关
-(UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.headerReferenceSize = CGSizeMake(kScreenW, 94);
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _mainCollectionView.backgroundColor = HZTColorWhiteGround;
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        [_mainCollectionView registerClass:[HZTWorkAreaHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HZTWorkAreaHeaderView"];
        [_mainCollectionView registerClass:[HZTWorkAreaListCell class] forCellWithReuseIdentifier:@"HZTWorkAreaListCell"];
        [self.view addSubview:_mainCollectionView];
        [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_mainCollectionView.superview).with.insets(UIEdgeInsetsMake(0,0,0,0));
        }];
    }
    return _mainCollectionView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
