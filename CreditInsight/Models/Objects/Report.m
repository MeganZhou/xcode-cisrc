//
//  Report.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/28/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "Report.h"
#import "RequestConfig.h"

@implementation Report


+ (id)convertJSON2Objects:(NSString *)jsonString  {
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  BaseObject *baseObject = [[BaseObject alloc] init];
  baseObject.status = [dict objectForKey:@"status"];
  baseObject.message = [dict objectForKey:@"message"];
  if (![baseObject.status isEqualToString:@"success"]) return baseObject;
  
  NSMutableArray *dataArray = [NSMutableArray array];
  NSDictionary *data = [dict objectForKey:@"data"];
  for (NSString *categoryName in [data allKeys]) {
    NSDictionary *categoryReports = [data objectForKey:categoryName];
    ReportsCategory *reportCategory = [[ReportsCategory alloc] init];
    reportCategory.categoryName = categoryName;
    reportCategory.reportArray = [NSMutableArray array];
    
    if (![categoryName isEqualToString:@"My Favorites"]) {
      // Not My Favorite Categories.      
      for (NSString *reportName in [categoryReports allKeys]) {
        Report *reports = [self generateReport:reportName andCategoryReports:[categoryReports objectForKey:reportName]];
        [reportCategory.reportArray addObject:reports];
      }
      
    } else {
      // Favorite Category.      
      for (NSString *favoriteReportName in [categoryReports allKeys]) {
        NSDictionary *favoriteReportsDict = [categoryReports objectForKey:favoriteReportName];
        Report *favoriteReports = [[Report alloc] init];
        favoriteReports.reportName = favoriteReportName;
        favoriteReports.reportArray = [NSMutableArray array];
        
        for (NSString *favoriteSubReportName in [favoriteReportsDict allKeys]) {
          Report *reports = [self generateReport:favoriteSubReportName andCategoryReports:[favoriteReportsDict objectForKey:favoriteSubReportName]];
          [favoriteReports.reportArray addObject:reports];
        }
        
        [reportCategory.reportArray addObject:favoriteReports];
      }
    }
    
    [dataArray addObject:reportCategory];
  }    
  
//  NSLog(@"Report: dataArray finally is  == %@", dataArray);
  return dataArray;
}

+ (Report *)generateReport:(NSString *)reportName andCategoryReports:(NSDictionary *)reportDict {
  Report *report = [[Report  alloc] init];
  report.reportName = NSLocalizedString(reportName, nil);
  report.reportId = [reportDict objectForKey:@"id"];
  report.xValuesArray = [reportDict objectForKey:@"xValue"];
  report.yValuesArrayes = [reportDict objectForKey:@"yValue"];
  report.ySeriesArray = [reportDict objectForKey:@"ySeriaries"];
  report.reportTypeKey = [reportDict objectForKey:@"type"];
  report.xName = [reportDict objectForKey:@"xName"];
  report.yName = [reportDict objectForKey:@"yName"];
  report.xUnit = [reportDict objectForKey:@"xUnit"];
  report.yUnit = [reportDict objectForKey:@"yUnit"];
  
  return report;
}

+ (NSArray *)dataArray:(NSArray *)xValueArray yValueArray:(NSArray *)yValueArray ySeriariesArray:(NSArray *)ySeriariesArray {
  NSMutableArray *dataArray = [[NSMutableArray alloc] init];
  
  for (int i = 0; i < xValueArray.count; i++) {
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    
    for (int j = 0; j < ySeriariesArray.count; j++) {
      NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                            [xValueArray objectAtIndex:i], @"CategoryColumn",
                            [ySeriariesArray objectAtIndex:j], @"SeriesColumn",
                            [NSNumber numberWithInt:[[[yValueArray objectAtIndex:j] objectAtIndex:i] intValue]], @"ValueColumn",
                            nil];
      [categoryArray addObject:dict];
    }
    
    [dataArray addObject:categoryArray];
  }
  
  return dataArray;
}

- (id)copyWithZone:(NSZone *)zone {
  id copy = [[[self class] alloc] init];
  if (copy) {
    [copy setReportId:self.reportId];
    [copy setReportName:self.reportName];
    [copy setReportTypeKey:self.reportTypeKey];
    [copy setXValuesArray:self.xValuesArray];
    [copy setYSeriesArray:[self.ySeriesArray copyWithZone:zone]];
    [copy setYValuesArrayes:[self.yValuesArrayes copyWithZone:zone]];
  }

  return copy;
}

@end

@implementation ReportsCategory

@end
 