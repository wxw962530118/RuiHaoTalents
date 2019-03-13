//
//  HZTHomeHeaderView.m
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/13.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import "HZTHomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "HZTPageControl.h"
@interface HZTHomeHeaderView ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView * cycleView;
/***/
@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;
/***/
@property (nonatomic, strong) HZTPageControl * pageControl;
/***/
@property (nonatomic, strong) NSArray * localImageArr;
@end

@implementation HZTHomeHeaderView

+(instancetype)createHomeHeaderView{
    HZTHomeHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HZTHomeHeaderView" owner:nil options:nil] lastObject];
    view.clipsToBounds = YES;
    return view;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self configCycleInfo];
    [self createPageControl];
}

-(void)configCycleInfo{
    self.localImageArr = @[@"IMG_01",@"IMG_02"];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW,147) delegate:self placeholderImage:nil];
    self.cycleScrollView.localizationImageNamesGroup = self.localImageArr;
    [self.cycleView addSubview:self.cycleScrollView];
    self.cycleScrollView.showPageControl = false;
}

#pragma mark --- HZTPageControl 自定义分页控件
- (void)createPageControl{
    _pageControl = [[HZTPageControl alloc]initWithPageCount:self.localImageArr.count type:HZTPageControlType_rectangle pageContrlSize:CGSizeMake(10,10)];
    [self.cycleView addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth - 10);
        make.height.mas_equalTo(25);
        make.bottom.equalTo(self.cycleView.mas_bottom);
        make.right.equalTo(self.cycleView.mas_right);
    }];
    _pageControl.pageSpace = 20;
    _pageControl.currentPageNumber = 0;
    _pageControl.selectedColor = HZTMainColor;
    _pageControl.pageBackgroundColor = RGBColorAlpha(0, 0, 0, 0.2);
    _pageControl.isShowBorder = NO;
}

#pragma mark --- 成为伯乐
- (IBAction)clickJoinTalent:(id)sender {
    
}

#pragma mark --- 我是伯乐
- (IBAction)clickImTalent:(id)sender {
    
}

#pragma mark --- 扫一扫
- (IBAction)clickScan:(id)sender {
    
}

#pragma mark --- 求职安全
- (IBAction)clickSecurity:(id)sender {
    
}

-(void)setModel:(HZTHomeHeaderModel *)model{
    _model = model;
    
}

#pragma mark --- SDCycleScrollView图片点击回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

#pragma mark --- SDCycleScrollView图片滚动回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    _pageControl.currentPageNumber = index;
}

@end
