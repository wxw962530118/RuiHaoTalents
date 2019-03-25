//
//  HZTPostDetailsHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTPostDetailsHeaderView.h"

@interface HZTPostDetailsHeaderView ()
/***/
@property (nonatomic, strong) void (^Block)(void);
@property (weak, nonatomic) IBOutlet UIView *whiteView;
/***/
@property (nonatomic, strong) UIView * shadowView;
@end

@implementation HZTPostDetailsHeaderView

+(instancetype)createPostDetailsViewWithCallBack:(void (^)(void))callBack{
    HZTPostDetailsHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTPostDetailsHeaderView" owner:nil options:nil] lastObject];
    view.whiteView.layer.cornerRadius = 10;
    view.whiteView.layer.masksToBounds = NO;
    [view.whiteView setLayerShadow:RGBColorAlpha(0, 0, 0, .3) offset:CGSizeMake(0, 1) radius:5];
    view.Block = callBack;
    return view;
}

@end
