//
//  HZTCustomSheetView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCustomSheetView.h"
@interface HZTCustomSheetView ()
/***/
@property (nonatomic, strong) void (^Block)(NSInteger index);
/***/
@property (nonatomic, strong) UIView * tempView;
@end

@implementation HZTCustomSheetView

+(instancetype)showCustomSheetViewTitle:(NSString *)title contentArr:(NSArray<NSString *> *)contentArr callBack:(void (^)(NSInteger))callBack{
    HZTCustomSheetView * view = [[HZTCustomSheetView alloc] initWithCustomSheetViewTitle:title contentArr:contentArr callBack:callBack];
    return view;
}

-(instancetype)initWithCustomSheetViewTitle:(NSString *)title contentArr:(NSArray<NSString *> *)contentArr callBack:(void (^)(NSInteger))callBack{
    if (self = [super init]) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)]];
        self.backgroundColor = RGBColorAlpha(0, 0, 0, 0);
        self.Block = callBack;
        self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        [[ToolBaseClass getRootWindow] addSubview:self];
        CGFloat tempViewH = 45 + (54 * contentArr.count);
        self.tempView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenH, kScreenW,tempViewH)];
        self.tempView.backgroundColor = HZTColorWhiteGround;
        [[ToolBaseClass getRootWindow] addSubview:self.tempView];
        UILabel * label = [[UILabel alloc] init];
        label.font = HZTFontSize(14);
        label.textColor = RGBColorAlpha(160, 160, 160, 1);
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        [self.tempView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.tempView);
            make.height.mas_equalTo(45);
        }];
        
        for (int i = 0; i< contentArr.count; i++) {
            UIButton * btn = [[UIButton alloc] init];
            btn.tag = 1000 + i;
            btn.titleLabel.font = HZTFontSize(21);
            [btn setTitleColor:RGBColor(0, 0, 0) forState:UIControlStateNormal];
            [btn setTitle:contentArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.tempView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.tempView);
                make.top.equalTo(self.tempView.mas_top).offset(45 + (i * 54));
                make.height.mas_equalTo(54);
            }];
            
            UIView * lineView = [[UIView alloc] init];
            lineView.backgroundColor = HZTColorComponentLine;
            [self.tempView addSubview:lineView];
            [btn addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(btn);
                make.height.mas_equalTo(.5f);
            }];
        }
        [UIView animateWithDuration:.3f animations:^{
            self.tempView.y = kScreenH - tempViewH;
            self.backgroundColor = RGBColorAlpha(0, 0, 0, .2);
        }];
    }
    return self;
}

-(void)hideView{
    [UIView animateWithDuration:.3f animations:^{
        self.tempView.y = kScreenH;
        self.backgroundColor = RGBColorAlpha(0, 0, 0,0);
    } completion:^(BOOL finished) {
        [self.tempView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void)clickBtn:(UIButton *)sender{
    if (self.Block) {
        self.Block(sender.tag - 1000);
    }
    [self hideView];
}

@end
