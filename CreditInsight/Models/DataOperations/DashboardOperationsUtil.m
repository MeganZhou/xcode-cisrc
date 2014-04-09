//
//  DashboardOperationsUtil.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 5/30/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "DashboardOperationsUtil.h"
#import "DashboardOperations.h"
#import "DashboardEntity.h"
#import "Report.h"

@implementation DashboardOperationsUtil

- (Report *)generateNewReport:(Report *)report withCustomers:(NSArray *)customerArray {
  _dashboardOperations = [[DashboardOperations alloc] init];
  
  /*   
   Credit Limit Utilization
   Aging of Accounts Receivable
   
   Sales Volume
   Days Sales Outstanding
   Bad Debt
   Profitability
   */
  
  NSMutableArray *newYSeriesArray = [NSMutableArray array];   
  NSMutableArray *newYValuesArray = [NSMutableArray array];
  NSMutableArray *newXValues = nil;
  
  if((![report.reportName isEqualToString:NSLocalizedString(@"Credit Limit Utilization", nil)]) && (![report.reportName isEqualToString:NSLocalizedString(@"Aging of Accounts Receivable", nil)])){
    for (NSString *customerName in customerArray) {
      NSMutableArray *newYValues = [NSMutableArray array];
      newXValues = [NSMutableArray array];
      [newYSeriesArray addObject:customerName];
      NSArray *resultArray = [_dashboardOperations fetchDashboardEntityByCustomer:customerName];
      for (DashboardEntity *dashboard in resultArray) {
        [newXValues addObject:[self stringFromDate:dashboard.timeline]];
        if ([report.reportName isEqualToString:NSLocalizedString(@"Days Sales Outstanding", nil)]) {
          [newYValues addObject:dashboard.dso];
        } else if ([report.reportName isEqualToString:NSLocalizedString(@"Bad Debt", nil)]) {
          [newYValues addObject:dashboard.badDebts];
        } else if ([report.reportName isEqualToString:NSLocalizedString(@"Profitability", nil)]) {
          [newYValues addObject:dashboard.grossProfit];
        } else if ([report.reportName isEqualToString:NSLocalizedString(@"Sales Volume", nil)]) {
          [newYValues addObject:dashboard.revenue];
        } else {
          // Do nothing
        }        
      }
      
      [newYValuesArray addObject:newYValues];
    }
  }
//  else if ([report.reportName isEqualToString:@"Credit Limit Utilization"]) {
//    
//  } else if ([report.reportName isEqualToString:@"Aging of Accounts Receivable"]) {
//    for (NSString *customerName in customerArray) {
//      NSMutableArray *newYValues = [NSMutableArray array];
//      newXValues = [NSMutableArray arrayWithObjects:@"1 to 30 Days", @"31 to 60 Days", @"61 to 90 Days", @"91 to 180 Days", @"181 to 365 Days", @"More than one year", nil];
//      [newYSeriesArray addObject:customerName];
//      NSArray *resultArray = [_dashboardOperations fetchDashboardEntityByCustomer:customerName];
//      for (DashboardEntity *dashboard in resultArray) {
//        //December 2012
////        if () {
////          
////        }
//      }
//      
//      [newYValuesArray addObject:newYValues];
//    }
//  }
  
  report.xValuesArray = newXValues;
  report.ySeriesArray = newYSeriesArray;
  report.yValuesArrayes = newYValuesArray;

  return report;
}

- (NSString *)stringFromDate:(NSDate *)date {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"MMMM yyyy"];
  
  NSString *stringDate = [dateFormatter stringFromDate:date];
  return stringDate;
}

@end
