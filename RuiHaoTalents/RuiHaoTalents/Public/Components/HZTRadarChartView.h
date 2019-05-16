//
//  HZTRadarChartView.h
//  RuiHaoTalents
//
//  Created by 王新伟 on 2019/3/26.
//  Copyright © 2019年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
NS_ASSUME_NONNULL_BEGIN
@class HZTRadarChartDataItem;
@interface HZTRadarChartView : UIView
/**
 初始化图表
 @param frame frame
 @param items 模型数组
 @param unitValue 均分值
 */
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <HZTRadarChartDataItem *> *)items valueDivider:(CGFloat)unitValue;
/** 绘制图表 */
- (void)strokeChart;
/**
 更新图表
 @param chartData 模型数组
 */
- (void)updateChartWithChartData:(NSArray *)chartData;
/** Array of `RadarChartDataItem` objects, one for each corner. */
@property (nonatomic) NSArray <HZTRadarChartDataItem *> *chartData;
/** The unit of this chart ,default is 1 */
@property (nonatomic) CGFloat valueDivider;
/** The maximum for the range of values to display on the chart */
@property (nonatomic) CGFloat maxValue;
/** Default is gray. */
@property (nonatomic) UIColor * webColor;
/** Default is green , with an alpha of 0.7 */
@property (nonatomic) UIColor * plotFillColor;
/** Default is green*/
@property (nonatomic) UIColor * plotStrokeColor;
/** Default is black */
@property (nonatomic) UIColor * fontColor;
/** Default is orange */
@property (nonatomic) UIColor * graduationColor;
/** Default is 12 */
@property (nonatomic) CGFloat fontSize;
/** Tap the label will display detail value ,default is YES. */
@property (nonatomic, assign) BOOL isLabelTouchable;
/** is show graduation on the chart ,default is NO. */
@property (nonatomic, assign) BOOL isShowGraduation;
/** is display animated, default is YES */
@property (nonatomic, assign) BOOL displayAnimated;
/** Default is 74, 211, 195 */
@property (nonatomic) UIColor * tempFillColor;
/** Default is 220, 246, 243 */
@property (nonatomic) UIColor * tempStrokeColor;
@end

@interface HZTRadarChartDataItem : NSObject
+ (instancetype)dataItemWithValue:(CGFloat)value description:(NSString *)description;

@property (nonatomic, assign) CGFloat value;

@property (nonatomic, strong) NSString *textDescription;
@end

NS_ASSUME_NONNULL_END
