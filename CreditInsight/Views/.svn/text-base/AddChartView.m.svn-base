//
//  AddChartView.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/2/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "AddChartView.h"
#import "ViewCell.h"
#import "AddChartsTableViewCell.h"

@implementation AddChartView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"AddChartView" owner:self options:nil];
    
    if (nibs) {
      self = [nibs objectAtIndex:0];
      self.frame = frame;
    }
  }
  
  return self;
}

- (void)initData {
  sectionHeaderNames = [NSMutableArray array];
  
  for (ReportsCategory *reportCategory in _reportsArray) {
    [sectionHeaderNames addObject:NSLocalizedString(reportCategory.categoryName, nil)];
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  [self initData];
  return [_reportsArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 268.0, 23.0)];
  UILabel *lblHeaderName = [[UILabel alloc] initWithFrame:view.frame];
 
  lblHeaderName.font = [UIFont boldSystemFontOfSize:15.0];
  lblHeaderName.text = [sectionHeaderNames objectAtIndex:section];
  lblHeaderName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CategoryTitleBar"]];
  lblHeaderName.textColor = [UIColor whiteColor];
  [view addSubview:lblHeaderName];
  
  return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 268.0, 20.0)];
  view.backgroundColor = [UIColor clearColor];
  
  return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  ReportsCategory *reportCategory = [_reportsArray objectAtIndex:section];

  return [reportCategory.reportArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"AddChartsTableViewCell";
  AddChartsTableViewCell *addChartsTableViewCell = (AddChartsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (addChartsTableViewCell == nil) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"AddChartsTableViewCell" owner:self options:nil];
    if ([nibs count] > 0) {
      addChartsTableViewCell = [nibs objectAtIndex:0];      
    } else {
      NSLog(@"Load AddChartsTableViewCell Fail");
    }
  }
  addChartsTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  addChartsTableViewCell.multiChartBg.hidden = YES;
  ReportsCategory *reportCategory = [_reportsArray objectAtIndex:indexPath.section];
  CGRect frame = CGRectMake(0, 0, addChartsTableViewCell.chartView.frame.size.width, addChartsTableViewCell.chartView.frame.size.height *0.8);  
  Report *report = [reportCategory.reportArray objectAtIndex:indexPath.row];
  
  if ([report.reportArray count] > 0) {
    // Favorite Reports.
    Report *favoriteOneReportToShow = [report.reportArray objectAtIndex:0];
    addChartsTableViewCell.lblChartName.text = NSLocalizedString(report.reportName, nil);
    addChartsTableViewCell.reports = [NSArray arrayWithArray:report.reportArray];
    [addChartsTableViewCell.chartView addSubview: [GlobalClassUtil chartView:frame report:favoriteOneReportToShow]];
    
    if ([report.reportArray count] > 1) {
      addChartsTableViewCell.multiChartBg.hidden = NO;
    }
    
  } else {
    Report *report = [reportCategory.reportArray objectAtIndex:indexPath.row];
    addChartsTableViewCell.lblChartName.text = report.reportName;
    addChartsTableViewCell.reports = [NSArray arrayWithObject:report];
    [addChartsTableViewCell.chartView addSubview:[GlobalClassUtil chartView:frame report:report]];
  } 
  
  return addChartsTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  AddChartsTableViewCell *cell =  (AddChartsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

  [_delegate addCharts:cell.reports];
}

@end
