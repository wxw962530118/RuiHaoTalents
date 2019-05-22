//
//  HZTWorkExperienceView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTWorkExperienceView.h"

@interface HZTWorkExperienceView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation HZTWorkExperienceView

+(instancetype)createWorkExperienceView{
    HZTWorkExperienceView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTWorkExperienceView" owner:nil options:nil] firstObject];
    return view;
}

-(void)setModel:(HZTResumeModel *)model{
    _model = model;
    self.titleLabel.text = model.resumeName;
    self.timeLabel.text = model.startDate;
    self.descLabel.text = model.resumeDescribe;
}

-(void)setProjectModel:(HZTProjiectModel *)projectModel{
    _projectModel = projectModel;
    self.titleLabel.text = projectModel.projectName;
    self.timeLabel.text = projectModel.projectPost;
    self.descLabel.text = projectModel.projectDescribe;
}

@end
