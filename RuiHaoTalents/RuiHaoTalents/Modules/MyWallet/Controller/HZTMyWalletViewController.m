//
//  HZTMyWalletViewController.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/25.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTMyWalletViewController.h"
#import "HZTMyWalletDetailViewController.h"
#import "HZTBindingWechatWalletViewController.h"

#import "HZTMyWalletHeaderView.h"
#import "HZTMyWalletCell.h"

@interface HZTMyWalletViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, strong) HZTMyWalletHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *imageNames;
@property (nonatomic, copy) NSArray *titles;

@end

@implementation HZTMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self addSubviews];
}

#pragma mark --- private

- (void)setupNav {
    self.navigationItem.title = @"我的钱包";
}

- (void)addSubviews {
    self.view.backgroundColor = [UIColor whiteColor];

    [self addTipsLabel];
    [self addTableView];
}

#pragma mark --- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HZTMyWalletCell *cell = [HZTMyWalletCell cellWithTableView:tableView];
    [cell setImg:self.imageNames[indexPath.row] text:self.titles[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        HZTBindingWechatWalletViewController *vc = [[HZTBindingWechatWalletViewController alloc] init];
        [self xw_pushViewController:vc animated:YES];
    } else {
        HZTMyWalletDetailViewController *vc = [[HZTMyWalletDetailViewController alloc] init];
        [self xw_pushViewController:vc animated:YES];
    }
}

#pragma mark --- 懒加载相关
- (void)addTipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.text = @"平台保证您的账户安全，请放心操作";
        _tipsLabel.font = HZTFontSize(12);
        _tipsLabel.textColor = RGBColor(240, 173, 5);
        _tipsLabel.backgroundColor = RGBColor(242, 239, 190);
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_tipsLabel];
        [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.height.mas_equalTo(33);
        }];
    }
}

- (HZTMyWalletHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HZTMyWalletHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 211)];
    }
    return _headerView;
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.rowHeight = 70;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [_tableView registerClass:[HZTMyWalletCell class] forCellReuseIdentifier:@"HZTMyWalletCell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(14);
        }];
    }
}

- (NSArray *)imageNames {
    if (!_imageNames) {
        _imageNames = @[@"profile_mywallet_wechat", @"profile_mywallet"];
    }
    return _imageNames;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"绑定微信钱包", @"我的零钱明细"];
    }
    return _titles;
}

@end
