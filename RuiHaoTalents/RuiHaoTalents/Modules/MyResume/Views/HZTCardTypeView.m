//
//  HZTCardTypeView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCardTypeView.h"

@implementation HZTCardTypeView

+(instancetype)createCardTypeView{
    HZTCardTypeView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTCardTypeView" owner:nil options:nil] firstObject];
    return view;
}
@end
