//
//  HZTHomeBottomCell.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/14.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTHomeBottomCell.h"
#import "SDCycleScrollView.h"
@interface HZTHomeBottomCell ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *viewsArray;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *topImgsArray;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *centerImgsArray;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *bottomLabelsArray;
/***/
@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;
@end

@implementation HZTHomeBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addCycleScrollView];
    for (int i = 0; i< self.viewsArray.count; i++) {
        UIView * view = (UIView *)self.viewsArray[i];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [view addGestureRecognizer:tap];
        UIImageView * topImgView = (UIImageView *)self.topImgsArray[i];
        UIImageView * centerImgView = (UIImageView *)self.centerImgsArray[i];
        UILabel * bottomLabel = (UILabel *)self.bottomLabelsArray[i];
        if (i == 0) {
            topImgView.image = [UIImage imageNamed:@"home_tongguan"];
            centerImgView.image = [UIImage imageNamed:@"home_localuser_icon"];
            bottomLabel.text = @"小王";
        }else if (i == 1){
            topImgView.image = [UIImage imageNamed:@"home_tongguan"];
            centerImgView.image = [UIImage imageNamed:@"home_localuser_icon"];
            bottomLabel.text = @"小李";
        }else{
            topImgView.image = [UIImage imageNamed:@"home_jinguna"];
            centerImgView.image = [UIImage imageNamed:@"home_localuser_icon"];
            bottomLabel.text = @"小马";
        }
    }
}

-(void)addCycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(35, 0, kScreenW - 58,30) delegate:self placeholderImage:nil];
        _cycleScrollView.layer.cornerRadius = 5;
        _cycleScrollView.layer.masksToBounds = true;
        _cycleScrollView.backgroundColor = RGBColor(239, 239, 239);
        _cycleScrollView.onlyDisplayText = true;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _cycleScrollView.titlesGroup = @[@"qwer",@"123",@"mmmm"];
        [self.scrollContentView addSubview:_cycleScrollView];
    }
}

#pragma mark --- 查看更多
- (IBAction)clickMoreBtn:(id)sender {

}

-(void)tapView:(UITapGestureRecognizer *)tap{
    NSInteger idx = [self.viewsArray indexOfObject:tap.view];
    if (idx == 0) {
        NSLog(@"");
    }else if (idx == 1){
        
    }else{
        
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

@end
