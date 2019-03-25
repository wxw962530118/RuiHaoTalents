//
//  HZTShareView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTShareView.h"

@interface HZTShareView ()
/***/
@property (nonatomic, strong) UIView * blackView;
/***/
@property (nonatomic, assign) void (^Block)(ShareType type);
@end

@implementation HZTShareView

+(instancetype)showWithCallBack:(void (^)(ShareType))callBack{
    HZTShareView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTShareView" owner:nil options:nil] lastObject];
    view.Block = callBack;
    return view;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.blackView.alpha = 0;
    [RootWindow addSubview:self];
    self.frame = CGRectMake(0,kScreenH, kScreenW,207);
    [UIView animateWithDuration:.3f animations:^{
        self.blackView.alpha = .2f;
        self.frame = CGRectMake(0,kScreenH - 207, kScreenW,207);
    }];
}

-(UIView *)blackView{
    if (!_blackView) {
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _blackView.backgroundColor = RGBColor(0, 0, 0);
        [_blackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)]];
        [RootWindow addSubview:_blackView];
    }
    return _blackView;
}

-(void)hideView{
    [UIView animateWithDuration:.3f animations:^{
        self.blackView.alpha = 0;
        self.frame = CGRectMake(0,kScreenH, kScreenW,207);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.blackView removeFromSuperview];
    }];
}
- (IBAction)shareToWx:(id)sender {
    if (self.Block) {
        self.Block(ShareType_WeChat);
    }
    [self hideView];
}

- (IBAction)shareToFriends:(id)sender {
    if (self.Block) {
        self.Block(ShareType_Friends);
    }
    [self hideView];
}

- (IBAction)clickCancel:(id)sender {
    [self hideView];
}

@end
