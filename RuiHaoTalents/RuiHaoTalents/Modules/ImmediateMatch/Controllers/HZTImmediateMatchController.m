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
#import "HZTImmediateMatchModel.h"
#import "HZTPostDetailsController.h"

#define PAGE_CNT 10
@interface HZTImmediateMatchController ()<UITableViewDelegate,UITableViewDataSource>
/***/
@property (nonatomic, strong) UITableView * mainTableView;
/***/
@property (nonatomic, strong) NSMutableArray <HZTImmediateMatchModel *>* dataListArray;
/***/
@property (nonatomic, strong) HZTImmediateMatchHeaderView * headerView;
/***/
@property (nonatomic, copy) NSString * workArdess;
/***/
@property (nonatomic, copy) NSString * workType;
/***/
@property (nonatomic, copy) NSString * startDate;
/***/
@property (nonatomic, copy) NSString * endDate;
/***/
@property (nonatomic, copy) NSString * payId;
/***/
@property (nonatomic, copy) NSString * industry;
/***/
@property (nonatomic, copy) NSString * personFunction;
/**页面*/
@property (nonatomic, assign) NSInteger pageNumber;
/***/
@property (nonatomic, assign) NSInteger currentSort;
@end

@implementation HZTImmediateMatchController

-(instancetype)initWithWorkArdess:(NSString *)workArdess workType:(NSString *)workType startDate:(NSString *)startDate endDate:(NSString *)endDate payId:(NSString *)payId industry:(NSString *)industry personFunction:(NSString *)personFunction{
    if (self = [super init]){
        self.currentSort = 1;
        self.workArdess = workArdess;
        self.workType = workType;
        self.startDate = startDate;
        self.endDate = endDate;
        self.payId = payId;
        self.industry = industry;
        self.personFunction = personFunction;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"职位";
    [self addHeaderView];
    [self loadNewData];
}

-(void)loadNewData{
    self.pageNumber = 1;
    [self loadData];
}

-(void)loadMoreData{
    self.pageNumber ++;
    [self loadData];
}

-(void)loadData{
    WS(weakSelf)
    [HZTToastHUD showLoading];
    [[HZTOthersNetWorkManager manager] requestJobListWithPersonWorkArdess:self.workArdess workArdessX:[ToolBaseClass getUserDefaultsWithKey:LocationLongitude] workArdessY:[ToolBaseClass getUserDefaultsWithKey:LocationLatitude] reportStart:self.startDate reportEnd:self.endDate  personWorkType:self.workType personPayStart:self.payId personIndustry:self.industry personFunction:self.personFunction sort:self.currentSort pageNumber:self.pageNumber succeed:^(id  _Nonnull responseObject) {
        NSArray * tempArr = (NSArray *)responseObject[@"content"];
        [HZTToastHUD hideLoading];
        if (self.dataListArray.count){
            [self.dataListArray removeAllObjects];
        }
        [self.dataListArray addObjectsFromArray:[HZTImmediateMatchModel mj_objectArrayWithKeyValuesArray:tempArr]];
        if (tempArr.count == PAGE_CNT) {
            [self.mainTableView addFooterWithWithHeaderWithAutoRefresh:false loadMoreBlock:^(NSInteger pageIndex) {
                weakSelf.pageNumber = pageIndex;
                [weakSelf loadMoreData];
            }];
        }
        if (tempArr.count < PAGE_CNT && self.pageNumber != 1){
            [self.mainTableView endFooterNoMoreData];
        }else{
            [self.mainTableView endFooterRefresh];
        }
        [self.mainTableView reloadData];
        if (!tempArr.count) {
            [self showNoDataViewWithSupersView:self.mainTableView];
        }else{
            [self hideNoDataView];
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        self.pageNumber -= 1;
        [self.mainTableView endFooterRefresh];
    }];
}

-(void)addHeaderView{
    WS(weakSelf)
    self.headerView = [HZTImmediateMatchHeaderView createHomeHeaderView];
    self.headerView.callBack = ^(CallBackType type) {
        NSLog(@"type:%ld",type);
        weakSelf.currentSort = type;
        [weakSelf.mainTableView beginRefresh];
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
    cell.model = self.dataListArray[indexPath.section];
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
    HZTPostDetailsController * vc = [[HZTPostDetailsController alloc] init];
    [self xw_pushViewController:vc animated:YES];
}

#pragma mark --- 懒加载相关
-(UITableView *)mainTableView{
    WS(weakSelf)
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
        [self.mainTableView addHeaderWithHeaderWithBeginRefresh:NO animation:NO refreshBlock:^(NSInteger pageIndex) {
            [weakSelf loadNewData];
        }];
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
