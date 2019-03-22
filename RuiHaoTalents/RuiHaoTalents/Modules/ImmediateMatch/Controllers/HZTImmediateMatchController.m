//
//  HZTImmediateMatchController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTImmediateMatchController.h"
#import "HZTImmediateMatchHeaderView.h"
#import "HZTImmediateMatchCell.h"
@interface HZTImmediateMatchController ()<UITableViewDelegate,UITableViewDataSource>
/***/
@property (nonatomic, strong) UITableView * mainTableView;
/***/
@property (nonatomic, strong) NSMutableArray * dataListArray;
/***/
@property (nonatomic, strong) HZTImmediateMatchHeaderView * headerView;

@end

@implementation HZTImmediateMatchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"职位";
    [self addHeaderView];
    [self prepareData];
}

-(void)prepareData{
    for (int i = 0; i< 30; i++) {
        [self.dataListArray addObject:[NSString stringWithFormat:@"test:%d",i]];
    }
    
    [[HZTOthersNetWorkManager manager] requestJobListWithPersonWorkArdess:@"西安市-新城区" workArdessX:108.836718   workArdessY:34.240541 reportStart:@"2019-03-22" reportEnd:@"2019-03-22" personWorkType:@"0" personPayStart:@"41" personIndustry:@"6" personFunction:@"3" sort:1 pageNumber:1 succeed:^(id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
    [self.mainTableView reloadData];
}

-(void)addHeaderView{
    self.headerView = [HZTImmediateMatchHeaderView createHomeHeaderView];
    self.headerView.callBack = ^(CallBackType type) {
        NSLog(@"type:%ld",type);
    };
    self.headerView.frame = CGRectMake(0, 0, kScreenW, 95);
    [self.view addSubview:self.headerView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataListArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZTImmediateMatchCell * cell = [HZTImmediateMatchCell cellWithTableViewFromXIB:tableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 152;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
            make.right.bottom.left.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(95);
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
