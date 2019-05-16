//
//  HZTJiNengCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/25.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTJiNengCell.h"
#import "HZTRadarChartView.h"

@interface HZTJiNengCell ()
/***/
@property (nonatomic, strong) HZTRadarChartView * radarView;
/***/
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation HZTJiNengCell

-(void)loadWithComponents{
    [self addRadarView];
    [self addTitleLabel];
}

-(void)addTitleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = HZTFontSize(17);
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(13);
        }];
    }
}

-(void)addRadarView{
    if (!_radarView) {
        NSMutableArray *items = [NSMutableArray array];
        NSArray *values = @[@8,@5,@7,@3,@6];
        NSArray *descs = @[@"苹果",@"香蕉",@"花生",@"橙子",@"车厘子"];
        for (int i = 0; i < values.count; i++) {
            HZTRadarChartDataItem *item = [HZTRadarChartDataItem dataItemWithValue:[values[i] floatValue] description:descs[i]];
            [items addObject:item];
        }
        HZTRadarChartView *radarChart = [[HZTRadarChartView alloc] initWithFrame:CGRectMake(0,15,kScreenW , 238) items:items valueDivider:2];
        radarChart.tempFillColor = RGBColorAlpha(220, 246, 243, .3);
        radarChart.tempStrokeColor = RGBColorAlpha(74, 211, 195, .3);
        radarChart.plotFillColor = RGBColorAlpha(79,193,170,.5);
        radarChart.plotStrokeColor = RGBColorAlpha(79,193,170,1);
        [radarChart strokeChart];
        [self.contentView addSubview:radarChart];
        _radarView = radarChart;
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

@end
