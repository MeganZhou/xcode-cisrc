//
//  CustomerViewController.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 12/27/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import "CustomerViewController.h"
#import "LeftExpandableView.h"
#import "NSString+Formatter.h"
#import "CustomMapAnnotation.h"
#import "RightTabView.h"
#import "ExternalRatingView.h"
#import "ScoreRatingView.h"
#import "HttpClient.h"

#define kDetailContentViewWidth 965
#define kDetailContentViewheight 748

@interface CustomerViewController ()

@end

@implementation CustomerViewController

@synthesize isZooming = _isZooming;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadOverviewData];
  _isZooming = YES;
  _actionIndentifier = Overview;
   NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_customer.customerId, @"${id}", nil];
  [[HttpClient sharedInstance]invoke:self httpMethod:@"customerDetailInfo:handler:" requestConfigName:@"customerInfo" urlParameter:urlParamDict bodyParameter:nil];
}

- (void)viewDidUnload {
  [self setFinancialchatView:nil];
  [self setCustomerInfoView:nil];
  [self setDetailContentView:nil];
  [self setLblCustomerName:nil];
  [self setFldCustomerNumber:nil];
  [self setFldBusinessType:nil];
  [self setFldIndustrySector:nil];
  [self setFldEstablishmentYear:nil];
  [self setFldEmployeeSize:nil];
  [self setFldRegisteredCapital:nil];
  [self setFldContactTitle:nil];
  [self setFldTelephone:nil];
  [self setFldEmail:nil];
  [self setFldWebsite:nil];
  [self setLblLatestExternalReportsCount:nil];
  [self setLblMediaRecordsCount:nil];
  [self setLblLegalEventsCount:nil];
  [self setMapView:nil];
  [self setExternalRatingView:nil];
  [self setScoreRatingView:nil];
  [self setLblCreditEventUpdateTime:nil];
  [self setLblFinancialRatiosUpdateTime:nil];
  [self setCreditEventView:nil];
  [self setFldContactName:nil];
  [self setLblGeneralInformation:nil];
  [self setLblCustomerNumber:nil];
  [self setLblName:nil];
  [self setLblBusinessType:nil];
  [self setLblIndustrySector:nil];
  [self setLblYearOfEstablishment:nil];
  [self setLblEmployeeSize:nil];
  [self setLblOwnership:nil];
  [self setLblRegisteredCapital:nil];
  [self setLblContactTitle:nil];
  [self setLblContactName:nil];
  [self setLblTelephone:nil];
  [self setLblEmail:nil];
  [self setLblWebsite:nil];
  [self setLblCreditEvents:nil];
  [self setLblLatestExternalReports:nil];
  [self setLblLegalEvents:nil];
  [self setLblMediaRecords:nil];
  [super viewDidUnload];
}

- (void)initView {
  LeftExpandableView *leftExpandableView = [[LeftExpandableView alloc] initWithFrame:CGRectMake(0, 0, kLeftExpandableViewWidth, kLeftExpandableViewHeight)];
  leftExpandableView.isHiddenSelf = YES;
  [leftExpandableView.leftContentView addSubview:_customerInfoView];
  [self.view addSubview:leftExpandableView];
  
  RightTabView *rightTabView = [[RightTabView alloc] initWithFrame:CGRectMake(966, 0, 61, 748)];
  rightTabView.lblFirst.text = NSLocalizedString(@"Overview", nil);
  rightTabView.lblSecond.text = NSLocalizedString(@"Behavior", nil);
  rightTabView.lblThird.text = NSLocalizedString(@"CreditEvents", nil);
  rightTabView.delegate = self;
  [self.view addSubview:rightTabView];
  _detailContentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReportViewerBgTexture.png"]];

  ExternalRatingView *externalRatingView = [[ExternalRatingView alloc] initWithFrame:CGRectMake(0, 0, 471, 197)];
  externalRatingView.extRatings = self.extRatings;
  [_externalRatingView addSubview:externalRatingView];
  
  ScoreRatingView *scoreRatingView = [[ScoreRatingView alloc] initWithFrame:CGRectMake(0, 0, 481, 197)];
  scoreRatingView.scoreRating = self.scoreRating;
  [_scoreRatingView addSubview:scoreRatingView];
  
  [_financialchatView addSubview:[self getFinancialChartViewWithZoom:NO]];
  self.isZooming = NO;
  
  [_lblGeneralInformation setText:NSLocalizedString(@"GeneralInformation", nil)];
  [_lblCustomerNumber setText:NSLocalizedString(@"CustomerNumber", nil)];
  [_lblName setText:NSLocalizedString(@"Name", nil)];
  [_lblBusinessType setText:NSLocalizedString(@"BusinessType", nil)];
  [_lblIndustrySector setText:NSLocalizedString(@"IndustrySector", nil)];
  [_lblYearOfEstablishment setText:NSLocalizedString(@"YearOfEstablishment", nil)];
  [_lblEmployeeSize setText:NSLocalizedString(@"EmployeeSize", nil)];
  [_lblRegisteredCapital setText:NSLocalizedString(@"RegisteredCapital", nil)];
  [_lblOwnership setText:NSLocalizedString(@"Ownership", nil)];
  [_lblContactTitle setText:NSLocalizedString(@"ContactTitle", nil)];
  [_lblContactName setText:NSLocalizedString(@"ContactName", nil)];
  [_lblTelephone setText:NSLocalizedString(@"Telephone", nil)];
  [_lblEmail setText:NSLocalizedString(@"Email", nil)];
  [_lblWebsite setText:NSLocalizedString(@"Website", nil)];
  [_lblCreditEvents setText:NSLocalizedString(@"CreditEvents", nil)];
  [_lblLatestExternalReports setText:NSLocalizedString(@"LatestExternalReports", nil)];
  [_lblLegalEvents setText:NSLocalizedString(@"LegalEvents", nil)];
  [_lblMediaRecords setText:NSLocalizedString(@"MediaRecords", nil)];

  [self addBorderWithView:self.scoreRatingView];
  [self addBorderWithView:self.externalRatingView];
  [self addBorderWithView:self.creditEventView];
}

- (void)initNavigationBar {
  _rightBarbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 75, 32)];
  if (_actionIndentifier == Behavior) {
    [_rightBarbutton setTitle:NSLocalizedString(@"Compare", nil) forState:UIControlStateNormal];
    [_rightBarbutton addTarget:self action:@selector(clickRightBarItem) forControlEvents:UIControlEventTouchUpInside];
  } else if (_actionIndentifier == CreditEvent){
    [_rightBarbutton setTitle:NSLocalizedString(@"Sort", nil) forState:UIControlStateNormal];
    [_rightBarbutton addTarget:self action:@selector(clickSortBarItem) forControlEvents:UIControlEventTouchUpInside];
  }
  
  [_rightBarbutton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
  [_rightBarbutton setBackgroundImage:[UIImage imageNamed:@"common_black_button.png"] forState:UIControlStateNormal];
  
  UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBarbutton];
  self.navigationItem.rightBarButtonItem = rightBarItem;
  [_rightBarbutton setHidden:YES];
  [self setBarTitle:_customer.customerName];
}

- (CustomerBehaviorView *)customerBehaviorView {
  if (!_customerBehaviorView) {
    _customerBehaviorView = [[CustomerBehaviorView alloc]initWithFrame:CGRectMake(0, 0, kDetailContentViewWidth, kDetailContentViewheight)];
    _customerBehaviorView.viewController = self;
    _customerBehaviorView.customerId = _customer.customerId;
    [_detailContentView addSubview:self.customerBehaviorView];
  }
  return _customerBehaviorView;
}

- (CustomerNegativeCreditEventsView *)customerNegativeCreditEventsView {
  if (!_customerNegativeCreditEventsView) {
    _customerNegativeCreditEventsView = [[CustomerNegativeCreditEventsView alloc]initWithFrame:CGRectMake(0, 0, kDetailContentViewWidth, kDetailContentViewheight)];
    _customerNegativeCreditEventsView.contentSize = CGSizeMake(kDetailContentViewWidth, kDetailContentViewheight + 50);
    [_detailContentView addSubview:_customerNegativeCreditEventsView];
  }
  return _customerNegativeCreditEventsView;
}

#pragma mark - Custom Delegate
- (void)onClickTabButtonWithTag:(NSInteger)tag {  
  switch (tag) {
    case Overview:
      _actionIndentifier = Overview;
      [_rightBarbutton setHidden:YES];
      [self.customerBehaviorView setHidden:YES];
      [self.customerNegativeCreditEventsView setHidden:YES];
      break;
    case Behavior:
      _actionIndentifier = Behavior;
      [self initNavigationBar];
      [_rightBarbutton setHidden:NO];
      [self.customerNegativeCreditEventsView setHidden:YES];
      [self.customerBehaviorView setHidden:NO];
      // To get data when data have not load completed and recover network connection.
      if (!_customerBehaviorView.isLoadingDataCompleted) { 
        [_customerBehaviorView generateReports:_customer.customerId];
      }
      break;
    case CreditEvent:      
      _actionIndentifier = CreditEvent;
      [self initNavigationBar];
      [_rightBarbutton setHidden:NO];
      [self.customerBehaviorView setHidden:YES];
      [self.customerNegativeCreditEventsView setHidden:NO];
      break;
    default:
      break;
  }
}

#pragma mark - Custom Methods
- (void)addBorderWithView:(UIView *)view {
  view.layer.borderColor = [[UIColor grayColor] CGColor];
  view.layer.borderWidth = 1.0f;
}


- (void)clickRightBarItem {
  if (_actionIndentifier == Behavior || _actionIndentifier == Overview) {
    CustomerCompareViewController *customerCompareViewController = [[CustomerCompareViewController alloc] initWithNibName:@"CustomerCompareViewController" bundle:nil];
    [customerCompareViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    customerCompareViewController.delegate = self;
    customerCompareViewController.currentCustomer = _customer;
    [self presentModalViewController:customerCompareViewController animated:YES];
    customerCompareViewController.view.superview.frame = CGRectMake((1024 - 468) / 2, (768 - 463) / 2, 468, 463);
  }
}

- (void)clickSortBarItem {
  NSArray *sortDataArray = [NSArray arrayWithObjects:NSLocalizedString(@"Date", nil), NSLocalizedString(@"Type", nil), nil];
  [self popoverTableView:self.rightBarbutton arrayContent:sortDataArray title:NSLocalizedString(@"Sort By", nil)];
}

- (void)createAnnotationWithCoords:(CLLocationCoordinate2D)coords {
  CustomMapAnnotation *annotation = [[CustomMapAnnotation alloc] initWithLocation:coords];
  annotation.title = _customer.address;
  annotation.subtitle = @"";
  [_mapView addAnnotation:annotation];
}

- (CLLocationCoordinate2D)getPostion:(NSString *)address {
  NSString *googleURL = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?address=%@&sensor=true",
                         [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  CLLocationCoordinate2D position;
  position.latitude = 0.0;
  position.longitude = 0.0;
  NSError *error = nil;
  NSString *retstr = [NSString stringWithContentsOfURL:[NSURL URLWithString:googleURL] encoding:NSUTF8StringEncoding error:&error];
  NSLog(@"retstr: %@", retstr);
  NSData *data = [retstr dataUsingEncoding:NSUTF8StringEncoding];
  if (retstr) {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (dict) {
      NSArray *results = [dict objectForKey:@"results"];
      if (results && results.count > 0) {
        NSDictionary *geometry = [[results objectAtIndex:0] objectForKey:@"geometry"];
        NSDictionary *location = [geometry objectForKey:@"location"];
        position.latitude = [[location objectForKey:@"lat"] doubleValue];
        position.longitude = [[location objectForKey:@"lng"] doubleValue];
      }
    }
  } else {
    ErrorAlert(NSLocalizedString(@"NotFindAddress", nil), self, kOnlyCancelAlertTag);
  }
  
  return position;
}

- (MKCoordinateRegion)findCustomerRegionWithCustomerAddress:(NSString *)address {
  MKCoordinateRegion region;
  CLLocationCoordinate2D coords = [self getPostion:address];
  region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(0.02, 0.02));
  [self createAnnotationWithCoords:coords];
  return region;
}

 - (ChartView *)getFinancialChartViewWithZoom:(BOOL)isZoom {
 ChartView *chartView = [[ChartView alloc] initWithFrame:CGRectMake(-10, -12, _financialchatView.frame.size.width + 10,_financialchatView.frame.size.height + 12)];
 CommonChart *commonChart = [[CommonChart alloc] initWithFrame:CGRectMake(2, -30, 935,290)];
 [commonChart.chart setBackgroundColor:[UIColor clearColor]];
 commonChart.chartData = [self.fiancialRatiosDict objectForKey:@"chartArray"];
 commonChart.chartType = MAChartLayerTypeLine;
 commonChart.chartFrame = commonChart.bounds;
 commonChart.isShowSelectedDataLabel = YES;
 
 if (isZoom) {
 [chartView.btnZoom setImage:[UIImage imageNamed:@"chart_grey_zoomout"] forState:UIControlStateNormal];
 } else {
 [chartView.btnZoom setImage:[UIImage imageNamed:@"chart_zoomin"] forState:UIControlStateNormal];
 }
 
 [chartView.chartContainerView setUserInteractionEnabled:YES];
 [chartView.chartContainerView addSubview:commonChart];
 chartView.lblChartName.text = NSLocalizedString(@"KeyFinancialRatios", nil);
 chartView.lblLeftTitleofChartView.hidden = YES;
 chartView.delegate = self;
 
 return chartView;
 }


- (void)loadOverviewData {
  _lblLatestExternalReportsCount.text = _creditEvents.latestExternalReports;
  _lblLegalEventsCount.text = _creditEvents.legalEvents;
  _lblMediaRecordsCount.text = _creditEvents.mediaRecords;
  _lblCreditEventUpdateTime.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Updated", nil),
                                    [_creditEvents.updateTime stringDateFormat]];
  _lblFinancialRatiosUpdateTime.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Updated", nil),
                                       [[_fiancialRatiosDict objectForKey:@"updatedTime"] stringDateFormat]];
}

- (void)loadCustomerData:(Customer *)customer {
  _lblCustomerName.text = customer.customerName;
  _fldCustomerNumber.text = customer.customerNumber;
  _fldBusinessType.text = customer.businessType;
  _fldIndustrySector.text = customer.industrySector;
  _fldEstablishmentYear.text = customer.establishmentYear;
  _fldEmployeeSize.text = [customer.employeeSize stringWithCommaSeparate];
  _fldRegisteredCapital.text = customer.registeredCapital;
  _fldContactTitle.text = customer.contactTitle;
  _fldContactName.text = customer.contactName;
  _fldTelephone.text = customer.telephone;
  _fldEmail.text = customer.email;
  _fldWebsite.text = customer.website;
  [_mapView setRegion:[self findCustomerRegionWithCustomerAddress:customer.address] animated:YES];
}

- (void)zoomingChart:(ChartView *)chartView {
  [chartView.chartContainerView setUserInteractionEnabled:YES];

  if (_isZooming) {
    _zoomedChartView = chartView;
    _isZooming = NO;
    [_rightBarbutton setHidden:NO];
    _chartSuperView = chartView.superview;
    chartView.frame = CGRectMake(-17, -10, 1045 , 768);
    chartView.backgroundColor = [UIColor whiteColor];
    [chartView.btnZoom setImage:[UIImage imageNamed:@"chart_grey_zoomout"] forState:UIControlStateNormal];
    [self.view addSubview:chartView];
    chartView.commonChart.frame = CGRectMake(0, -15, chartView.chartContainerView.frame.size.width, chartView.chartContainerView.frame.size.height);
    chartView.commonChart.chart.showsSelectedDataLabel = YES;

    if ((chartView.commonChart.chartType != MAChartTypeDataGrid) && (chartView.commonChart.chartType != MAChartTypeBar)) {
      chartView.commonChart.lblXUnit.hidden = NO;
      chartView.commonChart.lblYUnit.hidden = NO;
      chartView.commonChart.lblXUnit.frame = CGRectMake(chartView.commonChart.frame.size.width - chartView.commonChart.lblXUnit.frame.size.width, chartView.commonChart.frame.size.height - chartView.commonChart.lblXUnit.frame.size.height, chartView.commonChart.lblXUnit.frame.size.width, chartView.commonChart.lblXUnit.frame.size.height);
    }
  } else {
    [_zoomedChartView removeFromSuperview];
    _zoomedChartView = nil;
    _isZooming = YES;
    chartView.frame = CGRectMake(-10, -12, _chartSuperView.frame.size.width + 10, _chartSuperView.frame.size.height + 12);
    chartView.backgroundColor = [UIColor clearColor];
    [chartView.btnZoom setImage:[UIImage imageNamed:@"chart_zoomin"] forState:UIControlStateNormal];
    [_chartSuperView addSubview:chartView];    
    if (_actionIndentifier == Overview) {
      chartView.commonChart.frame = CGRectMake(2, -30, 935,290);
      chartView.commonChart.chartData = [self.fiancialRatiosDict objectForKey:@"chartArray"];
      [chartView.commonChart.chart refresh];
      [_rightBarbutton setHidden:YES];
    } else {
       chartView.commonChart.frame = chartView.chartContainerView.bounds;
       chartView.commonChart.chart.showsSelectedDataLabel = NO;
    }
    
    chartView.commonChart.lblXUnit.hidden = YES;
    chartView.commonChart.lblYUnit.hidden = YES;   
  }
}

- (void)compareWith:(NSMutableArray *)customers {
  if (_actionIndentifier == Overview) {
    for (Customer *customer in customers) {
      NSLog(@"compareWith:_actionIndentifier == Overview the customer.customerId is  === %@", customer.customerId);
      NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:customer.customerId, @"${id}", nil];
      [[HttpClient sharedInstance] invoke:self httpMethod:@"customerOverview:handler:" requestConfigName:@"customerOverview" urlParameter:urlParamDict bodyParameter:nil];
    }
  } else {
    if (_zoomedChartView == nil) {
      // Compare four charts at the same time.
      [self.customerBehaviorView compareReport:nil withCustomer:customers];
    } else {
      [self.customerBehaviorView compareReport:_zoomedChartView.commonChart.report withCustomer:customers];
    }
  }
}

- (void)reloadData:(Report *)report {
  CommonChart *commonChart = [GlobalClassUtil chartView:_zoomedChartView.chartContainerView.bounds report:report];

  [_zoomedChartView.commonChart removeFromSuperview];
  _zoomedChartView.commonChart = nil;
  [_zoomedChartView.chartContainerView addSubview:commonChart];
  
  _zoomedChartView.commonChart.isShowSelectedDataLabel = YES;
  [_zoomedChartView.commonChart.chart refresh];
}

#pragma mark - Http Response Delegate
- (void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig {
  if ([requestConfig.name isEqualToString:@"customerInfo"]) {
    self.customer = (Customer *)response;
    [self loadCustomerData:self.customer];
  } else if ([requestConfig.name isEqualToString:@"customerOverview"]) {
    NSDictionary *customerDict = (NSDictionary *)response;
    NSArray *comparedArray = [self generateNewFinancialArray:_fiancialRatiosDict newDict:[customerDict objectForKey:@"finacialRatio"]];
    _zoomedChartView.commonChart.chartData = comparedArray;
    [_zoomedChartView.commonChart.chart refresh];
  } else {
    if (_actionIndentifier == Behavior) {
      [_customerBehaviorView succeed:response requestConfig:requestConfig];
    }
  }
}

- (void)failed:(id)response requestConfig:(RequestConfig *)requestConfig {
  if ([requestConfig.name isEqualToString:@"customerInfo"]) {
    
  }
}

- (NSMutableArray *)generateNewFinancialArray:(NSDictionary *)oldDict newDict:(NSDictionary *)newDict {  
  NSArray *oldArray = [oldDict objectForKey:@"chartArray"];
  NSArray *newArray = [newDict objectForKey:@"chartArray"];
  
  NSMutableArray *comparedArray = [NSMutableArray array];
  for (NSArray *subArray in oldArray) {
    NSMutableArray *subComparedArray = [NSMutableArray arrayWithArray:subArray];
    [subComparedArray addObjectsFromArray:[newArray objectAtIndex:[oldArray indexOfObject:subArray]]];
    
    [comparedArray addObject:subComparedArray];
  }  
  
  return comparedArray;
}

@end
