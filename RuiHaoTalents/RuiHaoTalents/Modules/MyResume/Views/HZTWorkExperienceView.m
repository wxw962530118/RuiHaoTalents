//
//  HZTWorkExperienceView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTWorkExperienceView.h"

@implementation HZTWorkExperienceView

+(instancetype)createWorkExperienceView{
    HZTWorkExperienceView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTWorkExperienceView" owner:nil options:nil] firstObject];
    return view;
}

@end
