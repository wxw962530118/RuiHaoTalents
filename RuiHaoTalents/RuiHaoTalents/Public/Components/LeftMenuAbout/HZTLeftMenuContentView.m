//
//  HZTLeftMenuContentView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTLeftMenuContentView.h"
#import "HZTLeftMenuView.h"
#import "HZTMenuListView.h"

@interface HZTLeftMenuContentView ()
/***/
@property (nonatomic, strong) HZTLeftMenuView * leftMenuView;
/***/
@property (nonatomic, strong) HZTMenuListView * menuListView;
/**/
@property (nonatomic, strong) UIView * vesselView;
@end

@implementation HZTLeftMenuContentView

-(instancetype)initWithFrame:(CGRect)frame vesselView:(UIView *)vesselView{
    if (self = [super initWithFrame:frame]) {
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        self.hidden = true;
        self.vesselView = vesselView;
        [self addMenuListView];
        [self addLeftMenuView];
    }
    return self;
}

-(void)addLeftMenuView{
    if(!_leftMenuView){
        _leftMenuView = [HZTLeftMenuView menuViewWithVesselView:self.vesselView leftMenuView:self.menuListView isShowCover:true];
    }
}

-(void)addMenuListView{
    WS(weakSelf)
    if (!_menuListView) {
        _menuListView = [[HZTMenuListView alloc] initWithFrame:CGRectMake(0, 0,kScreenW - 100, kScreenH) callBack:^{
            [weakSelf.leftMenuView hidenWithAnimation];
        }];
    }
}

-(void)showMenuView{
    self.hidden = false;
    [_leftMenuView show];
}

@end
