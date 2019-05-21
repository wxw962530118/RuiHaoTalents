//
//  HZTMyResumeNewsHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/17.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumeNewsHeaderView.h"
#import "HZTShareView.h"
@interface HZTMyResumeNewsHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *topBgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
/***/
@property (nonatomic, strong) UIVisualEffectView * effectView;
@end

@implementation HZTMyResumeNewsHeaderView
+(instancetype)createMyResumeHeaderView{
    HZTMyResumeNewsHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTMyResumeNewsHeaderView" owner:nil options:nil] firstObject];
    return view;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.userImgView.layer.borderWidth = 1;
    self.userImgView.layer.borderColor = RGBColor(255, 255, 255).CGColor;
    self.userImgView.layer.cornerRadius = 44.5;
    self.userImgView.layer.masksToBounds = true;
    [self addEffectView];
}

-(void)addEffectView{
    if (!_effectView) {
        [self layoutIfNeeded];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _effectView.frame = self.topBgImgView.bounds;
        [self.topBgImgView insertSubview:_effectView atIndex:0];
    }
}

-(void)setListModel:(HZTMyResumeListModel *)listModel{
    _listModel = listModel;
    self.userNameLabel.text = listModel.humanName;
    self.sexImgView.image = [UIImage imageNamed:[listModel.humanSex intValue] ? @"sex_girls" : @"sex_boys"];
    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:listModel.humanImage] placeholderImage:[UIImage imageNamed:@"left_menu_icon"]];
    [self.topBgImgView sd_setImageWithURL:[NSURL URLWithString:listModel.humanImage] placeholderImage:[UIImage imageNamed:@"left_menu_icon"]];
}

- (IBAction)clickEditBtn:(id)sender {
    
}

- (IBAction)clickBackBtn:(id)sender {
    [App_TheFrontNavC popViewControllerAnimated:YES];
}

- (IBAction)clcikShareBtn:(id)sender {
    [HZTShareView showWithCallBack:^(ShareType type) {
        
    }];
}

@end
