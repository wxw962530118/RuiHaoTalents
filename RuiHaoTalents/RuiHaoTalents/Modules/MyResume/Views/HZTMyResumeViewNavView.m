//
//  HZTMyResumeViewNavView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/17.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumeViewNavView.h"

@implementation HZTMyResumeViewNavView

+(instancetype)createMyResumeViewNavView{
    HZTMyResumeViewNavView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTMyResumeViewNavView" owner:nil options:nil] firstObject];
    return view;
}

@end
