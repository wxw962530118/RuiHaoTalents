//
//  HZTMenuListView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMenuListView.h"
#import "HZTMenuListCell.h"
#import "HZTMenuListModel.h"
#import "HZTMenuListHeaderView.h"
#import "HZTMyResumeViewController.h"
#import "HZTSettingViewController.h"

@interface HZTMenuListView ()<UITableViewDelegate,UITableViewDataSource>
/***/
@property (nonatomic, strong) UITableView * tableView;
/**/
@property (nonatomic, strong) NSMutableArray <HZTMenuListModel *>* dataArray;
/**/
@property (nonatomic, strong) HZTMenuListHeaderView * headerView;
/***/
@property (nonatomic, copy) void (^Block)(void);
@end

@implementation HZTMenuListView

-(instancetype)initWithFrame:(CGRect)frame callBack:(nonnull void (^)(void))callBack{
    if (self = [super initWithFrame:frame]) {
        self.Block = callBack;
        [self prepareData];
    }
    return self;
}

-(void)prepareData{
    NSArray * imageNameArr = @[@"mywallet_icon",@"jianli",@"talent_icon",@"realname_icon",@"setting_icon",@"server_icon"];
    NSArray * titleArr = @[@"我的钱包",@"我的简历",@"伯乐",@"认证中心",@"设置",@"客服"];
    for (int i = 0; i< imageNameArr.count; i++) {
        HZTMenuListModel * model = [[HZTMenuListModel alloc] init];
        model.title = titleArr[i];
        model.imageName = imageNameArr[i];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZTMenuListCell * cell = [HZTMenuListCell cellWithTableViewFromXIB:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.Block) {
        self.Block();
    }
    if (indexPath.row == 1) {
        HZTMyResumeViewController * vc = [[HZTMyResumeViewController alloc] init];
        [App_TheFrontViewC.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        HZTSettingViewController * vc = [[HZTSettingViewController alloc] init];
        [App_TheFrontViewC.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark --- 懒加载相关
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableHeaderView = self.headerView;
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self);
        }];
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(HZTMenuListHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [HZTMenuListHeaderView createMenuListHeaderViewWithCallBack:^{
        }];
        _headerView.frame = CGRectMake(0, 0,self.width,180);
    }
    return _headerView;
}

@end
