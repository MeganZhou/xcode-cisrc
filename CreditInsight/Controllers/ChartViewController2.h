//
//  ChartViewController2.h
//  TestMAKit
//
//  Created by wang liang on 12/19/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAKit.h"

@interface ChartViewController2 : UIViewController<MAChartViewDataSource, MAChartViewDelegate>

@property(nonatomic,retain) NSArray *categoryArray;
@property(nonatomic,retain) NSArray *seriesArray;
@property(nonatomic,retain) NSMutableDictionary *valueDict;
@property(nonatomic,retain) MAChartView *chart;

@end
