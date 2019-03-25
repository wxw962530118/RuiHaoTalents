//
//  HZTBindingWechatWalletViewController.m
//  RuiHaoTalents
//
//  Created by zsm on 2019/3/25.
//  Copyright © 2019 王新伟. All rights reserved.
//

#import "HZTBindingWechatWalletViewController.h"

@interface HZTBindingWechatWalletViewController ()



@end

@implementation HZTBindingWechatWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self addSubviews];
}

#pragma mark --- private

- (void)setupNav {
    self.navigationItem.title = @"微信绑定";
}

- (void)addSubviews {
    self.view.backgroundColor = HZTColorBackGround;
    
}

@end
