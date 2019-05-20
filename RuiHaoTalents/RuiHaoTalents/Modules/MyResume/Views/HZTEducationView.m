//
//  HZTEducationView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTEducationView.h"

@implementation HZTEducationView

+(instancetype)createEducationView{
    HZTEducationView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTEducationView" owner:nil options:nil] firstObject];
    return view;
}

@end
