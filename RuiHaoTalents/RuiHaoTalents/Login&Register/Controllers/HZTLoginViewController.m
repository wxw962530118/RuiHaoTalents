//
//  HZTLoginViewController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTLoginViewController.h"
#import "HZTRegisterViewController.h"
#import "HZTLoginRegisterModel.h"
#import "HZTLoginRegisterCell.h"
#import "HZTLoginWorkManager.h"
@interface HZTLoginViewController ()<UITableViewDelegate,UITableViewDataSource,TYAttributedLabelDelegate>
/***/
@property (nonatomic, strong) UITableView * tableView;
/***/
@property (nonatomic, strong) UIView * headerView;
/**/
@property (nonatomic, strong) UIView * footerView;
/**当前是否为密码登录*/
@property (nonatomic, assign) BOOL isPassWordLogin;
/***/
@property (nonatomic, strong) UIButton * loginTypeBtn;
/***/
@property (nonatomic, strong) TYAttributedLabel * attributedLabel;
/***/
@property (nonatomic, strong) NSMutableArray <HZTLoginRegisterModel *>* dataArray;
/**当前输入的手机号码*/
@property (nonatomic, copy) NSString * phone;
/**当前密码*/
@property (nonatomic, copy) NSString * password;
/**当前验证码*/
@property (nonatomic, copy) NSString * code;
/***/
@property (nonatomic, strong) HZTMajorButton * loginBtn;

@end

@implementation HZTLoginViewController

-(instancetype)init{
    if (self = [super init]) {
        /**默认为密码登录*/
        self.password = @"";
        self.phone = @"";
        self.isPassWordLogin = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavItem];
    [self prepareData];
    [self addAttributedLabel];
}

-(void)configNavItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(disMissLoagin)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(clickRegister)];
    [self.navigationController.navigationBar setTintColor:HZTColorEmphasis];
}

-(void)prepareData{
    [self.dataArray removeAllObjects];
    if (self.self.isPassWordLogin) {
        NSArray * placeholderArr = @[@"请输入手机号码",@"请输入8-16位密码"];
        NSArray * iconArr = @[@"login_phone",@"login_password"];
        for (int i = 0; i< placeholderArr.count; i++) {
            HZTLoginRegisterModel * model = [[HZTLoginRegisterModel alloc] init];
            if (![ToolBaseClass isNullClass:self.phone] && !i) {
                model.phone = self.phone;
            }
            if (![ToolBaseClass isNullClass:self.password] && i==1) {
                model.password = self.password;
            }
            model.placeholder = placeholderArr[i];
            model.iconName = iconArr[i];
            model.isShowGetCode = false;
            [self.dataArray addObject:model];
        }
    }else{
        NSArray * placeholderArr = @[@"请输入手机号码",@"请输入验证码"];
        NSArray * iconArr = @[@"login_phone",@"login_password"];
        for (int i = 0; i< placeholderArr.count; i++) {
            HZTLoginRegisterModel * model = [[HZTLoginRegisterModel alloc] init];
            if (![ToolBaseClass isNullClass:self.phone] && !i) {
                model.phone = self.phone;
            }
            model.placeholder = placeholderArr[i];
            model.iconName = iconArr[i];
            model.isShowGetCode = i;
            [self.dataArray addObject:model];
        }
    }
    [self.tableView reloadData];
}

-(void)disMissLoagin{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickRegister{
    WS(weakSelf)
    HZTRegisterViewController * vc = [[HZTRegisterViewController alloc] init];
    vc.registerSucceed = ^(NSString * _Nonnull phone, NSString * _Nonnull password) {
        weakSelf.phone = phone;
        weakSelf.password = password;
        [weakSelf prepareData];
    };
    [self xw_pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf)
    HZTLoginRegisterCell * cell = [HZTLoginRegisterCell cellWithTableViewFromXIB:tableView];
    cell.model = self.dataArray[indexPath.row];
    cell.textChangedBlock = ^(NSString * _Nonnull str, NSString * _Nonnull placeholder) {
        if ([placeholder isEqualToString:@"请输入手机号码"]) {
            weakSelf.phone = str;
        }else if ([placeholder isEqualToString:@"请输入8-16位密码"]){
            weakSelf.password = str;
        }else{
            weakSelf.code = str;
        }
    };
    cell.getCodeBtnCallBack = ^{
        /**拉取获取验证码协议 成功后开始定时器*/
        if(!weakSelf.phone.length){
            [HZTToastHUD showNormalWithTitle:@"请输入手机号码"];
            return ;
        }else if (weakSelf.phone.length < 11) {
            [HZTToastHUD showNormalWithTitle:@"请输入11位手机号码"];
            return;
        }
        [HZTToastHUD showLoading];
        [[HZTLoginWorkManager manager] requestRegisterMobileCodeWithMobile:weakSelf.phone succeed:^(id  _Nonnull responseObject) {
            [HZTToastHUD hideLoading];
            [MBProgressHUD showSuccess:@"获取验证码成功"];
            HZTLoginRegisterCell * lastCell = [weakSelf.tableView.visibleCells lastObject];
            [lastCell getCodeSucceed];
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            
        }];
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

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 110)];
        UILabel * label = [[UILabel alloc] init];
        label.font = HZTFontSize(18);
        label.text = @"欢迎登录";
        [_headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_headerView.mas_centerY);
            make.left.equalTo(_headerView.mas_left).offset(10);
        }];
    }
    return _headerView;
}

-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 190)];
        HZTMajorButton * loginBtn  = [[HZTMajorButton alloc] init];
        self.loginBtn = loginBtn;
        [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        loginBtn.layer.cornerRadius = 5;
        loginBtn.layer.masksToBounds = true;
        [loginBtn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_footerView.mas_left).offset(10);
            make.right.equalTo(_footerView.mas_right).offset(-10);
            make.top.equalTo(_footerView.mas_top).offset(30);
            make.height.mas_equalTo(45);
        }];
        
        self.loginTypeBtn = [[UIButton alloc] init];
        self.loginTypeBtn.titleLabel.font = HZTFontSize(15);
        [self.loginTypeBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
        [self.loginTypeBtn setTitleColor:HZTMainColor forState:UIControlStateNormal];
        [self.loginTypeBtn addTarget:self action:@selector(clickLoginType) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:self.loginTypeBtn];
        [self.loginTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_footerView);
            make.top.equalTo(loginBtn.mas_bottom).offset(20);
            make.width.mas_equalTo(100);
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
        _attributedLabel.numberOfLines = 1;
        _attributedLabel.text = @"登录即表示您已同意";
        _attributedLabel.textAlignment = kCTTextAlignmentCenter;
        [_attributedLabel appendLinkWithText:@"《服务协议》" linkFont:HZTFontSize(14) linkColor:HZTMainColor underLineStyle:kCTUnderlineStyleNone linkData:@"http://baidu.com"];
        [self.view addSubview:_attributedLabel];
        [self.view bringSubviewToFront:_attributedLabel];
        [_attributedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(IS_IPhoneX() ? -20 : -10);
            make.size.mas_equalTo(CGSizeMake(kScreenW, 30));
        }];
    }
}

#pragma mark --- 点击登录按钮
-(void)clickLogin{
    if (!self.phone.length){
        [HZTToastHUD showNormalWithTitle:@"请输入手机号码"];
        return;
    }else if (self.phone.length < 11){
        [HZTToastHUD showNormalWithTitle:@"请输入11位手机号码"];
        return;
    }else if (!self.password.length && self.isPassWordLogin){
         [HZTToastHUD showNormalWithTitle:@"请输入密码"];
        return;
    }else if ((self.password.length < 8 || self.password.length > 16) && self.isPassWordLogin){
        [HZTToastHUD showNormalWithTitle:@"请输入8-16位密码"];
        return;
    }
    if (!self.isPassWordLogin) {
        if (!self.code.length){
            [HZTToastHUD showNormalWithTitle:@"请输入验证码"];
            return;
        }else if (self.code.length != 6){
            [HZTToastHUD showNormalWithTitle:@"请输入6位验证码"];
            self.loginBtn.isInvalid = false;
            return;
        }
    }
    [HZTToastHUD showLoading];
    [[HZTLoginWorkManager manager] requestSigninWithMobile:self.phone password:self.password verifyCode:self.code succeed:^(id  _Nonnull responseObject) {
        [self.view endEditing:YES];
        [HZTToastHUD hideLoading];
        /**登录成功之后同步到当前账户信息*/
        [MBProgressHUD showSuccess:@"登录成功"];
        NSMutableDictionary * tempDict = [[NSMutableDictionary alloc] initWithDictionary:responseObject[@"data"]];
        if (responseObject[@"humanId"]) {
            [tempDict setObject:responseObject[@"humanId"] forKey:@"humanId"];
        }
        HZTAccountModel * account = [HZTAccountModel mj_objectWithKeyValues:tempDict];
        account.passWord = self.password;
        [HZTAccountManager saveUserWithAccount:account];
        [HZTAccountManager saveLastLoginPhoneWithAccount:account];
        [HZTAccountManager saveLastPassWordWithAccount:account];
        NotificationPost(HZTNOTIFICATION_DID_LOGIN_SUCCEED, nil, nil);
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        self.loginBtn.isInvalid = false;
        NSDictionary * errorDic = [ToolBaseClass changeErrorToNSDictionary:error];
        [HZTToastHUD showNormalWithTitle:[errorDic objectForKey:@"msg"]];
        [HZTToastHUD hideLoading];
    }];
}

#pragma mark --- 切换登录方式
-(void)clickLoginType{
    self.isPassWordLogin = !self.isPassWordLogin;
    [self.loginTypeBtn setTitle:self.isPassWordLogin ? @"验证码登录" : @"密码登录" forState:UIControlStateNormal];
    [self prepareData];
}

#pragma mark --- 富文本点击
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point {
    if ([TextRun isKindOfClass:[TYLinkTextStorage class]]) {
        NSString * linkStr = ((TYLinkTextStorage*)TextRun).linkData;
        NSLog(@"linkStr === %@",linkStr);
//        [[ToolBaseClass shareManager] showAlertViewType:CustomAlretType_Succeed title:@"推荐成功" desc:@"你可以前往我是伯乐-我的推荐查看" isShowCancel:YES bottomTitle:@"立即前往" callBack:^{
//            NSLog(@"立即前往");
//        }];
//        [HZTCustomSheetView showCustomSheetViewTitle:@"选择地图" contentArr:@[@"高德",@"百度",@"谷歌"] callBack:^(NSInteger index) {
//
//        }];
//        [HZTCustomPickerView showPickerViewWithTitle:@"选择性别" dataArray:@[@[@"未知",@"男",@"女"]] callBack:^(HZTCustomPickerModel * _Nonnull model) {
//
//        }];
    }
}

@end
