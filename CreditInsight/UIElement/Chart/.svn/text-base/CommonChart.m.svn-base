//
//  CommonChart.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/8/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "CommonChart.h"
#import "UILabel+AutoSize.h"

@implementation CommonChart

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  if (_chartData == nil && _report != nil) {
    self.chartData = [Report dataArray:_report.xValuesArray yValueArray:_report.yValuesArrayes ySeriariesArray:_report.ySeriesArray];
  }
  
   [self initChart];
}

- (void)initChart {
  self.chart = [[MAChartView alloc] initWithFrame:CGRectZero];
  self.chart.contentMode = UIViewContentModeRedraw;
  self.chart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
  UIViewAutoresizingFlexibleRightMargin |
  UIViewAutoresizingFlexibleTopMargin |
  UIViewAutoresizingFlexibleBottomMargin |
  UIViewAutoresizingFlexibleWidth |
  UIViewAutoresizingFlexibleHeight;
  self.chart.dataSource = self;
  self.chart.delegate = self;
  self.chart.theme = [[MAKitTheme_WelterWeight alloc] init] ;
  self.chart.hierarchicalCategoryLabelDisplay = MAHierarchialCategoryLabelDisplayAllLevels;
  self.chart.contentRangeSelectorBehavior = MARangeSelectorBehaviourDisabled;
  self.chart.showsSelectedDataLabel = _isShowSelectedDataLabel;
  self.chart.showsSeriesLabels = NO;
  self.chart.isLegendHidden = YES;
  self.chart.disableSorting = YES;
  
  [self.chart refresh];
  [self addSubview:self.chart];
  self.chart.frame = self.chartFrame;
  
  [self initUnitLabels];
}

- (void)initUnitLabels {
  _lblYUnit = [self unitLabel:_report.yUnit]; 
  _lblXUnit = [self unitLabel:_report.xUnit];
  
  _lblYUnit.textAlignment = NSTextAlignmentCenter;
  _lblXUnit.textAlignment = NSTextAlignmentLeft;
  
  [self addSubview:_lblYUnit];
  [self addSubview:_lblXUnit];
  
  _lblXUnit.hidden = YES;
  _lblYUnit.hidden = YES;
}

- (UILabel *)unitLabel:(NSString *)labelUnit {
  UILabel *label = [UILabel autoSizeLabel:labelUnit
                                     font:[UIFont boldSystemFontOfSize:14.0]
                                    color:[UIColor darkGrayColor]
                          defaultMixWidth:60.0];  
  
  return label;
}

#pragma mark -
#pragma mark ChartViewDataSource methods
//Chart Type
- (NSUInteger)chartView:(MAChartView *)chartView chartTypeForChartLayer:(NSUInteger)layerIndex{
  
	return self.chartType;
}

//Title
- (NSString*)titleForChartView:(MAChartView *)chartView {
	return nil;
}

//Number of Categories
- (NSUInteger)chartView:(MAChartView *)chartView numberOfCategoriesInLevel:(NSUInteger)categoryLevelIndex {
	return [self.chartData count];
}

- (NSString*)chartView:(MAChartView *)chartView categoryTitleForCategoryLevel:(NSUInteger)categoryLevelIndex {
  if ( _report.xName.length == 0) { // For financial ratio chart
   return @"Year";
  } else {
   return _report.xName;
  }
}

// For single-value-dimensional chart  
- (NSString*)chartView:(MAChartView *)chartView valueTitleAtDimension:(NSUInteger)valueDimensionIndex inCategoryLevelIndex:(NSUInteger)categoryLevelIndex {
  if (_report != nil && self.chartType == MAChartTypeDataGrid) { // Not financial ratio chart
    NSMutableArray *seriesData = [self.chartData objectAtIndex:0];
    NSMutableDictionary *dict = [seriesData objectAtIndex:categoryLevelIndex];
    return [dict objectForKey:@"SeriesColumn"];
  }
  return nil;
}

//Number of Series
- (NSUInteger)numberOfSeriesInChartView:(MAChartView *)chartView {
  NSMutableArray *seriesData = [NSMutableArray array];
  if(self.chartData != nil){
    seriesData = [self.chartData objectAtIndex:0];
  }

	return [seriesData count];
}

//Series Axis
- (id)chartView:(MAChartView *)chartView seriesAtIndex:(NSUInteger)seriesIndex {
  NSMutableArray *seriesData = [self.chartData objectAtIndex:0];
	NSMutableDictionary *dict = [seriesData objectAtIndex:seriesIndex];
  return [dict objectForKey:@"SeriesColumn"];
}

- (NSUInteger)numberOfCategoryLevelsInChartView:(MAChartView *)chartView{
	return 1;
}

//Category Axis (x label)
- (id)chartView:(MAChartView *)chartView categoryAtIndex:(NSUInteger)categoryIndex inCategoryLevel:(NSUInteger)categoryLevelIndex
{
  NSMutableArray *data = [self.chartData objectAtIndex:categoryIndex];
  NSMutableDictionary *dict = [data objectAtIndex:0];
  return [dict objectForKey:@"CategoryColumn"];
}

//Value Axis
- (id)chartView:(MAChartView *)chartView valueAtDimension:(NSUInteger)valueDimensionIndex forCategory:(NSUInteger)categoryIndex inCategoryLevel:(NSUInteger)categoryLevelIndex andSeries:(NSUInteger)seriesIndex {
  NSMutableArray *data = [self.chartData objectAtIndex:categoryIndex];
  NSMutableDictionary *dict = [data objectAtIndex:seriesIndex];
  return [dict objectForKey:@"ValueColumn"];
}



@end
