//
//  HZTBaseViewController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseViewController.h"

@interface HZTBaseViewController ()

@end

@implementation HZTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSelf];
    [self configBackItem];
    [self configTableContentInset];
}

-(void)configSelf{
    self.view.backgroundColor = HZTColorWhiteGround;
    /**自定义导航栏返回按钮 系统侧滑返回失效 处理*/
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

-(void)configBackItem{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.frame = (CGRect){{0,0}, {40, 40}};
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

-(void)configTableContentInset{
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
