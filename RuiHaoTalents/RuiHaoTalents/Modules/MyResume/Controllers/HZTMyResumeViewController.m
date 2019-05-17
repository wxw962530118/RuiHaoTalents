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
#import "HZTImagePickerView.h"
#import "HZTJiNengCell.h"
#import "HZTMyResumeNewsHeaderView.h"
#import "HZTMyResumeViewNavView.h"
#import "HZTMyResumeOtherHeaderView.h"
#import "HZTMyResumeLevelCell.h"
#import "HZTMyResumelPhoneCell.h"
#import "HZTMyResumeModel.h"
#import "HZTCardScrollCell.h"
@interface HZTMyResumeViewController ()<UITableViewDelegate,UITableViewDataSource>
/***/
@property (nonatomic, strong) UITableView * mainTableView;
/***/
//@property (nonatomic, strong) HZTMyResumeHeaderView * headerView;
/***/
@property (nonatomic, strong) HZTMyResumeNewsHeaderView * newsHeaderView;
/***/
@property (nonatomic, strong) HZTMyResumeListModel * listModel;
/***/
@property (nonatomic, strong) HZTMyResumeViewNavView * navView;
/**这个数据源只是用来出分组的数据 标记展开/收起的状态*/
@property (nonatomic, strong) NSMutableArray <HZTMyResumeModel *>* dataArray;
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
        [HZTShareView showWithCallBack:^(ShareType type) {
            
        }];
    }];
}

-(void)prepareData{
    [HZTToastHUD showLoading];
    [[HZTOthersNetWorkManager manager] requestMeProfileWithHumanId:[HZTAccountManager getUser].humanId succeed:^(id  _Nonnull responseObject) {
        [HZTToastHUD hideLoading];
        self.listModel = [HZTMyResumeListModel mj_objectWithKeyValues:responseObject];
        self.newsHeaderView.listModel = self.listModel;
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
        for (int i = 0; i< 9; i++) {
            HZTMyResumeModel * model = [[HZTMyResumeModel alloc] init];
            model.isExpend = NO;
            [self.dataArray addObject:model];
        }
        [self.mainTableView reloadData];
        self.navView.alpha = 0;
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [HZTToastHUD hideLoading];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    /**默认只有第二组和第三组显示数据 其他组需要手动点击展开项*/
    if (section == 1 || section == 2) {
        return 1;
    }else{
        if (self.dataArray[section].isExpend) {
            return 2;
        }else{
            return 0;
        }
    }
//    if (!section){
//        return 1;
//    }else{
//
//        return [self handleSectionCountWithSection:section];
//    }
}

#pragma mark --- 每组的数据
-(NSInteger)handleSectionCountWithSection:(NSInteger)section{
    switch (section){
        case 1:
            return self.listModel.personJobFullVO.skillList.count ? 2 : self.listModel.personJobFullVO.skillList.count;
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
        HZTCardScrollCell * cell = [HZTCardScrollCell cellWithTableViewFromXIB:tableView];
        return cell;
    }else if (indexPath.section == 1) {
        HZTMyResumeRealNameCell * cell = [HZTMyResumeRealNameCell cellWithTableViewFromXIB:tableView];
        cell.clickRealNameBlock = ^{
            /**跳转至实名认证页面*/
        };
        return cell;
    }else if (indexPath.section == 2) {
        HZTMyResumelPhoneCell * cell = [HZTMyResumelPhoneCell cellWithTableViewFromXIB:tableView];
        return cell;
    }else if (indexPath.section == 3) {
        HZTJiNengCell * cell = [HZTJiNengCell cellWithTableView:tableView];
        cell.title = @"拥有技能";
        return cell;
    }else if (indexPath.section == 4) {
        HZTJiNengCell * cell = [HZTJiNengCell cellWithTableView:tableView];
        cell.title = @"拥有技能";
        return cell;
    }else if (indexPath.section == 5) {
        HZTJiNengCell * cell = [HZTJiNengCell cellWithTableView:tableView];
        cell.title = @"拥有技能";
        return cell;
    }else if (indexPath.section == 6) {
        HZTJiNengCell * cell = [HZTJiNengCell cellWithTableView:tableView];
        cell.title = @"拥有技能";
        return cell;
    }else if (indexPath.section == 7) {
        HZTJiNengCell * cell = [HZTJiNengCell cellWithTableView:tableView];
        cell.title = @"拥有技能";
        return cell;
    }else {
        HZTJiNengCell * cell = [HZTJiNengCell cellWithTableView:tableView];
        cell.title = @"拥有技能";
        return cell;
    }
//    if (!indexPath.section) {
//        HZTMyResumeRealNameCell * cell = [HZTMyResumeRealNameCell cellWithTableViewFromXIB:tableView];
//        cell.clickRealNameBlock = ^{
//            /**跳转至实名认证页面*/
//        };
//        return cell;
//    }else{
//        if (indexPath.section == 1) {
//            if (!indexPath.row) {
//                HZTCustomHederCell * cell = [HZTCustomHederCell cellWithTableViewFromXIB:tableView];
//                cell.title = @"期望工作";
//                return cell;
//            }else{
//                HZTJiNengCell * cell = [HZTJiNengCell cellWithTableView:tableView];
//                cell.title = @"拥有技能";
//                return cell;
//            }
//        }else if (indexPath.section == 2){
//            if (!indexPath.row) {
//                HZTCustomHederCell * cell = [HZTCustomHederCell cellWithTableViewFromXIB:tableView];
//                cell.title = @"教育经历";
//                return cell;
//            }else{
//                HZTTrainCell * cell = [HZTTrainCell cellWithTableViewFromXIB:tableView];
//                cell.model = self.listModel.personJobFullVO.trainList[indexPath.row - 1];
//                cell.callBack = ^(TrainCallBackType type) {
//                    if (type == TrainCallBackType_LookMore) {
//                        weakSelf.listModel.personJobFullVO.trainList[1].isShowMore = false;
//                        weakSelf.listModel.personJobFullVO.trainList[1].cellHeight -= 30;
//                        [weakSelf.mainTableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
//                    }
//                };
//                return cell;
//            }
//        }else if (indexPath.section == 3){
//            if (!indexPath.row) {
//                HZTCustomHederCell * cell = [HZTCustomHederCell cellWithTableViewFromXIB:tableView];
//                cell.title = @"工作经历";
//                return cell;
//            }else{
//                HZTMyResumeCustomCell * cell = [HZTMyResumeCustomCell cellWithTableViewFromXIB:tableView];
//                cell.resumeModel = self.listModel.personJobFullVO.resumeList[indexPath.row - 1];
//                cell.callBack = ^(MyResumeCellCallBackType type) {
//                    [weakSelf handleResumeCellCallBackWithType:type indexPath:indexPath projiectList:nil resumeList:weakSelf.listModel.personJobFullVO.resumeList];
//                };
//                return cell;
//            }
//        }else{
//            if (!indexPath.row) {
//                HZTCustomHederCell * cell = [HZTCustomHederCell cellWithTableViewFromXIB:tableView];
//                cell.title = @"项目经验";
//                return cell;
//            }else{
//                HZTMyResumeCustomCell * cell = [HZTMyResumeCustomCell cellWithTableViewFromXIB:tableView];
//                cell.projiectModel = self.listModel.personJobFullVO.projiectList[indexPath.row - 1];
//                cell.callBack = ^(MyResumeCellCallBackType type) {
//                    [weakSelf handleResumeCellCallBackWithType:type indexPath:indexPath projiectList:weakSelf.listModel.personJobFullVO.projiectList resumeList:nil];
//                };
//                return cell;
//            }
//        }
//     }
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
    if (indexPath.section == 0) {
        return 100;
    }else if (indexPath.section == 1 || indexPath.section == 2){
        return 67;
    }else{
        return 200;
    }
//    if (!indexPath.section) {
//        return [self.listModel.nameAuthent intValue] ? .1f : 91;
//    }else{
//        if (indexPath.section == 2){
//            if (!indexPath.row) return 80;
//            return self.listModel.personJobFullVO.trainList[indexPath.row-1].cellHeight;
//        }else if (indexPath.section == 3){
//           if (!indexPath.row) return 80;
//           return self.listModel.personJobFullVO.resumeList[indexPath.row-1].cellHeight;
//        }else if (indexPath.section == 4){
//            if (!indexPath.row) return 80;
//            return self.listModel.personJobFullVO.projiectList[indexPath.row-1].cellHeight;
//        }else if(indexPath.section == 1){
//            if (indexPath.row == 0) {
//                return 100;
//            }else{
//                return 208 + 38;
//            }
//        }else{
//            return .1f;
//        }
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (!section) {
        return 0.01;
    }else{
         return 0.01;
        //return  [self handleSectionHeight:section];
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
    if (section <= 2) {
        if (!section) {
            return 101;
        }else{
            return 10;
        }
    }else{
        return 56;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WS(weakSelf)
    if (section <= 2) {
        if (!section) {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,101)];
            HZTMyResumeLevelCell * cell  = (HZTMyResumeLevelCell *)[[[NSBundle mainBundle] loadNibNamed:@"HZTMyResumeLevelCell" owner:nil options:nil] firstObject];
            cell.isExpend = weakSelf.dataArray[section].isExpend;
            cell.Block = ^{
                weakSelf.dataArray[section].isExpend = !weakSelf.dataArray[section].isExpend;
                [weakSelf.mainTableView reloadSection:section withRowAnimation:UITableViewRowAnimationNone];
            };
            cell.frame = CGRectMake(0, 10, kScreenW,91);
            [view addSubview:cell];
            return view;
        }else{
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,10)];
            return view;
        }
    }else{
        NSArray * titleArr = @[@"期望工作",@"拥有技能",@"教育经历",@"工作经历",@"项目经验",@"获得证书"];
        HZTMyResumeOtherHeaderView * view = [HZTMyResumeOtherHeaderView createMyResumeOtherHeaderViewWithCallBack:^() {
            /**展开/收起的处理*/
            weakSelf.dataArray[section].isExpend = !weakSelf.dataArray[section].isExpend;
            [weakSelf.mainTableView reloadSection:section withRowAnimation:UITableViewRowAnimationNone];
        }];
        view.isExpend = weakSelf.dataArray[section].isExpend;
        view.frame = CGRectMake(0, 0, kScreenW, 56);
        view.title = titleArr[section - 3];
        return view;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     return nil;
//    if (section) {
//        NSArray * titleArr = @[@"+添加拥有技能",@"+添加教育经历",@"+添加工作经验",@"+添加项目经验"];
//        HZTMyResumeSectionFooterView * view = [HZTMyResumeSectionFooterView createMyResumeSectionFooterViewWithTitle:titleArr[section - 1] callBack:^(NSString * _Nonnull title) {
//            NSLog(@"title:%@",title);
//        }];
//        view.frame = CGRectMake(0, 0, kScreenWidth, 58);
//        return view;
//    }else{
//        return nil;
//    }
}

#pragma mark --- 自定义导航栏渐变处理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = 0;
    if (offsetY < NAV_HEIGHT){
        alpha = offsetY/NAV_HEIGHT;
    }else {
        alpha = 1.0;
    }
    self.navView.alpha = alpha;
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
        _mainTableView.tableHeaderView = self.newsHeaderView;
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.view);
        }];
    }
    return _mainTableView;
}

-(HZTMyResumeNewsHeaderView *)newsHeaderView{
    if (!_newsHeaderView) {
        _newsHeaderView = [HZTMyResumeNewsHeaderView createMyResumeHeaderView];
        _newsHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 325);
    }
    return _newsHeaderView;
}

-(HZTMyResumeListModel *)listModel{
    if (!_listModel) {
        _listModel = [[HZTMyResumeListModel alloc] init];
    }
    return _listModel;
}

-(HZTMyResumeViewNavView *)navView{
    if(!_navView){
        _navView = [HZTMyResumeViewNavView createMyResumeViewNavView];
        _navView.frame = CGRectMake(0, 0, kScreenW, NAV_HEIGHT);
        [self.view addSubview:_navView];
    }
    return _navView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
