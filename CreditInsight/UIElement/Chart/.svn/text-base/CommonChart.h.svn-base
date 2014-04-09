//
//  CommonChart.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/8/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAChartView.h"
#import "MAKit.h"
@class Report;

@interface CommonChart : UIView <MAChartViewDataSource,MAChartViewDelegate> 

@property (nonatomic,retain) MAChartView *chart;
@property (nonatomic,retain) NSArray *chartData;
@property (nonatomic,retain) NSString *chartTitle;
@property (nonatomic,assign) NSUInteger chartType;
@property (nonatomic) CGRect chartFrame;
@property (nonatomic, retain) Report *report;
@property (nonatomic, assign) BOOL isShowSelectedDataLabel;

@property (nonatomic, strong) UILabel *lblYUnit;
@property (nonatomic, strong) UILabel *lblXUnit;

@end
