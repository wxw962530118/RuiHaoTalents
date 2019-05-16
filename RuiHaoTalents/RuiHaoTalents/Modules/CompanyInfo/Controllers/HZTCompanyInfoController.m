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
    [self configNavInfo];
    /**记录最开始偏移量y值*/
    self.oriOffsetY = -HeaderH + SectionH;
    /**设置tableView顶部额外滚动区域*/
    [self.mainTableView reloadData];
}

-(void)configNavInfo{
    self.navTitle = @"公司简介";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:self.navView];
//    [self.navView setNavTitle:@"公司简介"];
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
       // [weakSelf.mainTableView setContentOffset:CGPointMake(0, offSetY) animated:YES];
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
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat yOffset = scrollView.contentOffset.y;
    NSLog(@"yOffset:%f",yOffset);
    if (yOffset < 0) {
        self.headerView.offSetY = yOffset;
    }
    if (yOffset > 64) {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
    }else if(yOffset < 0){
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }else{
        CGFloat alpha = (64 - yOffset)/64;
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    }
}

#pragma mark --- 懒加载相关
-(UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableView.backgroundColor = HZTClearColor;
        _mainTableView.delegate = self;
//        _mainTableView.scrollEnabled = false;
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
