//
//  HZTCertificatesView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCertificatesView.h"

@implementation HZTCertificatesView

+(instancetype)createCertificatesView{
    HZTCertificatesView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTCertificatesView" owner:nil options:nil] firstObject];
    return view;
}


@end
