//
//  HZTCertificatesCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/5/21.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTCertificatesCell.h"
#import "HZTCertificatesView.h"

@interface HZTCertificatesCell ()

/***/
@property (nonatomic, strong) UIView * cerSuperView;

@end

@implementation HZTCertificatesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = HZTMainColor;
    [self addCerSuperView];
}

-(void)addCerSuperView{
    if (!_cerSuperView) {
        _cerSuperView = [[UIView alloc] init];
        [self.contentView addSubview:_cerSuperView];
        [_cerSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.contentView);
        }];
        
        for (int i = 0; i< 2; i++) {
            HZTCertificatesView * view = [HZTCertificatesView createCertificatesView];
            view.layer.cornerRadius = 5;
            [_cerSuperView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_cerSuperView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(343, 67));
                make.top.equalTo(_cerSuperView.mas_top).offset(!i ? 15 : (i*(67 + 7) +15));
            }];
        }
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 344, 48)];
        [btn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
        btn.titleLabel.font = HZTFontSize(15);
        [btn setTitle:@"添加获得证书" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = RGBColor(255, 255, 255).CGColor;
        [_cerSuperView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_cerSuperView.mas_centerX);
            make.bottom.equalTo(_cerSuperView.mas_bottom).offset(-15);
            make.size.mas_equalTo(CGSizeMake(344, 48));
        }];
    }
}

@end
