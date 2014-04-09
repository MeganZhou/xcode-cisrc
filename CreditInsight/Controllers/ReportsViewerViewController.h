//
//  ReportsViewerViewController.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 12/27/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddChartView.h"
#import "ChartView.h"
#import "CategoriesForFilterView.h"
#import "SeriesForFilterView.h"

@class ReportsViewerHeaderTableView;

#define kCategoryViewTag 111

@interface ReportsViewerViewController : BaseViewController<AddChartDelegate, UITextFieldDelegate, UIAlertViewDelegate, ChartViewDelegate, CategoriesForFilterViewDelegate>

@property (weak, nonatomic) IBOutlet ReportsViewerHeaderTableView *headerTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnShowCategories;
@property (weak, nonatomic) IBOutlet UIButton *btnScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *fullChartView;

@property (strong, nonatomic) CategoriesForFilterView *filterCategoriesView;
@property (strong, nonatomic) SeriesForFilterView *filterSeriesView;
@property (strong, nonatomic) ChartView *chartViewToZoom;

@property (weak, nonatomic) id<HttpResponseDelegate> httpResponseDelegate;

- (void)refreshReportView:(NSArray *)customerArray;

@end

@interface ReportsViewerViewController()

@property (retain, nonatomic) NSArray  *reportsArray;
@property (strong, nonatomic) NSArray  *filtersArray;

@end