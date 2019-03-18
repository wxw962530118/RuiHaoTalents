//
//  HZTMyResumeHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/18.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumeHeaderView.h"

@interface HZTMyResumeHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIconView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexIconView;
@property (weak, nonatomic) IBOutlet UILabel *dipmolaLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *userWeChatLabel;

@end

@implementation HZTMyResumeHeaderView

+(instancetype)createMyResumeHeaderView{
    HZTMyResumeHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTMyResumeHeaderView" owner:nil options:nil] lastObject];
    return view;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.userIconView.layer.cornerRadius = 45;
    self.userIconView.layer.masksToBounds = true;
    self.userIconView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setListModel:(HZTMyResumeListModel *)listModel{
    _listModel = listModel;
    [self.userIconView sd_setImageWithURL:[NSURL URLWithString:listModel.humanImage] placeholderImage:[UIImage imageNamed:@"left_menu_icon"]];
    self.userNameLabel.text = listModel.humanName;
    self.userPhoneLabel.text = listModel.humanPhone;
    self.userEmailLabel.text = [ToolBaseClass isNullClass:listModel.humanEmail] ? @"暂无" : listModel.humanEmail;
    self.userWeChatLabel.text = [ToolBaseClass isNullClass:listModel.humanWeChat] ? @"暂无" : listModel.humanWeChat;
    self.sexIconView.image = [UIImage imageNamed:[listModel.humanSex intValue] ? @"sex_girls" : @"sex_boys"];
}

#pragma mark --- 编辑个人资料
- (IBAction)clickEditBtn:(id)sender {
    
}

@end
