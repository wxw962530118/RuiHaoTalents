//
//  HZTHorScrollCardView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTHorScrollCardView.h"

@implementation HZTHorScrollCardView

+(instancetype)createHorScrollCardView{
    HZTHorScrollCardView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTHorScrollCardView" owner:nil options:nil] firstObject];
    return view;
}


@end
