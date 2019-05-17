//
//  HZTMyResumeOtherHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/17.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumeOtherHeaderView.h"

@interface  HZTMyResumeOtherHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;
@property (weak, nonatomic) IBOutlet UIButton *expendBtn;
@property (nonatomic, copy) void (^Block)(void);
@end

@implementation HZTMyResumeOtherHeaderView

+(instancetype)createMyResumeOtherHeaderViewWithCallBack:(void (^)(void))callBack{
    HZTMyResumeOtherHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTMyResumeOtherHeaderView" owner:nil options:nil] firstObject];
    view.Block = callBack;
    return view;
}

- (IBAction)clickExpendBtn:(id)sender {
    if (self.Block) {
        self.Block();
    }
}

-(void)setIsExpend:(BOOL)isExpend{
    _isExpend = isExpend;
    [self.expendBtn setTitle:isExpend ? @"收起" : @"展开" forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

@end
