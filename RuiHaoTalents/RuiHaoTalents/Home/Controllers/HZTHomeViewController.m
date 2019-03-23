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
#import "HZTImmediateMatchController.h"
#import "HZTScanAboutController.h"
#import "HZTWorkAreaViewController.h"
#import "HZTExpectJobViewController.h"
@interface HZTHomeViewController ()<UITableViewDelegate,UITableViewDataSource,HZTHomeHeaderViewDelegate>
/***/
@property (nonatomic, strong) HZTLeftMenuContentView * menuContentView;
/***/
@property (nonatomic, strong) HZTHomeHeaderView * headerView;
/***/
@property (nonatomic, strong) UITableView * tableView;
/**当前定位的经度*/
@property (nonatomic, assign) double longitude;
/**当前定位的纬度*/
@property (nonatomic, assign) double latitude;
/**当前定位的市*/
@property (nonatomic, copy) NSString * cityName;
/**当前定位的区/县*/
@property (nonatomic, strong) NSString * areaName;
/***/
@property (nonatomic, copy) NSString * stateDate;
/***/
@property (nonatomic, copy) NSString * endDate;
/***/
@property (nonatomic, copy) NSString * payId;
/***/
@property (nonatomic, copy) NSString * personFunction;
/***/
@property (nonatomic, copy) NSString * personIndustry;
@end

@implementation HZTHomeViewController

-(instancetype)init{
    if (self = [super init]) {
        self.stateDate = [ToolBaseClass handleDateFormatterWithDate:[NSDate date] isDot:false hasYear:false];
           self.endDate = [ToolBaseClass handleDateFormatterWithDate:[NSDate date] isDot:false hasYear:false];
    }
    return self;
}

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
    NotificationRegister(HZTNOTIFICATION_UPDATE_USER_LOCATION_SUCCEED, self, @selector(locationSucceed:), nil);
}

#pragma mark --- 定位成功刷新头部城市信息
-(void)locationSucceed:(NSNotification *)noti{
    NSDictionary * dict = noti.userInfo;
    self.longitude = [[dict objectForKey:@"longitude"] doubleValue];
    self.latitude = [[dict objectForKey:@"latitude"] doubleValue];
    self.cityName = [dict objectForKey:@"LocationCityName"];
    self.areaName = [dict objectForKey:@"SubLocality"];
    self.headerView.cityName = [NSString stringWithFormat:@"%@-%@",self.cityName,self.areaName];
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

#pragma mark --- HZTHomeHeaderViewDelegate

-(void)clickScan:(HZTHomeHeaderView *)view{
    HZTScanAboutController * vc = [[HZTScanAboutController alloc] init];
    SWQRCodeConfig * config = [[SWQRCodeConfig alloc] init];
    config.scannerType = SWScannerTypeBoth;
    vc.codeConfig = config;
    [self xw_pushViewController:vc animated:YES];
}

-(void)clickImTalent:(HZTHomeHeaderView *)view{
    
}

-(void)clickSecurity:(HZTHomeHeaderView *)view{
    
}

-(void)clickJoinTalent:(HZTHomeHeaderView *)view{
    
}

-(void)clickWorkArea:(HZTHomeHeaderView *)view{
    WS(weakSelf)
    HZTWorkAreaViewController * vc = [[HZTWorkAreaViewController alloc] initWithCityName:self.cityName areaName:self.areaName callBack:^(NSString * _Nonnull result) {
        weakSelf.areaName = result;
        weakSelf.headerView.cityName = [NSString stringWithFormat:@"%@-%@",weakSelf.cityName,weakSelf.areaName];
    }];
    [self xw_pushViewController:vc animated:YES];
}

-(void)clickStartDate:(HZTHomeHeaderView *)view startDate:(NSString *)startDate{
    self.stateDate = startDate;
}

-(void)clickEndDate:(HZTHomeHeaderView *)view endDate:(NSString *)endDate{
    self.endDate = endDate;
}

-(void)clickExpectJob:(HZTHomeHeaderView *)view expectJobLabel:(nonnull UILabel *)expectJobLabel{
    WS(weakSelf)
    HZTExpectJobViewController * vc = [[HZTExpectJobViewController alloc] initWithExpectJobName:@"" payName:@"" callBack:^(NSString * _Nonnull expectJobName, NSString * _Nonnull payName, NSString * _Nonnull payId,NSString * _Nonnull personIndustry,NSString * _Nonnull personFunction) {
        weakSelf.headerView.expectJobName = expectJobName;
        weakSelf.personIndustry = personIndustry;
        weakSelf.personFunction = personFunction;
        weakSelf.payId = payId;
    }];
    [self xw_pushViewController:vc animated:YES];
}

-(void)clickImmediateMatch:(HZTHomeHeaderView *)view{
    if (self.headerView.expectJobName && ![self.headerView.expectJobName isEqualToString:@"您所期望的工作"]) {
        HZTImmediateMatchController * vc = [[HZTImmediateMatchController alloc] initWithWorkArdess:self.headerView.cityName workType:@"0" startDate:self.stateDate endDate:self.endDate payId:self.payId industry:self.personIndustry personFunction:self.personFunction];
        [self xw_pushViewController:vc animated:YES];
    }else{
        [HZTToastHUD showNormalWithTitle:@"请选择您所期望的工作"];
    }
}

#pragma mark --- 消息中心
-(void)clickMessage{
    if ([ToolBaseClass isShouldLogin]) return;
    HZTNewsListController * vc = [[HZTNewsListController alloc] init];
    [self xw_pushViewController:vc animated:YES];
}

@end
