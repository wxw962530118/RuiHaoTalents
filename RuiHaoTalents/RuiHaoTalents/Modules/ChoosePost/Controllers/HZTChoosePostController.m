//
//  HZTChoosePostController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTChoosePostController.h"
#import "HZTChoosePostModel.h"
#import "HZTChoosePostView.h"
#import "HZTChoosePostCell.h"
@interface HZTChoosePostController ()
/***/
@property (nonatomic, strong) NSMutableArray <HZTChoosePostModel *>* dataListArray;
/***/
@property (nonatomic, strong) HZTChoosePostView * firstChoosePostView;
/***/
@property (nonatomic, strong) HZTChoosePostView * secondChoosePostView;
/***/
@property (nonatomic, strong) HZTChoosePostView * thirdChoosePostView;
/**二级ID*/
@property (nonatomic, strong) NSString * secondId;

@end

@implementation HZTChoosePostController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"选择职位";
    [self getPostListWithId:@"1" postView:self.firstChoosePostView];
}

-(void)getPostListWithId:(NSString *)Id postView:(HZTChoosePostView *)postView{
    [HZTToastHUD showLoading];
    [[HZTOthersNetWorkManager manager] requestPostListWithId:Id succeed:^(id  _Nonnull responseObject) {
        [HZTToastHUD hideLoading];
        [self.dataListArray removeAllObjects];
        [self.dataListArray addObjectsFromArray:[HZTChoosePostModel mj_objectArrayWithKeyValuesArray:responseObject[@"content"]]];
        for (HZTChoosePostModel * model in self.dataListArray) {
            model.isSelected = [model.name isEqualToString:@""];
        }
        postView.dataArray = [self.dataListArray mutableCopy];
        if (!postView.dataArray.count) {
            [self showNoDataViewWithSupersView:postView];
        }else{
            [self hideNoDataView];
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

-(HZTChoosePostView *)firstChoosePostView{
    WS(weakSelf)
    if (!_firstChoosePostView) {
        _firstChoosePostView = [[HZTChoosePostView alloc] initWithType:MenuLevelType_First callBack:^(NSString * _Nonnull name, NSString * _Nonnull Id, MenuLevelType type) {
            /**一级根据ID拉取二级菜单*/
            [weakSelf getPostListWithId:Id postView:weakSelf.secondChoosePostView];
        }];
        _firstChoosePostView.backgroundColor = RGBColor(244, 244, 244);
        [self.view addSubview:_firstChoosePostView];
        [_firstChoosePostView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.view);
        }];
    }
    return _firstChoosePostView;
}

-(HZTChoosePostView *)secondChoosePostView{
    WS(weakSelf)
    if (!_secondChoosePostView) {
        _secondChoosePostView = [[HZTChoosePostView alloc] initWithType:MenuLevelType_First callBack:^(NSString * _Nonnull name, NSString * _Nonnull Id, MenuLevelType type) {
            /**二级根据ID拉取三级菜单*/
            weakSelf.secondId = Id;
            [weakSelf getPostListWithId:Id postView:weakSelf.thirdChoosePostView];
        }];
        _secondChoosePostView.backgroundColor = RGBColor(243, 243, 243);
        [self.view addSubview:_secondChoosePostView];
        [_secondChoosePostView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.view);
            make.left.equalTo(self.view.mas_left).offset(78);
        }];
    }
    return _secondChoosePostView;
}

-(HZTChoosePostView *)thirdChoosePostView{
    WS(weakSelf)
    if (!_thirdChoosePostView) {
        _thirdChoosePostView = [[HZTChoosePostView alloc] initWithType:MenuLevelType_First callBack:^(NSString * _Nonnull name, NSString * _Nonnull Id, MenuLevelType type) {
            /**三级菜单 选中 回调 三级标题 二级 三级的ID*/
            if (weakSelf.callBack) {
                weakSelf.callBack(weakSelf.secondId, Id, name);
            }
            [weakSelf xw_popViewController:nil animated:YES];
        }];
        _thirdChoosePostView.backgroundColor = RGBColor(224, 237, 235);
        [self.view addSubview:_thirdChoosePostView];
        [_thirdChoosePostView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.view);
            make.left.equalTo(self.view.mas_left).offset(226);
        }];
    }
    return _thirdChoosePostView;
}

-(NSMutableArray *)dataListArray{
    if (!_dataListArray) {
        _dataListArray = [NSMutableArray array];
    }
    return _dataListArray;
}

@end
