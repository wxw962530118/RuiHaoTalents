//
//  HZTCompanyInfoController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCompanyInfoController.h"
#import "HZTCompanyHeaderView.h"
#import "HZTNavView.h"
#import "HZTCompanyContentCell.h"
#import "UINavigationBar+Awesome.h"
/**头视图高度*/
#define HeaderH 260
#define SectionH 50
@interface HZTCompanyInfoController ()<UITableViewDelegate,UITableViewDataSource>
/***/
@property (nonatomic, strong) UITableView * mainTableView;
/**/
@property (nonatomic, strong) UILabel * titlesLabel;
/** 记录滚动视图最开始偏移量y值 */
@property (nonatomic, assign) CGFloat oriOffsetY;
/***/
@property (nonatomic, strong) HZTCompanyHeaderView * headerView;
/**自定义导航栏*/
@property (nonatomic, strong) HZTNavView * navView;

@end

@implementation HZTCompanyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**记录最开始偏移量y值*/
    self.oriOffsetY = -HeaderH + SectionH;
    /**设置tableView顶部额外滚动区域*/
    [self.mainTableView reloadData];
    [self configNavInfo];
}

-(void)configNavInfo{
    [self.view addSubview:self.navView];
    [self.view bringSubviewToFront:self.navView];
    [self.navView setNavTitle:@"公司简介"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf)
    HZTCompanyContentCell * cell = [HZTCompanyContentCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor greenColor];
    cell.Block = ^(CGFloat offSetY) {
        NSLog(@"offSetY:%f",offSetY);
        [weakSelf.mainTableView setContentOffset:CGPointMake(0, offSetY) animated:YES];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenH - 214;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,SectionH)];
    view.backgroundColor = [UIColor purpleColor];
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentY = scrollView.contentOffset.y;
    CGFloat scrollH = IS_IPhoneX() ? 88 : 64;
    NSLog(@"contentY:%f",contentY);
    if (contentY < 0) self.headerView.offSetY = contentY;
    if (contentY > scrollH) {
        [self.navView setNavBarWithAlpha:1];
    }else if(contentY <= 0){
        [self.navView setNavBarWithAlpha:0];
    }else{
        CGFloat alpha = contentY/scrollH;
        [self.navView setNavBarWithAlpha:alpha];
    }
}

#pragma mark --- 懒加载相关
-(UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableView.backgroundColor = HZTClearColor;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.tableHeaderView = self.headerView;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(0);
        }];
    }
    return _mainTableView;
}

-(HZTCompanyHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HZTCompanyHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, HeaderH)];
        _headerView.backgroundColor = [UIColor redColor];
        
    }
    return _headerView;
}

-(HZTNavView *)navView{
    WS(weakSelf)
    if (!_navView) {
        _navView = [[HZTNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, IS_IPhoneX() ? 88 : 64) callBack:^{
            [weakSelf xw_popViewController:nil animated:YES];
        }];
    }
    return _navView;
}

@end
