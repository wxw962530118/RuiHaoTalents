//
//  HZTMyWalletDetailViewController.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/25.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTMyWalletDetailViewController.h"

#import "HZTMyWalletDetailCell.h"

@interface HZTMyWalletDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HZTMyWalletDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self addSubviews];
}

#pragma mark --- private

- (void)setupNav {
    self.navigationItem.title = @"零钱明细";
}

- (void)addSubviews {
    self.view.backgroundColor = HZTColorBackGround;
    
    [self addTableView];
}

#pragma mark --- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HZTMyWalletDetailCell *cell = [HZTMyWalletDetailCell cellWithTableView:tableView];
    
    return cell;
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.rowHeight = 70;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[HZTMyWalletDetailCell class] forCellReuseIdentifier:@"HZTMyWalletDetailCell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(7);
        }];
    }
}

@end
