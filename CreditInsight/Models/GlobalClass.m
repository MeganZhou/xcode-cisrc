//
//  GlobalClass.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/4/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "GlobalClass.h"
#import "SynthesizeSingleton.h"
#import "CommonChart.h"

@implementation GlobalClass
SEL chartMethod;

SYNTHESIZE_SINGLETON_FOR_CLASS(GlobalClass);

- (void)setSettingValues:(NSMutableDictionary *)settingValues {
  _settingValues = settingValues;
  NSUserDefaults *settingDefaults = [NSUserDefaults standardUserDefaults];
  [settingDefaults setObject:settingValues forKey:@"settingValues"];
}

- (NSMutableDictionary *)applicationSetupValues {
  if ([_settingValues count] == 0) {
    NSUserDefaults *settingDefaults = [NSUserDefaults standardUserDefaults];
    _settingValues = [settingDefaults valueForKey:@"settingValues"];
  }
  
  return _settingValues;
}

- (CommonChart *)chartView:(CGRect)frame
                    report:(Report *)report {
  CommonChart *commonChart = [[CommonChart alloc] initWithFrame:frame];
  
  commonChart.report = report;
  commonChart.chartType = [[[self reportTypeDict] objectForKey:report.reportTypeKey] intValue];
  commonChart.chartFrame = frame;
  commonChart.isShowSelectedDataLabel = NO;
  
  return commonChart;
}

- (NSDictionary *)reportTypeDict {
  NSArray *reportTypeStringArray = [NSArray arrayWithObjects:@"Line", @"Area", @"Bar", @"Column", @"Pie",nil];
  NSArray *reportTypeArray = [NSArray arrayWithObjects:
                              [NSNumber numberWithInt:MAChartTypeLine],
                              [NSNumber numberWithInt:MAChartTypeArea],
                              [NSNumber numberWithInt:MAChartTypeBar],
                              [NSNumber numberWithInt:MAChartTypeColumn],
                              [NSNumber numberWithInt:MAChartTypePie],
                              nil];
  
  NSDictionary *reportTypeDict = [NSDictionary dictionaryWithObjects:reportTypeArray forKeys:reportTypeStringArray];
  
  return reportTypeDict;
}

@end
