//
//  HZTBaseViewController.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTBaseViewController.h"

@interface HZTBaseViewController ()
/***/
@property (nonatomic, copy) void (^Block)(void);
/***/
@property (nonatomic, strong) UILabel * noDataLabel;
@end

@implementation HZTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSelf];
    [self configBackItem];
    [self configTableContentInset];
}

-(void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    self.navigationItem.title = navTitle;
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
    [HZTToastHUD hideLoading];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)xw_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.navigationController pushViewController:viewController animated:animated];
}

-(void)xw_popViewController:(UIViewController * __nullable)viewController animated:(BOOL)animated{
    if (viewController) {
        for (UIViewController * vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[viewController class]]) {
                /**当前导航控制器 栈内存在 指定控制器 则 pop回vc*/
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }else{
        [self.navigationController popViewControllerAnimated:animated];
    }
}

-(void)ctNavRightItemWithTitle:(NSString * __nullable)title imageName:(NSString * __nullable)imageName callBack:(nonnull void (^)(void))callBack{
    self.Block = callBack;
    UIButton * btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(clickRightItem) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:RGBColor(85, 85, 85) forState:UIControlStateNormal];
    btn.titleLabel.font = HZTFontSize(15);
    if (title && imageName) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,[ToolBaseClass getWidthWithString:[btn currentTitle] font:btn.titleLabel.font],0, -[ToolBaseClass getWidthWithString:[btn currentTitle] font:btn.titleLabel.font]-15)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,-10, 0, 10)];
    }else if (title){
        [btn setTitle:title forState:UIControlStateNormal];
    }else if (imageName){
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)showNoDataViewWithSupersView:(UIView *)supersView{
    [self addNoDataLabelWithView:supersView];
}

-(void)hideNoDataView{
     self.noDataLabel.hidden = true;
}

-(void)clickRightItem{
    if (self.Block) {
        self.Block();
    }
}

-(void)addNoDataLabelWithView:(UIView *)view{
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] init];
        _noDataLabel.hidden = false;
        _noDataLabel.text = @"暂无内容哦O(∩_∩)O哈哈~";
        _noDataLabel.font = HZTFontSize(18);
        _noDataLabel.textColor = RGBColorAlpha(0, 0, 0, .6);
        [view addSubview:self.noDataLabel];
        [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.centerY.equalTo(view.mas_centerY);
        }];
    }
}

- (void)dealloc {
    NSLog(@"dealloc %@--%@", [self className], [self superclass]);
}

@end
