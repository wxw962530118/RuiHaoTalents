//
//  HZTCustomAlretView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCustomAlretView.h"

@interface HZTCustomAlretView ()
@property (nonatomic, copy) void (^Block)(void);
@property (nonatomic, strong) UIView * blackView;
@property (weak, nonatomic) IBOutlet UIImageView *stateImgView;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@end

@implementation HZTCustomAlretView
+(instancetype)createAlretView{
    HZTCustomAlretView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTCustomAlretView" owner:nil options:nil] lastObject];
    view.layer.masksToBounds = true;
    view.frame = CGRectMake((kScreenW - 268)/2,(kScreenH - 353)/2, 268, 353);
    return view;
}

-(void)configSubViewsType:(CustomAlretType)type title:(NSString *)title desc:(NSString *)desc isShowCancel:(BOOL)isShowCancel bottomTitle:(NSString *)bottomTitle callBack:(void (^)(void))callBack{
    self.stateImgView.image = [UIImage imageNamed:(type == CustomAlretType_Succeed ? @"alert_succeed" : @"alert_faild")];
    self.titleLabel.text = title;
    self.descLabel.text = desc;
    [self.bottomBtn setTitle:bottomTitle forState:UIControlStateNormal];
    self.Block = callBack;
    self.cancelBtn.hidden = !isShowCancel;
    self.alpha = 0;
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.blackView.alpha = 0;
    self.blackView.backgroundColor = RGBColorAlpha(0, 0, 0, .2);
    [[ToolBaseClass getRootWindow] addSubview:self.blackView];
    [[ToolBaseClass getRootWindow] addSubview:self];
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 1;
        self.blackView.alpha = 1;
    }];
    
}
- (IBAction)clickCancleBtn:(id)sender {
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 0;
        self.blackView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.blackView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (IBAction)clickSureBtn:(id)sender {
    if (self.Block) {
        self.Block();
    }
    [self clickCancleBtn:self.cancelBtn];
}

-(void)dealloc{
    NSLog(@"HZTCustomAlretView dealloc");
}

@end
