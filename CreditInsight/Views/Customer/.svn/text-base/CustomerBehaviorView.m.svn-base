//
//  CustomerBehaviorView.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/4/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "CustomerBehaviorView.h"
#import "DunningCollection.h"
#import "Profitability.h"
#import "CustomerViewController.h"
#import "HttpClient.h"

@implementation CustomerBehaviorView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CustomerBehaviorView" owner:self options:nil];
    if (nibs) {
      _isCompare = NO;
      _isZooming = NO;
      self = [nibs objectAtIndex:0];
      self.frame = frame;
      self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReportViewerBgTexture.png"]];
      GlobalClassUtil.currentBehaviourReportsDict = [NSMutableDictionary dictionary];
       _isLoadingDataCompleted = NO;
    }
  }
  return self;
}

- (NSDictionary *)urlParameterDict:(NSString *)customerId {
  NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:customerId, @"${customerId}", nil];
  return urlParamDict;
}

- (void)generateReports:(NSString *)customerId {
  NSDictionary *urlParamDict = [self urlParameterDict:customerId];
  [self generateReport:@"retrieveDSOReports:handler:" configName:@"dsodbt" urlParaDict:urlParamDict];
}

- (void)generateReport:(NSString *)methodName configName:(NSString *)configName urlParaDict:(NSDictionary *)urlParameterDict {
  [[HttpClient sharedInstance] invoke:_viewController
                           httpMethod:methodName
                    requestConfigName:configName
                         urlParameter:urlParameterDict
                        bodyParameter:nil];
}

- (ChartView *)chartView:(NSString *)chartName report:(Report *)report frame:(CGRect)rect leftTitle:(NSString *)title {
  ChartView *chartView = [[ChartView alloc] initWithFrame:rect];
  CommonChart *commonChart = [GlobalClassUtil chartView:chartView.chartContainerView.bounds report:report];

  [chartView.chartContainerView addSubview:commonChart];
  chartView.lblChartName.hidden = YES;
  chartView.lblLeftTitleofChartView.hidden = NO;
  chartView.lblLeftTitleofChartView.text = title;
  chartView.delegate = _viewController;
  [chartView.chartContainerView setUserInteractionEnabled:YES];
  return chartView;
}

- (void)compareReport:(Report *)report withCustomer:(NSMutableArray *)customers {
  _isCompare = YES;
  
  for (Customer *customer in customers) {
    NSDictionary *urlParamDict = [self urlParameterDict:customer.customerId];
    NSLog(@"When compare the urlParamDict is  === %@", urlParamDict);
    // Generate the newly report with the added customer info to compare.
    if (report != nil) {
      _isZooming = YES;
      if ([report.reportName isEqualToString:@"Profitability"]) {
        [self generateReport:@"retrievePRFReports:handler:" configName:@"prf" urlParaDict:urlParamDict];
      } else if ([report.reportName isEqualToString:@"Days Sales Outstanding & Days Beyond Term"]) {
        [self generateReport:@"retrieveDSOReports:handler:" configName:@"dsodbt" urlParaDict:urlParamDict];
      } else if ([report.reportName isEqualToString:@"Aging of Receivables"]) {
        [self generateReport:@"retrieveARReports:handler:" configName:@"ar" urlParaDict:urlParamDict];
      } else if ([report.reportName isEqualToString:@"Dunning & Collection"]) {
        [self generateReport:@"retrieveDCReports:handler:" configName:@"dc" urlParaDict:urlParamDict];
      } else {
        NSLog(@"When compare currentreport.reportName is == %@", report.reportName);
      }
    } else {
      // Load four reports.
      _isZooming = NO;
      [self generateReport:@"retrievePRFReports:handler:" configName:@"prf" urlParaDict:urlParamDict];
      [self generateReport:@"retrieveARReports:handler:" configName:@"ar" urlParaDict:urlParamDict];
      [self generateReport:@"retrieveDSOReports:handler:" configName:@"dsodbt" urlParaDict:urlParamDict];
      [self generateReport:@"retrieveDCReports:handler:" configName:@"dc" urlParaDict:urlParamDict];
    }
  }  
}

#pragma mark - Http Response Delegate
- (void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig {
  CGRect frame = CGRectMake(-10, -12, self.dsoView.frame.size.width + 10, self.dsoView.frame.size.height+12);  
  Report *report = (Report *)response;
  
  if (!_isCompare) {
    [GlobalClassUtil.currentBehaviourReportsDict setValue:report forKey:requestConfig.name];
  } else {
    Report *comparedReport = [self generateComparedReport:response andConfigName:requestConfig.name];
    report = comparedReport;
    if (_isZooming) {
      [_viewController reloadData:report];
    }
//    NSLog(@"report.ySeriesArray == %@, report.yValuesArrayes == %@", report.ySeriesArray, report.yValuesArrayes);
  }
  
  NSDictionary *urlParamDict = [self urlParameterDict:self.customerId];
  if (!_isZooming) {
    if ([requestConfig.name isEqualToString:@"dsodbt"]) {
      [self removeSubViewForView:self.dsoView];
      
      [self.dsoView addSubview:[self chartView:@"DSO" report:report frame:frame leftTitle:@"Days Sales Outstanding & Days Beyond Term"]];
      if (!_isCompare) {
        [self generateReport:@"retrieveARReports:handler:" configName:@"ar" urlParaDict:urlParamDict];
      }
    } else if ([requestConfig.name isEqualToString:@"ar"]) {
      [self removeSubViewForView:self.agingView];
      
      [self.agingView  addSubview:[self chartView:@"AgingReceivables" report:report frame:frame leftTitle:@"Aging of Receivables"]];
      if (!_isCompare) {
        [self generateReport:@"retrieveDCReports:handler:" configName:@"dc" urlParaDict:urlParamDict];
      }
      
    } else if ([requestConfig.name isEqualToString:@"dc"]) {
      [self removeSubViewForView:self.dunningConllectionView];
      
      [self.dunningConllectionView addSubview:[self chartView:@"Dunning Level" report:report frame:frame leftTitle:@"Dunning & Collection"]];
      if (!_isCompare) {
       [self generateReport:@"retrievePRFReports:handler:" configName:@"prf" urlParaDict:urlParamDict];
      }
      
    } else if ([requestConfig.name isEqualToString:@"prf"]) {
      [self removeSubViewForView:self.profitabilityView];
      [self.profitabilityView addSubview:[self chartView:@"Profitability" report:report frame:frame leftTitle:@"Profitablity"]];
      _isLoadingDataCompleted = YES;
    } else {
      // Do Nothing
    }
  }  
}

- (void)removeSubViewForView:(UIView *)view {
  for (UIView *subView in [view subviews]) {
    [subView removeFromSuperview];
  }
}

- (Report *)generateComparedReport:(Report *)newlyReport andConfigName:(NSString *)configName {
  Report *currentReport = [GlobalClassUtil.currentBehaviourReportsDict objectForKey:configName];  
  Report *comparedReport = [currentReport copy];
  
  NSMutableArray *yValuesArray = [NSMutableArray arrayWithArray:currentReport.yValuesArrayes];
  [yValuesArray addObjectsFromArray:newlyReport.yValuesArrayes];
  
  NSMutableArray *ySeriesArray = [NSMutableArray arrayWithArray:currentReport.ySeriesArray];
  [ySeriesArray addObjectsFromArray:newlyReport.ySeriesArray];
  
  comparedReport.yValuesArrayes = yValuesArray;
  comparedReport.ySeriesArray = ySeriesArray;
  
  return comparedReport;
}

@end

