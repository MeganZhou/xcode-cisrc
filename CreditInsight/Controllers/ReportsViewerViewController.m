//
//  ReportsViewerViewController.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 12/27/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import "ReportsViewerViewController.h"
#import "ReportsViewerHeaderTableView.h"
#import "QuartzCore/QuartzCore.h"
#import "HttpClient.h"
#import "HomeViewController.h"
#import "DashboardOperationsUtil.h"

#define kRangeSelectorHeight 92.0

@implementation ReportsViewerViewController

@synthesize isZooming = _isZooming; // Declared in protocal, must @synthesize here.

CGFloat startX = 0;
CGFloat startY = 0;
CGFloat lastScale = 1.0;
CGFloat newAddedChartOrignX;
CGFloat newAddedChartOrignY;
BOOL isAddingChart;

#pragma mark - Lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
 
  self.isZooming = NO;
  isAddingChart = YES;
  self.bgImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReportViewerBgTexture.png"]];
  
  [self initChartViewOrignLocation];
  [self loadCharts:NO];
  
  [[HttpClient sharedInstance] invoke:self httpMethod:@"retrieveFilters:handler:" requestConfigName:@"creditProfile"];
}

#pragma mark - Init
- (void)initNavigationBar {
  [self initNavigationBarForNarrowingChartView];
}

- (void)initNavigationBarForNarrowingChartView {
  UIButton *favoriteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
  [favoriteButton setImage:[UIImage imageNamed:@"common_myfavorite_icon"] forState:UIControlStateNormal];
  [favoriteButton setImage:[UIImage imageNamed:@"common_myfavorite_icon_highlighted"] forState:UIControlStateHighlighted];
  [favoriteButton addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *rightBarButton1 = [[UIBarButtonItem alloc] initWithCustomView:favoriteButton];
  
  UIButton *emailButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 34, 28)];
  [emailButton setImage:[UIImage imageNamed:@"common_email_bar_icon"] forState:UIControlStateNormal];
  [emailButton setImage:[UIImage imageNamed:@"common_email_icon_highlighted"] forState:UIControlStateHighlighted];
  [emailButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *rightBarButton2 = [[UIBarButtonItem alloc] initWithCustomView:emailButton];
  
  NSArray *items = [[NSArray alloc]initWithObjects:rightBarButton1, rightBarButton2, nil];
	self.navigationItem.rightBarButtonItems = items;
  [self setBarTitle:NSLocalizedString(@"ReportsViewerViewController.Bar.Title", nil)];
}

- (void)initNavigationBarForZoomingChartView:(BOOL)isChart {
  UIButton *narrowingButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
  [narrowingButton setImage:[UIImage imageNamed:@"chart_grey_zoomout"] forState:UIControlStateNormal];
  [narrowingButton addTarget:self action:@selector(narrowingChart:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *rightBarButton1 = [[UIBarButtonItem alloc] initWithCustomView:narrowingButton];
  
  UIButton *changeToTableButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
  
  if (isChart) {
    [changeToTableButton setImage:[UIImage imageNamed:@"TableViewForHeader_Btn"] forState:UIControlStateNormal];
    [changeToTableButton addTarget:self action:@selector(convertChartToTable:) forControlEvents:UIControlEventTouchUpInside];
  } else {
    [changeToTableButton setImage:[UIImage imageNamed:@"ChartViewForHeader_Btn"] forState:UIControlStateNormal];
    [changeToTableButton addTarget:self action:@selector(convertTableToChart:) forControlEvents:UIControlEventTouchUpInside];
  }
  
  UIBarButtonItem *rightBarButton2 = [[UIBarButtonItem alloc] initWithCustomView:changeToTableButton];
  
  NSArray *items = [[NSArray alloc]initWithObjects:rightBarButton1, rightBarButton2, nil];
	self.navigationItem.rightBarButtonItems = items;
  [self setBarTitle:_chartViewToZoom.lblChartName.text];
}

- (void)initChartViewOrignLocation {
  newAddedChartOrignX = _headerTableView.frame.origin.x;
  newAddedChartOrignY = _headerTableView.frame.origin.y + _headerTableView.frame.size.height;
}

- (void)initDataForHeaderView:(NSMutableArray *)responseData {
  self.headerTableView.layer.borderColor = [UIColor blackColor].CGColor;
  self.headerTableView.layer.borderWidth = 2.0;
  self.headerTableView.layer.cornerRadius = 15.0;
  
  self.headerTableView.categoryArray = [[NSMutableArray alloc] initWithArray:responseData copyItems:YES];
  [self.headerTableView reloadData];
}

- (void)loadCharts:(BOOL)isHidden {
  NSMutableArray *reports = GlobalClassUtil.tempReports;
  
  if ([reports count] > 1) {
    for (UIView *view in [self.view subviews]) {
      if ([view isKindOfClass:[ChartView class]]) {
        [view removeFromSuperview];
      }
    }
    
    [self initChartViewOrignLocation];
    
    for (int chartNameIndex = 0; chartNameIndex < [reports count]; chartNameIndex ++) {
      newAddedChartOrignX = newAddedChartOrignX + 20;
      newAddedChartOrignY = newAddedChartOrignY + 20;
      CGRect rect =  CGRectMake(newAddedChartOrignX, newAddedChartOrignY, kChartWidth, kChartHeight);
      
      [self loadChartView:[reports objectAtIndex:chartNameIndex] frame:rect isHidden:isHidden];
    }        
  } else if([reports count] != 0) {
    newAddedChartOrignX = (1024- kChartWidth)/2;
    CGRect rect =  CGRectMake(newAddedChartOrignX, newAddedChartOrignY, kChartWidth, kChartHeight);
    [self loadChartView:[reports objectAtIndex:0] frame:rect isHidden:isHidden];
  } else {
    // Do Nothing.
  }  
}

#pragma mark - Gestures
- (void)addGesturesForView:(UIView *)subView { 
  UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPinchEvent:)];
  [subView addGestureRecognizer:pinchGestureRecognizer];
  
  UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(longPressChartView:)];
  longPressGesture.allowableMovement = NO;
  longPressGesture.minimumPressDuration = 0.2;
  [subView addGestureRecognizer:longPressGesture];
}

- (void)twoFingerPinchEvent:(UIPinchGestureRecognizer *)recognizer {
  UIView *currentView = recognizer.view;
  
  if ([recognizer state] == UIGestureRecognizerStateEnded) {
    lastScale = 1.0;
    return;
  }
  
  CGFloat scale = 1.0 - (lastScale - [recognizer scale]);
  CGAffineTransform currentTransform = currentView.transform;
  CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
  currentView.transform = newTransform;
  lastScale = [recognizer scale];  
}

- (void)longPressChartView:(UILongPressGestureRecognizer *)longPressGesture {
  ChartView *chartView = (ChartView *)longPressGesture.view;  
  chartView.btnDeleteChart.hidden = NO;
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [[event allTouches] anyObject];
    
  if ([touch view] != nil) {
    UIView *touchView = nil;
    if ([[[touch view] superview] isKindOfClass:[ChartView class]]) {
      touchView = [[touch view] superview];      
    } else if([[[[touch view] superview] superview] isKindOfClass:[ChartView class]]) {
      touchView = [[[touch view] superview] superview]; // Header has extra interaction.
    } else {
      // Do Nothing.
    }
    
    // Single Tap
    ChartView *chartView = (ChartView *)touchView;
    chartView.btnDeleteChart.hidden = YES;
    
    CGPoint location = [touch locationInView:self.view];
    startX = location.x - touchView.center.x;
    startY = location.y - touchView.center.y;
    
    [self.view bringSubviewToFront:touchView]; //TODO: Need add animation.
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [[event allTouches] anyObject];  
  CGPoint location = [touch locationInView:self.view];
  
  if([touch view] != nil) {
    UIView *touchView = nil;
    
    if ([[[touch view] superview] isKindOfClass:[ChartView class]]) {
      touchView = [[touch view] superview];
    } else if([[[[touch view] superview] superview] isKindOfClass:[ChartView class]]) {
      touchView = [[[touch view] superview] superview];
    } else {
      // Do Nothing.
    }
    
    location.x = location.x - startX;
    location.y = location.y - startY;
    touchView.center = location;
  } 
}

#pragma mark - Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (alertView.tag == 15) {
    UITextField *textField = [alertView textFieldAtIndex:0];
    NSString *text = textField.text;
    
    switch (buttonIndex) {
      case 0:
        break;
      case 1:
        if (text.length != 0) {
          NSMutableArray *reportIds = [NSMutableArray array];
          NSMutableString *reportIdsString = nil;
          for (Report *report in GlobalClassUtil.tempReports) {
            [reportIds addObject:report.reportId];
            if (0 == [GlobalClassUtil.tempReports indexOfObject:report]) {
              reportIdsString = [NSMutableString stringWithFormat:@"%@", report.reportId];
            } else {
              [reportIdsString appendFormat:@",%@", report.reportId];
            }
          }
          
          NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:text, @"{name}", reportIdsString, @"{id,id,id}", nil];
          [[HttpClient sharedInstance] invoke:self httpMethod:@"retrieveFavoriteReports:handler:" requestConfigName:@"addfavorite" urlParameter:urlParamDict bodyParameter:nil];
        }
        break;
        
      default:
        break;
    }
  }
}

#pragma mark - Custom Delegate
- (void)addCharts:(NSArray *)reports {
  [GlobalClassUtil.tempReports addObjectsFromArray:reports];  
  [self loadCharts:NO];
}

- (void)zoomingChart:(ChartView *)chartView {
  self.isZooming = YES;
  self.bgImageView.hidden = YES;
  
  for (UIView *view in [self.view subviews]) {
    if (view == self.filterCategoriesView || view == self.filterSeriesView) {
      [self hideFilterViews];
    } else if ([view isKindOfClass:[AddChartView class]]) {
      [view removeFromSuperview];
      isAddingChart = YES;
      self.btnScrollView.frame = CGRectMake(959, 639, 65, 65);
      [self.btnScrollView setImage:[UIImage imageNamed:@"viewreport_add"] forState:UIControlStateNormal];
    } else {
      // Do nothing.
    }
  }  
  [self removeAddChartView:nil];
  
  // Handle srcrollbutton
  _btnScrollView.enabled = NO;
  _btnScrollView.hidden = YES;
  
  // Init navgationBar, the title should be changed with different chart.
  [self initNavigationBarForZoomingChartView:chartView.isChartView];

  _chartViewToZoom = chartView;
  _chartViewToZoom.commonChart.frame = CGRectMake(0, 0, self.fullChartView.frame.size.width * 0.97, self.fullChartView.frame.size.height);
  [_chartViewToZoom.chartContainerView setUserInteractionEnabled:YES];
  _chartViewToZoom.commonChart.chart.showsSelectedDataLabel = YES;
  _chartViewToZoom.commonChart.chart.contentRangeSelectorBehavior = MARangeSelectorBehaviourEnabled;
  
  [self setZoomChartLabels];

  [_chartViewToZoom removeFromSuperview];
  
  [self loadCharts:YES];
  
  for (UIView *view in [self.fullChartView subviews]) {
    [view removeFromSuperview];
  }
  
  [self.fullChartView addSubview:_chartViewToZoom.commonChart];
  [self.view bringSubviewToFront:self.fullChartView];
}

- (void)narrowingChart:(id)sender {
  self.bgImageView.hidden = NO;
  [self.view sendSubviewToBack:self.fullChartView];
  
  [self initNavigationBarForNarrowingChartView];
  
  [_chartViewToZoom removeFromSuperview];
  
  [self loadCharts:NO];
  
  // Handle srcrollbutton
  _btnScrollView.enabled = YES;
  _btnScrollView.hidden = NO;
}

#pragma mark - Http Response Delegate
- (void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig {
  NSLog(@"** ReportsViewer ** requestConfig.name == %@, response == %@", requestConfig.name, response);
  
  if ([requestConfig.name isEqualToString:@"creditProfile"]) {
    self.filtersArray = (NSArray *)response;
    [self initDataForHeaderView:response];
  } else if ([requestConfig.name isEqualToString:@"addfavorite"]) {
    HomeViewController *homeViewController = (HomeViewController *)[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count - 2)];
    [homeViewController getAllReports];
    [self.navigationController popViewControllerAnimated:YES];
  }  
}

- (void)failed:(id)response requestConfig:(RequestConfig *)requestConfig {
  if ([requestConfig.name isEqualToString:@"addfavorite"]) {
    ErrorAlert(@"Fail to add favorite!", self, kOnlyCancelAlertTag);
  }
}

#pragma mark - IBAction Method
- (IBAction)pageToScroll:(id)sender {
  CATransition *transition =[CATransition animation];
  transition.duration= 0.2f;
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  transition.type = kCATransitionPush;
  
  if (isAddingChart) {
    isAddingChart = NO;
    self.btnScrollView.frame = CGRectMake(692, 639, 65, 65);
    [self.btnScrollView setImage:[UIImage imageNamed:@"viewreport_close_add"] forState:UIControlStateNormal];
    
    [self gotoAddChartView:transition];
  } else {
    [self removeAddChartView:transition];
  }   
}

- (void)addToFavorite:(id)sender {
  UIAlertView *addToFavoriteAlert = [[UIAlertView alloc] initWithTitle:@"Add to Favorite"
                                                               message:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:@"OK", nil];
  addToFavoriteAlert.tag = 15;
  addToFavoriteAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
  [addToFavoriteAlert textFieldAtIndex:0].delegate = self;
  [addToFavoriteAlert textFieldAtIndex:0].placeholder = @"DSO, Profibility";
  [addToFavoriteAlert show];
}

- (IBAction)onClickShowCategoriesButton:(id)sender {
  [self removeAddChartView:nil];
  
  if ((self.filterCategoriesView == nil) && (self.filterSeriesView == nil)) {
    self.filterCategoriesView = [[CategoriesForFilterView alloc] initWithFrame:CGRectMake(0, 150, 176, 408)];
    self.filterCategoriesView.delegate = self;
    self.filterCategoriesView = [[CategoriesForFilterView alloc] initWithFrame:CGRectMake(0, 150, 176, 408)];
    self.filterCategoriesView.delegate = self;
    self.filterSeriesView = [[SeriesForFilterView alloc] initWithFrame:CGRectMake(848, 150, 176, 408)];
    self.filterSeriesView.headerTableView = self.headerTableView;
    self.filterSeriesView.reportsViewerController = self;
    self.filterCategoriesView.seriesView = self.filterSeriesView;
    
    self.filterCategoriesView.categories = self.filtersArray;
  }  

  [self.view addSubview:self.filterCategoriesView];
  [self.view addSubview:self.filterSeriesView];
}

// Delegate Method
- (void)hideFilterViews {
  self.headerTableView.isEditing = NO;
  [self.headerTableView reloadData];
  
  [self.filterCategoriesView removeFromSuperview];
  [self.filterSeriesView removeFromSuperview];
}

- (void)convertChartToTable:(id)sender {
  [self initNavigationBarForZoomingChartView:NO];
  _chartViewToZoom.isChartView = NO;
  _chartViewToZoom.commonChart.chartType = MAChartTypeDataGrid;
  _chartViewToZoom.commonChart.lblXUnit.hidden = YES;
  _chartViewToZoom.commonChart.lblYUnit.hidden = YES;
  [_chartViewToZoom.commonChart.chart refresh];
}

- (void)convertTableToChart:(id)sender {
  [self initNavigationBarForZoomingChartView:YES];
  _chartViewToZoom.isChartView = YES;  
  _chartViewToZoom.commonChart.chartType = [[GlobalClassUtil.reportTypeDict objectForKey:_chartViewToZoom.commonChart.report.reportTypeKey] intValue];
  
  if (_isZooming) {
    [self setZoomChartLabels];
  }
  
  [_chartViewToZoom.commonChart.chart refresh];
}

#pragma mark - Custom Method
- (void)setZoomChartLabels {
  if ((_chartViewToZoom.commonChart.chartType != MAChartTypeDataGrid) && (_chartViewToZoom.commonChart.chartType != MAChartTypePie)) {
    _chartViewToZoom.commonChart.lblXUnit.hidden = NO;
    _chartViewToZoom.commonChart.lblYUnit.hidden = NO;
    _chartViewToZoom.commonChart.lblXUnit.frame = CGRectMake(_fullChartView.frame.size.width + _fullChartView.frame.origin.x - _chartViewToZoom.commonChart.lblXUnit.frame.size.width, _chartViewToZoom.commonChart.frame.size.height - _chartViewToZoom.commonChart.lblXUnit.frame.size.height - kRangeSelectorHeight, _chartViewToZoom.commonChart.lblXUnit.frame.size.width, _chartViewToZoom.commonChart.lblXUnit.frame.size.height);
  }
}

- (void)gotoAddChartView:(CATransition *)transition {
  AddChartView *addChartView = [[AddChartView alloc] initWithFrame:CGRectMake(757, 0, 268, 704)];
  addChartView.delegate = self;
  addChartView.reportsArray = _reportsArray;
  [addChartView.chartsTableView reloadData];
  
  // Set transition
  transition.delegate = addChartView;
  transition.subtype = kCATransitionFromRight;
  [addChartView.layer addAnimation:transition forKey:nil];
  [self.btnScrollView.layer addAnimation:transition forKey:nil];
  
  [self.view addSubview:addChartView];
}

- (void)loadChartView:(Report *)report frame:(CGRect)rect isHidden:(BOOL)isHidden {
  ChartView *chartView = [[ChartView alloc] initWithFrame:rect];
  CGRect frame = CGRectMake(0, 0, chartView.chartContainerView.frame.size.width, chartView.chartContainerView.frame.size.height);
  
  [chartView.chartContainerView addSubview:[GlobalClassUtil chartView:frame report:report]];
  chartView.lblChartName.text = report.reportName;
  chartView.delegate = self;
  chartView.delegate.isZooming = YES;
  chartView.hidden = isHidden;
  
  [self addGesturesForView:chartView];  
  [self.view insertSubview:chartView belowSubview:_btnShowCategories];  
}

- (void)stopServerInteraction {
  sleep(1);
  [self.indicator removeFromSuperview];
  [self.view setUserInteractionEnabled:YES];
}

- (void)removeAddChartView:(CATransition *)transition {
  isAddingChart = YES;
  self.btnScrollView.frame = CGRectMake(959, 639, 65, 65);
  [self.btnScrollView setImage:[UIImage imageNamed:@"viewreport_add"] forState:UIControlStateNormal];
  
  for (UIView *view in [self.view subviews]) {
    if ([view isKindOfClass:[AddChartView class]]) {
      transition.subtype = kCATransitionFromLeft;
      transition.delegate = view;
      [view.layer addAnimation:transition forKey:nil];
      [view removeFromSuperview];
    }
  }
}

- (void)refreshReportView:(NSArray *)customerArray {  
  for (Report *report in GlobalClassUtil.tempReports) {
    DashboardOperationsUtil *dboUtil = [[DashboardOperationsUtil alloc] init];
    Report *newReport = [dboUtil generateNewReport:report withCustomers:customerArray];   
    
    [self reloadChartView:newReport];
  }  
}

- (void)refreshReportView:(NSArray *)customerArray andTimeLine:(NSString *)timeline {
  
}

- (void)reloadChartView:(Report *)newReport {
  ChartView *chartView = nil;
  for (UIView *view in [self.view subviews]) {
    if ([view isKindOfClass:[ChartView class]]) {
      chartView = (ChartView *)view;
        NSLog(@"chartView.commonChart.report.reportName == %@", chartView.commonChart.report.reportName);
        NSLog(@"newReport.reportName == %@", newReport.reportName);
      if ([chartView.commonChart.report.reportName isEqualToString:newReport.reportName]) {
          NSLog(@"newReport.xValuesArray== %@", newReport.xValuesArray);
          NSLog(@"newReport.yValuesArrayes == %@", newReport.yValuesArrayes);
          NSLog(@"newReport.ySeriesArray == %@", newReport.ySeriesArray);
        chartView.commonChart.chartData = [Report dataArray:newReport.xValuesArray yValueArray:newReport.yValuesArrayes ySeriariesArray:newReport.ySeriesArray];
        [chartView.commonChart.chart refresh];
      }
    }
  }
}

- (void)viewDidUnload {
  [self setHeaderTableView:nil];
  [self setBtnShowCategories:nil];
  [self setBtnScrollView:nil];
  [self setFullChartView:nil];
  [super viewDidUnload];  
}

@end
