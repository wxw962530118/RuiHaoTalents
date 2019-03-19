//
//  HZTSettingViewController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTSettingViewController.h"
#import "HZTSettingCell.h"
#import "HZTLoginWorkManager.h"
#import "AppDelegate.h"
@interface HZTSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
/***/
@property (nonatomic, strong) UITableView * mainTableView;
/***/
@property (nonatomic, strong) NSMutableArray * dataListArray;
/***/
@property (nonatomic, strong) UIView * footerView;

@end

@implementation HZTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self prepareData];
}

-(void)prepareData{
    [self.dataListArray addObject:@[[NSString stringWithFormat:@"更换手机号码:%@",[HZTAccountManager getUser].mobile],@"修改密码"]];
    [self.dataListArray addObject:@[@"提醒设置"]];
    [self.dataListArray addObject:@[@"我要评价",@"反馈与建议",@"关于我们"]];
    [self.mainTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!section) {
        return 2;
    }else if(section == 1){
        return 1;
    }else{
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZTSettingCell * cell = [HZTSettingCell cellWithTableViewFromXIB:tableView];
    cell.title = self.dataListArray[indexPath.section][indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark --- 懒加载相关
-(UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = RGBColor(244, 244, 244);
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.tableFooterView = self.footerView;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.view);
        }];
    }
    return _mainTableView;
}

-(NSMutableArray *)dataListArray{
    if (!_dataListArray) {
        _dataListArray = [NSMutableArray array];
    }
    return _dataListArray;
}

-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,64)];
        UIButton * btn = [[UIButton alloc] init];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setTitleColor:RGBColor(252, 55, 105) forState:UIControlStateNormal];
        btn.backgroundColor = HZTColorWhiteGround;
        [btn addTarget:self action:@selector(clickLoginOut) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_footerView);
            make.height.mas_equalTo(54);
        }];
    }
    return _footerView;
}

#pragma mark --- 退出登录
-(void)clickLoginOut{
    HZTAlertView(@"提示", @"确定要退出登陆吗?", @"取消",@"确定", ^(NSUInteger index) {
        if (index) {
            [[HZTLoginWorkManager manager] requestLoginOutSucceed:^(id  _Nonnull responseObject) {
              [HZTAccountManager signOutEven];
              [AppDelegate popToRootViewController];
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
            }];
        }
    });
}

@end
