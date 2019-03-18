//
//  HZTMenuListHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMenuListHeaderView.h"

@interface HZTMenuListHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;
/***/
@property (nonatomic, copy) void (^Block)(void);
@end

@implementation HZTMenuListHeaderView

+(instancetype)createMenuListHeaderViewWithCallBack:(void (^)(void))callBack{
    HZTMenuListHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTMenuListHeaderView" owner:nil options:nil] lastObject];
    view.userImgView.layer.cornerRadius = 28;
    view.userImgView.backgroundColor = [UIColor purpleColor];
    view.clipsToBounds = YES;
    return view;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.userNameLabel.text = @"王小新";
    self.userPhoneLabel.text= [HZTAccountManager getUser].mobile;
    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:[HZTAccountManager getUser].userIcon] placeholderImage:[UIImage imageNamed:@"left_menu_icon"]];
}

@end
