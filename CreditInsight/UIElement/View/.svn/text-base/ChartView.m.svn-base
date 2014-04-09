//
//  ChartView.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/3/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "ChartView.h"

@implementation ChartView

@synthesize commonChart = _commonChart;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ChartView" owner:self options:nil];
    
    if (nibs) {
      self = [nibs objectAtIndex:0];
      self.frame = frame;
      self.btnDeleteChart.hidden = YES;
      self.lblLeftTitleofChartView.hidden = YES;
      self.isChartView = YES;
      [self addBorderWithView:self.chartView];
      [self addBorderWithView:self.titleView];
    }
  }

  return self;  
}

- (IBAction)OnClickConvertButton:(id)sender {
  if (_isChartView) {
    [self commonChart].chartType = MAChartTypeDataGrid;    
    self.isChartView = NO;
    [self.btnConvert setImage:[UIImage imageNamed:@"chart_grey_chartview"] forState:UIControlStateNormal];
    self.commonChart.lblXUnit.hidden = YES;
    self.commonChart.lblYUnit.hidden = YES;
  } else {
    NSNumber *reportType = [GlobalClassUtil.reportTypeDict objectForKey:[self commonChart].report.reportTypeKey];
    
    if (reportType) {
      [self commonChart].chartType = [reportType intValue];
    } else {
      [self commonChart].chartType = MAChartTypeLine;
    }
    
    if ((self.commonChart.chartType != MAChartTypeDataGrid) && (self.commonChart.chartType != MAChartTypeBar)) {
      if (!_delegate.isZooming) {
        self.commonChart.lblXUnit.hidden = NO;
        self.commonChart.lblYUnit.hidden = NO;
        self.commonChart.lblXUnit.frame = CGRectMake(self.commonChart.frame.size.width - self.commonChart.lblXUnit.frame.size.width, self.commonChart.frame.size.height - self.commonChart.lblXUnit.frame.size.height, self.commonChart.lblXUnit.frame.size.width, self.commonChart.lblXUnit.frame.size.height);
      }
    }
    
    self.isChartView = YES;
    [self.btnConvert setImage:[UIImage imageNamed:@"chart_grey_tableview"] forState:UIControlStateNormal];
  }  
  [[self commonChart].chart refresh];  
}

- (IBAction)onClickZoomButton:(id)sender {  
  [_delegate zoomingChart:self];  
}

- (IBAction)onClickDeleteChartButton:(id)sender { 
  [GlobalClassUtil.tempReports removeObject:[self commonChart].report];  
  [self removeFromSuperview];
}

- (void)addBorderWithView:(UIView *)view {
  view.layer.borderColor = [[UIColor grayColor] CGColor];
  view.layer.borderWidth = 1.0f;
}

- (void)setCommonChart:(CommonChart *)commonChart {
  _commonChart = commonChart;
}

- (CommonChart *)commonChart {
  if (_commonChart == nil) {
    if ([[self.chartContainerView subviews] count] > 0) {
      _commonChart = [[self.chartContainerView subviews] objectAtIndex:0];
    }
  }

  return _commonChart;
}

@end
