//
//  HZTNewsListController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTNewsListController.h"
#import "HZTNewsListModel.h"
#import "HZTNewsListCell.h"
#import "HZTJobMessageListController.h"
@interface HZTNewsListController ()<UITableViewDelegate,UITableViewDataSource>
/***/
@property (nonatomic, strong) UITableView * mainTableView;
/***/
@property (nonatomic, strong) NSMutableArray <HZTNewsListModel *>* dataListArray;
@end

@implementation HZTNewsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavItem];
    [self prepareDataList];
}

-(void)configNavItem{
    self.navigationItem.title = @"消息中心";
    [self ctNavRightItemWithTitle:@"全部已读" imageName:nil callBack:^{
       
    }];
}

-(void)prepareDataList{
    NSArray * imageNames = @[@"robot_message-icon",@"job_message_icon",@"bole_message_icon"];
    NSArray * titles = @[@"求职管家",@"求职信息",@"伯乐信息"];
    NSArray * descs = @[@"您当前的软件不是最新版本，请尽快更...",@"陇浩网络科技有限公司",@"吴彦祖：我觉得这个职位非常适合你"];
    NSArray * times = @[@"2019.01.01",@"2019.01.02",@"2019.01.03"];

    for (int i = 0; i< imageNames.count; i++) {
        HZTNewsListModel * model = [[HZTNewsListModel alloc] init];
        model.title = titles[i];
        model.isShowState = i==1;
        model.stateName = @"【已投递】";
        model.imageName = imageNames[i];
        model.desc = descs[i];
        model.createTime = times[i];
        [self.dataListArray addObject:model];
    }
    [self.mainTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZTNewsListCell * cell = [HZTNewsListCell cellWithTableViewFromXIB:tableView];
    cell.model = self.dataListArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        HZTJobMessageListController * vc = [[HZTJobMessageListController alloc] init];
        [self xw_pushViewController:vc animated:YES];
    }
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

@end
