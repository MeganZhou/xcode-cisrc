//
//  BaseBehavior.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/22/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "BaseBehavior.h"
#import "RequestConfig.h"
#import "Report.h"

@implementation BaseBehavior

NSArray *orignXValueArray = nil;
NSArray *orignYValueArray = nil;
NSArray *orignYSeriariesArray = nil;

+ (Report *)convertJSON2Objects:(NSString *)jsonString {
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  Report *report = [[Report alloc] init];
  report.status = [dict objectForKey:@"status"];
  report.message = [dict objectForKey:@"message"];
  if (![report.status isEqualToString:@"success"]) return report;
  
  NSDictionary  *dataDict = [dict objectForKey:@"data"];
  for (NSString *reportName in [dataDict allKeys]) {
    report = [Report generateReport:reportName andCategoryReports:[dataDict objectForKey:reportName]];
  }
  
  return report;
}

@end
