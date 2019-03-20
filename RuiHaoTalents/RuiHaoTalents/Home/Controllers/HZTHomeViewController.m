//
//  HZTHomeViewController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTHomeViewController.h"
#import "HZTLeftMenuContentView.h"
#import "HZTHomeHeaderView.h"
#import "HZTNewsListController.h"
#import "HZTHomeBottomCell.h"
@interface HZTHomeViewController ()<UITableViewDelegate,UITableViewDataSource,HZTHomeHeaderViewDelegate>
/***/
@property (nonatomic, strong) HZTLeftMenuContentView * menuContentView;
/***/
@property (nonatomic, strong) HZTHomeHeaderView * headerView;
/***/
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation HZTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObservers];
    [self addMenuContentView];
    [self configNav];
    [self.tableView reloadData];
}

-(void)addObservers{
    NotificationRegister(HZTNOTIFICATION_HIDE_LEFT_MENU, self, @selector(hideMenuView), nil);
    NotificationRegister(HZTNOTIFICATION_SHOW_LEFT_MENU, self, @selector(showMenuView), nil);
}

-(void)showMenuView{
    _menuContentView.hidden = false;
}

-(void)hideMenuView{
    _menuContentView.hidden = true;
}

-(void)configNav{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hone_title_icon"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_nav_left_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(showMenu)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_nav_right_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(clickMessage)];
}

-(void)addMenuContentView{
    if (!_menuContentView) {
        _menuContentView = [[HZTLeftMenuContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) vesselView:self.view];
    }
}

-(void)showMenu{
    if ([ToolBaseClass isShouldLogin]) return;
    [_menuContentView showMenuView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZTHomeBottomCell * cell = [HZTHomeBottomCell cellWithTableViewFromXIB:tableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 343;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark --- 懒加载相关
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBColor(244, 244, 244);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableHeaderView = self.headerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.view);
        }];
    }
    return _tableView;
}

-(HZTHomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [HZTHomeHeaderView createHomeHeaderView];
        _headerView.delegate = self;
    }
    return _headerView;
}

#pragma mark --- 消息中心
-(void)clickMessage{
    if ([ToolBaseClass isShouldLogin]) return;
    HZTNewsListController * vc = [[HZTNewsListController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
