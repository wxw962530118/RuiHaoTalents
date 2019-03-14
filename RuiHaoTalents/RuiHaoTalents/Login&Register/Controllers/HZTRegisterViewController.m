//
//  HZTRegisterViewController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTRegisterViewController.h"
#import "HZTLoginRegisterCell.h"
#import "HZTLoginRegisterModel.h"
@interface HZTRegisterViewController ()<UITableViewDelegate,UITableViewDataSource,TYAttributedLabelDelegate>
/***/
@property (nonatomic, strong) UITableView * tableView;
/***/
@property (nonatomic, strong) UIView * headerView;
/**/
@property (nonatomic, strong) UIView * footerView;
/***/
@property (nonatomic, strong) TYAttributedLabel * attributedLabel;
/***/
@property (nonatomic, strong) NSMutableArray <HZTLoginRegisterModel *>* dataArray;
@end

@implementation HZTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    [self prepareData];
    [self addAttributedLabel];
}

-(void)prepareData{
    NSArray * placeholderArr = @[@"请输入手机号码",@"请输入密码",@"请输入验证码"];
    NSArray * iconArr = @[@"login_phone",@"login_password",@"login_password"];
    for (int i = 0; i< placeholderArr.count; i++) {
        HZTLoginRegisterModel * model = [[HZTLoginRegisterModel alloc] init];
        model.placeholder = placeholderArr[i];
        model.iconName = iconArr[i];
        model.isShowGetCode = i>=2;
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZTLoginRegisterCell * cell = [HZTLoginRegisterCell cellWithTableViewFromXIB:tableView];
    cell.model = self.dataArray[indexPath.row];
    cell.getCodeBtnCallBack = ^{
        /**拉取获取验证码协议 成功后开始定时器*/
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark --- 懒加载相关
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = HZTClearColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footerView;
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.allowsSelection = false;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.view);
        }];
    }
    return _tableView;
}

-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 90)];        HZTMajorButton * registerBtn  = [[HZTMajorButton alloc] init];
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        registerBtn.layer.cornerRadius = 5;
        registerBtn.layer.masksToBounds = true;
        [registerBtn addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:registerBtn];
        [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_footerView.mas_left).offset(10);
            make.right.equalTo(_footerView.mas_right).offset(-10);
            make.top.equalTo(_footerView.mas_top).offset(30);
            make.height.mas_equalTo(45);
        }];

    }
    return _footerView;
}

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)addAttributedLabel{
    if (!_attributedLabel) {
        _attributedLabel = [[TYAttributedLabel alloc]init];
        _attributedLabel.textColor = [UIColor blackColor];
        _attributedLabel.delegate = self;
        _attributedLabel.font = HZTFontSize(14);
        _attributedLabel.numberOfLines = 0;
        _attributedLabel.text = @"注册登录即表示您已同意";
        _attributedLabel.textAlignment = kCTTextAlignmentCenter;
        [_attributedLabel appendLinkWithText:@"《用户注册与隐私保护协议》" linkFont:HZTFontSize(14) linkColor:HZTMainColor underLineStyle:kCTUnderlineStyleNone linkData:@"http://baidu.com"];
        [self.view addSubview:_attributedLabel];
        [self.view bringSubviewToFront:_attributedLabel];
        [_attributedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(IS_IPhoneX() ? -20 : -10);
            make.size.mas_equalTo(CGSizeMake(kScreenW, 30));
        }];
    }
}

#pragma mark --- 富文本点击
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point {
    if ([TextRun isKindOfClass:[TYLinkTextStorage class]]) {
        NSString * linkStr = ((TYLinkTextStorage*)TextRun).linkData;
        NSLog(@"linkStr === %@",linkStr);
    }
}

#pragma 点击注册按钮 注册成功引导用户登录<或直接根据用户的注册的手机号码及密码直接登录 具体根据需求而定>
-(void)clickRegister{
    [[ToolBaseClass getRootWindow] endEditing:YES];
    HZTLoginRegisterCell * cell = [self.tableView.visibleCells lastObject];
    [cell getCodeSucceed];
}

@end
