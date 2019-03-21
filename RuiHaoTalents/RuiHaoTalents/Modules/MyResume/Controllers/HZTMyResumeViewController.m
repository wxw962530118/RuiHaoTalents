//
//  HZTMyResumeViewController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumeViewController.h"
#import "HZTShareView.h"
#import "HZTMyResumeHeaderView.h"
#import "HZTMyResumeRealNameCell.h"
#import "HZTMyResumeSectionFooterView.h"
#import "HZTMyResumeCustomCell.h"
#import "HZTMyResumeListModel.h"
#import "HZTCustomHederCell.h"
#import "HZTTrainCell.h"
@interface HZTMyResumeViewController ()<UITableViewDelegate,UITableViewDataSource>
/***/
@property (nonatomic, strong) UITableView * mainTableView;
/***/
@property (nonatomic, strong) HZTMyResumeHeaderView * headerView;
/***/
@property (nonatomic, strong) HZTMyResumeListModel * listModel;
@end

@implementation HZTMyResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavItem];
    [self prepareData];
}

-(void)configNavItem{
    self.navigationItem.title = @"个人简历";
    [self ctNavRightItemWithTitle:nil imageName:@"share_icon" callBack:^{
        [ToolBaseClass showNavigationWithLongitude:108.836718 latitude:34.240541];
        //[HZTShareView show];
    }];
}

-(void)prepareData{
    [HZTToastHUD showLoading];
    [[HZTOthersNetWorkManager manager] requestMeProfileWithHumanId:[HZTAccountManager getUser].humanId succeed:^(id  _Nonnull responseObject) {
        [HZTToastHUD hideLoading];
        self.listModel = [HZTMyResumeListModel mj_objectWithKeyValues:responseObject];
        self.headerView.listModel = self.listModel;
        /**处理动态cell高度*/
        for (int i = 0; i< self.listModel.personJobFullVO.trainList.count; i++) {
            HZTTrainModel * model = self.listModel.personJobFullVO.trainList[i];
            model.cellHeight = 94;
            if (self.listModel.personJobFullVO.trainList.count > 2 &&  i == 1) {
                model.isShowMore = YES;
                model.cellHeight += 30;
            }
        }
        for (int i = 0; i< self.listModel.personJobFullVO.resumeList.count; i++) {
            HZTResumeModel * model = self.listModel.personJobFullVO.resumeList[i];
            model.cellHeight = (30 + 20 + 18 + 16 + 10 + 12 + 14 + [ToolBaseClass getHeightWithString:model.resumeDescribe width:kScreenW - 70 font:HZTFontSize(14)] + 30);
            if (self.listModel.personJobFullVO.resumeList.count > 2 &&  i == 1) {
                model.isShowMore = YES;
                model.cellHeight += 30;
            }
        }
        for (int i = 0; i< self.listModel.personJobFullVO.projiectList.count; i++) {
            HZTProjiectModel * model = self.listModel.personJobFullVO.projiectList[i];
            model.cellHeight = (30 + 20 + 18 + 16 + 10 + 12 + 14 + [ToolBaseClass getHeightWithString:model.projectDescribe width:kScreenW - 70 font:HZTFontSize(14)] + 30);
            if (self.listModel.personJobFullVO.projiectList.count > 2 &&  i == 1) {
                model.isShowMore = YES;
                model.cellHeight += 30;
            }
        }
        [self.mainTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [HZTToastHUD hideLoading];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.listModel.nameAuthent intValue] ? 4 : 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.listModel.nameAuthent intValue]) {
        return [self handleSectionCountWithSection:section];
    }else{
        if (!section){
            return 1;
        }else{
            return [self handleSectionCountWithSection:section];
        }
    }
}

#pragma mark --- 每组的数据
-(NSInteger)handleSectionCountWithSection:(NSInteger)section{
    switch (section){
        case 1:
            return self.listModel.personJobFullVO.skillList.count ? self.listModel.personJobFullVO.skillList.count + 1 : self.listModel.personJobFullVO.skillList.count;
            break;
        case 2:
            return [self handleSectionCountWithCount:self.listModel.personJobFullVO.trainList.count isShowMore:(self.listModel.personJobFullVO.trainList.count > 2 ? self.listModel.personJobFullVO.trainList[1].isShowMore : false)];
            break;
        case 3:
            return [self handleSectionCountWithCount:self.listModel.personJobFullVO.resumeList.count isShowMore:(self.listModel.personJobFullVO.resumeList.count > 2 ? self.listModel.personJobFullVO.resumeList[1].isShowMore : false)];
            break;
        case 4:
            return [self handleSectionCountWithCount:self.listModel.personJobFullVO.projiectList.count isShowMore:(self.listModel.personJobFullVO.projiectList.count > 2 ? self.listModel.personJobFullVO.projiectList[1].isShowMore : false)];
            break;
        default:
            return 0;
            break;
    }
}

-(NSInteger)handleSectionCountWithCount:(NSInteger)count isShowMore:(BOOL)isShowMore{
    if (count) {
        return ((count > 2 && isShowMore) ? 2 : count) + 1;
    }else{
        return count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf)
    if (!indexPath.section) {
        HZTMyResumeRealNameCell * cell = [HZTMyResumeRealNameCell cellWithTableViewFromXIB:tableView];
        return cell;
    }else{
        if (indexPath.section == 1) {
            if (!indexPath.row) {
                HZTCustomHederCell * cell = [HZTCustomHederCell cellWithTableViewFromXIB:tableView];
                return cell;
            }else{
                UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView];
                return cell;
            }
        }else if (indexPath.section == 2){
            if (!indexPath.row) {
                HZTCustomHederCell * cell = [HZTCustomHederCell cellWithTableViewFromXIB:tableView];
                cell.title = @"教育经历";
                return cell;
            }else{
                HZTTrainCell * cell = [HZTTrainCell cellWithTableViewFromXIB:tableView];
                cell.model = self.listModel.personJobFullVO.trainList[indexPath.row - 1];
                cell.callBack = ^(TrainCallBackType type) {
                    if (type == TrainCallBackType_LookMore) {
                        weakSelf.listModel.personJobFullVO.trainList[1].isShowMore = false;
                        weakSelf.listModel.personJobFullVO.trainList[1].cellHeight -= 30;
                        [weakSelf.mainTableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
                    }
                };
                return cell;
            }
        }else if (indexPath.section == 3){
            if (!indexPath.row) {
                HZTCustomHederCell * cell = [HZTCustomHederCell cellWithTableViewFromXIB:tableView];
                cell.title = @"工作经历";
                return cell;
            }else{
                HZTMyResumeCustomCell * cell = [HZTMyResumeCustomCell cellWithTableViewFromXIB:tableView];
                cell.resumeModel = self.listModel.personJobFullVO.resumeList[indexPath.row - 1];
                cell.callBack = ^(MyResumeCellCallBackType type) {
                    [weakSelf handleResumeCellCallBackWithType:type indexPath:indexPath projiectList:nil resumeList:weakSelf.listModel.personJobFullVO.resumeList];
                };
                return cell;
            }
        }else{
            if (!indexPath.row) {
                HZTCustomHederCell * cell = [HZTCustomHederCell cellWithTableViewFromXIB:tableView];
                cell.title = @"项目经验";
                return cell;
            }else{
                HZTMyResumeCustomCell * cell = [HZTMyResumeCustomCell cellWithTableViewFromXIB:tableView];
                cell.projiectModel = self.listModel.personJobFullVO.projiectList[indexPath.row - 1];
                cell.callBack = ^(MyResumeCellCallBackType type) {
                    [weakSelf handleResumeCellCallBackWithType:type indexPath:indexPath projiectList:weakSelf.listModel.personJobFullVO.projiectList resumeList:nil];
                };
                return cell;
            }
        }
     }
}

#pragma mark --- 处理项目经验 工作经历 公用cell 回调事件
-(void)handleResumeCellCallBackWithType:(MyResumeCellCallBackType)type  indexPath:(NSIndexPath *)indexPath projiectList:(NSArray <HZTProjiectModel *>*)projiectList resumeList:(NSArray <HZTResumeModel *>*)resumeList{
    if (type == MyResumeCellCallBackType_LookMore) {
        if (projiectList) {
            projiectList[1].isShowMore = false;
            projiectList[1].cellHeight -= 30;
        }else{
            resumeList[1].isShowMore = false;
            resumeList[1].cellHeight -= 30;
        }
        [self.mainTableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
    }else{
        NSMutableArray * temp;
        if (projiectList) {
            temp = [NSMutableArray arrayWithArray:projiectList];
            [temp removeObject:projiectList[indexPath.row - 1]];
            self.listModel.personJobFullVO.projiectList = temp;
        }else{
            temp = [NSMutableArray arrayWithArray:resumeList];
            [temp removeObject:resumeList[indexPath.row - 1]];
            self.listModel.personJobFullVO.resumeList = temp;
        }
        [self.mainTableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.section) {
        return 91;
    }else{
        if (indexPath.section == 2){
            if (!indexPath.row) return 80;
            return self.listModel.personJobFullVO.trainList[indexPath.row-1].cellHeight;
        }else if (indexPath.section == 3){
           if (!indexPath.row) return 80;
           return self.listModel.personJobFullVO.resumeList[indexPath.row-1].cellHeight;
        }else if (indexPath.section == 4){
            if (!indexPath.row) return 80;
            return self.listModel.personJobFullVO.projiectList[indexPath.row-1].cellHeight;
        }else{
            return 100;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (!section) {
        return 0.01;
    }else{
        return  [self handleSectionHeight:section];
    }
}

#pragma mark --- 根据数据源 刷新尾部视图的高度
-(CGFloat)handleSectionHeight:(NSInteger)section{
    switch (section) {
        case 1:
            return !self.listModel.personJobFullVO.skillList.count ? 67 : 10;
            break;
        case 2:
            return !self.listModel.personJobFullVO.trainList.count ? 67 : 10;
            break;
        case 3:
            return !self.listModel.personJobFullVO.resumeList.count ? 67 : 10;
            break;
        case 4:
            return !self.listModel.personJobFullVO.projiectList.count ? 67 : 10;
            break;
        default:
            return 0.01;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section) {
        NSArray * titleArr = @[@"+添加拥有技能",@"+添加教育经历",@"+添加工作径路",@"+添加项目经验"];
        HZTMyResumeSectionFooterView * view = [HZTMyResumeSectionFooterView createMyResumeSectionFooterViewWithTitle:titleArr[section - 1] callBack:^(NSString * _Nonnull title) {
            NSLog(@"title:%@",title);
        }];
        view.frame = CGRectMake(0, 0, kScreenWidth, 58);
        return view;
    }else{
        return nil;
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
        _mainTableView.tableHeaderView = self.headerView;
        _mainTableView.allowsSelection = false;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.view);
        }];
    }
    return _mainTableView;
}

-(HZTMyResumeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [HZTMyResumeHeaderView createMyResumeHeaderView];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 314);
    }
    return _headerView;
}

-(HZTMyResumeListModel *)listModel{
    if (!_listModel) {
        _listModel = [[HZTMyResumeListModel alloc] init];
    }
    return _listModel;
}

@end
