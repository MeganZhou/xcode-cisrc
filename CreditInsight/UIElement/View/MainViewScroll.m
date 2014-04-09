//
//  MainViewScroll.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 12/24/12.
//  Copyright (c) 2012 Zhou, Megan (external - Partner). All rights reserved.
//

#import "MainViewScroll.h"
#import "Report.h"
#import "HomeViewController.h"

@implementation MainViewScroll

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MainViewScroll" owner:self options:nil];
    
    if (nibs) {
      self = [nibs objectAtIndex:0];
      self.frame = frame;
    }
  }
  
  return self;  
}

- (void)drawRect:(CGRect)rect {
  ViewCell *viewCell = nil;
  
  for (Report *report in _reportArray) {
    if ([report.reportArray count] > 0) {
      // Favorite Reports.
      Report *favoriteOneReportToShow = [report.reportArray objectAtIndex:0];
      viewCell = [self viewCell:viewCell withReport:favoriteOneReportToShow andIndex:[_reportArray indexOfObject:report]];
      // Override the chartName.
      viewCell.fldChartName.text = NSLocalizedString(report.reportName, nil);
      viewCell.reports = [NSArray arrayWithArray:report.reportArray];
      viewCell.fldChartName.enabled = YES;
      
      if ([report.reportArray count] > 1) {
        viewCell.imgCellBkg.hidden = NO;
      }
      
      UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHomeChartView:)];
      longPressGesture.allowableMovement = NO;
      longPressGesture.minimumPressDuration = 0.2;
      [viewCell addGestureRecognizer:longPressGesture];
      
    } else {
      viewCell = [self viewCell:viewCell withReport:report andIndex:[_reportArray indexOfObject:report]];
      viewCell.reports = [NSArray arrayWithObject:report];
    }
    
    [_scrollView addSubview:viewCell];
  }
  
  self.scrollView.contentSize = CGSizeMake([_reportArray count] * kViewCellWidth, self.scrollView.frame.size.height);
  [self.scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ChartListBg.png"]]];
}

- (ViewCell *)viewCell:(ViewCell *)viewCell withReport:(Report *)report andIndex:(NSUInteger)index {
  viewCell = [[ViewCell alloc] initWithFrame:CGRectMake(index * kViewCellWidth , 0, kViewCellWidth, kViewCellHeight)];
  viewCell.homeViewController = _homeViewController;
  
  viewCell.fldChartName.text = report.reportName;
  CGRect frame = CGRectMake(0, 0, viewCell.chartView.frame.size.width *0.95, viewCell.chartView.frame.size.height*0.80);
  
  viewCell.chartView.backgroundColor = [UIColor clearColor];
  [viewCell.chartView addSubview:[GlobalClassUtil chartView:frame
                                                  report:report]];
  
  UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
  singleRecognizer.numberOfTapsRequired = 1;
  [viewCell addGestureRecognizer:singleRecognizer];
  singleRecognizer.delegate = viewCell;
  
  return viewCell;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender {
  ViewCell *viewCell = (ViewCell *)sender.view;

  [GlobalClassUtil.tempReports addObjectsFromArray:viewCell.reports];

  viewCell.btnDeleteChart.hidden = YES;
  [_homeViewController goReportsViewerViewController];
}

- (void)longPressHomeChartView:(UILongPressGestureRecognizer *)longPressGesture {
  ViewCell *viewCell = (ViewCell *)longPressGesture.view;
  viewCell.btnDeleteChart.hidden = NO;
  viewCell.btnDeleteChart.enabled = YES;
}

@end
