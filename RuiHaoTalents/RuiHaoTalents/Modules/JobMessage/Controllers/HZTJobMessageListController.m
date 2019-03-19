//
//  HZTJobMessageListController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/19.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTJobMessageListController.h"
#import "HZTTopTabView.h"
#import "HZTNewsListCell.h"
#define TopMargin 81
@interface HZTJobMessageListController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
/***/
@property (nonatomic, strong) UIView * tabView;
/***/
@property (nonatomic, strong) HZTTopTabView * topTabView;
/***/
@property (nonatomic, strong) NSMutableArray <NSMutableArray *>* dataArray;
/**/
@property (nonatomic, strong) NSMutableArray <UITableView *>*tablesArray;
/***/
@property (nonatomic, strong) UIScrollView * mainScrollView;
/***/
@property (nonatomic, assign) NSInteger currentIndex;
/**操作底部滚动视图*/
@property (nonatomic, assign) BOOL isScroold;
@end

@implementation HZTJobMessageListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configInfo];
    [self addTabView];
    [self addMainScrollView];
    [self prepareData];
    [self prepareTable];
}

-(void)configInfo{
    self.navigationItem.title = @"求职消息";
    self.currentIndex = 0;
}

-(void)addTabView{
    NSArray * titleArr = @[@"已投递",@"被查看",@"邀面试",@"已完成"];
    NSArray * imageArr = @[@"ytd_icon",@"bck_icon",@"yms_icon",@"ywc_icon"];
    NSMutableArray <HZTTopTabModel *>* tempArr = [NSMutableArray array];
    for (int i = 0; i< titleArr.count; i++) {
        HZTTopTabModel * model = [[HZTTopTabModel alloc] init];
        model.isSelectd = false;
        model.messageCnt = 100;
        model.imageName = imageArr[i];
        model.title = titleArr[i];
        model.itemW = kScreenW/4;
        model.itemH = TopMargin;
        [tempArr addObject:model];
    }
    WS(weakSelf)
    if(!_tabView){
        _tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, TopMargin)];
        [self.view addSubview:_tabView];
        self.topTabView = [[HZTTopTabView alloc]initWithCallBack:^(HZTTopTabModel * _Nonnull model) {
            /**选中回调 切换底部滚动视图*/
            NSInteger index = [tempArr indexOfObject:model];
            weakSelf.currentIndex = index;
            [weakSelf.mainScrollView setContentOffset:CGPointMake(index * kScreenW,0) animated:false];
            UITableView * tableView = weakSelf.tablesArray[index];
            [tableView reloadData];
        }];
        self.topTabView.itemMargin = 0;
        [_tabView addSubview:self.topTabView];
        self.topTabView.dataArray = tempArr;
    }
}
    
-(void)addMainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TopMargin, kScreenW, kScreenH - TopMargin)];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.contentSize = CGSizeMake(4 * kScreenW,0);
        _mainScrollView.backgroundColor = [UIColor purpleColor];
        [self.view addSubview:_mainScrollView];
    }
}

-(void)prepareTable{
    for (int i = 0; i< 4; i++) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(i * kScreenW,0, kScreenW, _mainScrollView.height - TopMargin + 15) style:UITableViewStyleGrouped];
        tableView.backgroundColor = RGBColor(244, 244, 244);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tablesArray addObject:tableView];
        [_mainScrollView addSubview:tableView];
    }
}

-(void)prepareData{
    NSArray * stateNameArr = @[@"【已投递】",@"【被查看】",@"【邀面试】",@"【已完成】"];
    NSArray * colorArr = @[RGBColor(176, 79, 193),RGBColor(79, 193, 170),RGBColor(239, 188, 66),RGBColor(166, 166, 166)];
    for (int i = 0; i< stateNameArr.count; i++) {
        NSMutableArray <HZTNewsListModel *>* tempArr = [NSMutableArray array];
        for (int j = 0; j< arc4random_uniform(10) + 5; j++) {
            HZTNewsListModel * model = [[HZTNewsListModel alloc] init];
            model.title = @"陇浩网络科技有限公司";
            model.isShowState = true;
            model.imageName = @"left_menu_icon";
            model.desc = @"UI设计师丨8K";
            model.createTime = @"2018-12-25";
            model.stateColor = colorArr[i];
            model.stateName = stateNameArr[i];
            [tempArr addObject:model];
        }
        [self.dataArray addObject:tempArr];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray[self.currentIndex].count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZTNewsListCell * cell = [HZTNewsListCell cellWithTableViewFromXIB:tableView];
    cell.model = self.dataArray[self.currentIndex][indexPath.section];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark --- 减速停止的时候开始执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:NSClassFromString(@"UITableView")]) {
        NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
        self.currentIndex = index;
        self.topTabView.selectIndex = index;
        UITableView * tableView = self.tablesArray[index];
        [tableView reloadData];
    }
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)tablesArray{
    if (!_tablesArray) {
        _tablesArray = [NSMutableArray array];
    }
    return _tablesArray;
}

@end
