//
//  HZTPostDetailsController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTPostDetailsController.h"
#import "HZTShareView.h"
#import "HZTPostDetailsHeaderView.h"
#import "HZTPostDetailsSectionView.h"
#import "HZTCompanyInfoCell.h"
#import "HZTCompanyInfoController.h"
#import "HZTPostLightCell.h"
#import "HZTTagViewModel.h"
#import "HZTPostDescCell.h"

@interface HZTPostDetailsController ()<UITableViewDelegate,UITableViewDataSource>
/***/
@property (nonatomic, strong) UITableView * mainTableView;
/***/
@property (nonatomic, strong) NSMutableArray * dataListArray;
/***/
@property (nonatomic, strong) HZTMajorButton * bottomBtn;
/***/
@property (nonatomic, strong) HZTPostDetailsHeaderView * headerView;
/**记录标签cell的动态高度*/
@property (nonatomic, assign) CGFloat tagsCellHeight;
/**记录标签cell的动态高度*/
@property (nonatomic, assign) CGFloat tagDescCellHeight;
/**/
@property (nonatomic, strong) NSMutableArray <HZTTagViewModel *>* tagsArray;
/**/
@property (nonatomic, strong) NSMutableArray <HZTTagViewModel *>* tagsDescArray;
@end

@implementation HZTPostDetailsController

-(instancetype)init{
    if(self = [super init]){
        self.tagsCellHeight = 0;
        self.tagDescCellHeight = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavItem];
    [self prepareData];
}

-(void)prepareData{
    NSArray * titles = @[@"才算是多层次",@"解放路色块父级抗裂砂浆弗兰克斯废旧塑料",@"四六级斯洛伐克雷锋精神六块腹肌弗兰克斯解放路上",@"q",@"lalal",@"kmkmkmmkmkm",@"csc",@"131311",@"1",@"dcscscc",@"ckjnscjknsckjsn",@"9998"];
    for (int i = 0; i< titles.count; i++) {
        HZTTagViewModel * model = [[HZTTagViewModel alloc] init];
        model.borderColor = RGBColor(240, 240, 240);
        model.name = titles[i];
        model.bgColor = RGBColor(240, 240, 240);
        [self.tagsArray addObject:model];
    }
    
    for (int i = 0; i< titles.count; i++) {
        HZTTagViewModel * model = [[HZTTagViewModel alloc] init];
        model.borderColor = RGBColor(240, 240, 240);
        model.name = titles[i];
        model.bgColor = HZTColorWhiteGround;
        [self.tagsDescArray addObject:model];
    }
    
    self.bottomBtn.hidden = false;
    [self.mainTableView reloadData];
}

-(void)configNavItem{
    self.navigationItem.title = @"职位详情";
    [self ctNavRightItemWithTitle:nil imageName:@"share_icon" callBack:^{
        [HZTShareView showWithCallBack:^(ShareType type) {
            NSLog(@"type:%ld",type);
            if (type == ShareType_WeChat) {
                
            }else if (type == ShareType_Friends){
                
            }
        }];
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf)
    if (indexPath.section == 0) {
        HZTCompanyInfoCell * cell = [HZTCompanyInfoCell cellWithTableViewFromXIB:tableView];
        [cell setTitle:@"wxw" desc:@"HR/人事经理" imageUrl:@""];
        return cell;
    }else if (indexPath.section == 1){
        HZTPostLightCell * cell = [HZTPostLightCell cellWithTableView:tableView];
        cell.array = self.tagsArray;
        cell.changed = ^(CGFloat height) {
            weakSelf.tagsCellHeight = (height + 56);
            [weakSelf.mainTableView reloadData];
        };
        return cell;
    }else if (indexPath.section == 2){
        UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if (indexPath.section == 3){
        if (!indexPath.row) {
            HZTPostDescCell * cell = [HZTPostDescCell cellWithTableView:tableView];
            cell.array = self.tagsDescArray;
            cell.changed = ^(CGFloat height) {
                weakSelf.tagDescCellHeight = (height + 56);
                [weakSelf.mainTableView reloadData];
            };
            return cell;
        }else{
            UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView];
            cell.backgroundColor = [UIColor greenColor];
            return cell;
        }
    }else{
        HZTCompanyInfoCell * cell = [HZTCompanyInfoCell cellWithTableViewFromXIB:tableView];
        [cell setTitle:@"陇浩网络科技有限公司" desc:@"股份制丨100~499人丨互联网" imageUrl:@""];

        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110;
    }else if (indexPath.section == 1){
         return self.tagsCellHeight;
    }else if (indexPath.section == 2){
         return 200;
    }else if (indexPath.section == 3){
        if (!indexPath.row) {
            return self.tagDescCellHeight;
        }else{
             return 350;
        }
    }else{
         return 110;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HZTPostDetailsSectionView * view = [HZTPostDetailsSectionView createSectionView];
    if (section == 0) {
         [view setTitle:@"职位发布者" imageName:@"post_user"];
    }else if (section == 1){
        [view setTitle:@"职位亮点" imageName:@"post_light"];
    }else if (section == 2){
        [view setTitle:@"技能要求" imageName:@"jnyq_user"];
    }else if (section == 3){
        [view setTitle:@"职位描述" imageName:@"post_desc"];
    }else{
        [view setTitle:@"公司信息" imageName:@"company_info"];
    }
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 4) {
        /**公司信息*/
        HZTCompanyInfoController * vc = [[HZTCompanyInfoController alloc] init];
        [self xw_pushViewController:vc animated:YES];
    }
}

#pragma mark --- 懒加载相关
-(UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = HZTColorWhiteGround;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.tableHeaderView = self.headerView;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-85);
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

-(HZTMajorButton *)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = [[HZTMajorButton alloc] init];
        _bottomBtn.hidden = true;
        _bottomBtn.layer.masksToBounds = true;
        _bottomBtn.layer.cornerRadius = 5;
        [_bottomBtn setTitle:@"投递简历" forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bottomBtn];
        [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(15);
            make.right.equalTo(self.view.mas_right).offset(-15);
            make.bottom.equalTo(self.view.mas_bottom).offset(-34);
            make.height.mas_equalTo(46);
        }];
    }
    return _bottomBtn;
}

-(HZTPostDetailsHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [HZTPostDetailsHeaderView createPostDetailsViewWithCallBack:^{
            
        }];
        _headerView.backgroundColor = [UIColor clearColor];
        _headerView.frame = CGRectMake(0,0, kScreenW, 266);
    }
    return _headerView;
}

-(NSMutableArray *)tagsArray{
    if (!_tagsArray) {
        _tagsArray = [NSMutableArray array];
    }
    return _tagsArray;
}

-(NSMutableArray *)tagsDescArray{
    if (!_tagsDescArray) {
        _tagsDescArray = [NSMutableArray array];
    }
    return _tagsDescArray;
}

-(void)clickBtn{
    
}


@end
