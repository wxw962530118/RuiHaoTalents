//
//  HZTImmediateMatchHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/20.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTImmediateMatchHeaderView.h"

@interface HZTImmediateMatchHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *areaJobNameLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsArray;

@end

@implementation HZTImmediateMatchHeaderView

+(instancetype)createHomeHeaderView{
    HZTImmediateMatchHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTImmediateMatchHeaderView" owner:nil options:nil] lastObject];
    view.clipsToBounds = YES;
    return view;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    /**处理默认项*/
    for (int i = 0; i< self.btnsArray.count; i++) {
        UIButton * btn = (UIButton *)self.btnsArray[i];
        [btn setTitleColor:!i ? HZTMainColor : RGBColor(51, 51, 51) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)clickBtn:(UIButton *)sender{
    for (UIButton * btn in self.btnsArray) {
        [btn setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    }
    [sender setTitleColor:HZTMainColor forState:UIControlStateNormal];
    CallBackType type;
    if ([[sender currentTitle] isEqualToString:@"综合排序"]) {
        type = CallBackType_AllSort;
    }else if ([[sender currentTitle] isEqualToString:@"距离"]) {
         type = CallBackType_Distance;
    }else if ([[sender currentTitle] isEqualToString:@"薪资"]) {
         type = CallBackType_Pay;
    }else{
         type = CallBackType_Score;
    }
    if (self.callBack) {
        self.callBack(type);
    }
}

@end
