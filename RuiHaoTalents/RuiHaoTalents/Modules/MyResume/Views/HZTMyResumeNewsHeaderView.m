//
//  HZTMyResumeNewsHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/17.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTMyResumeNewsHeaderView.h"

@implementation HZTMyResumeNewsHeaderView
+(instancetype)createMyResumeHeaderView{
    HZTMyResumeNewsHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTMyResumeNewsHeaderView" owner:nil options:nil] firstObject];
    return view;
}

-(void)setListModel:(HZTMyResumeListModel *)listModel{
    _listModel = listModel;
    
}

@end
