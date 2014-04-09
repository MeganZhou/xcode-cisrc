//
//  CustomerViewController.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 12/27/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomerBehaviorView.h"
#import "CustomerNegativeCreditEventsView.h"
#import "RightTabView.h"
#import <MapKit/MapKit.h>
#import "ChartView.h"
#import "Customer.h"
#import "CustomerCompareViewController.h"
#import "CreditEvents.h"
#import "ScoreRating.h"

typedef enum {
  Overview = 1,
  Behavior = 2,
  CreditEvent = 3,
} ActionIdentifier;

@interface CustomerViewController : BaseViewController<RightTabViewDelegate, ChartViewDelegate, ChartViewDelegate, CompareDelegate>

@property (retain, nonatomic) Customer *customer;
@property (retain, nonatomic) CreditEvents *creditEvents;
@property (retain, nonatomic) ScoreRating *scoreRating;
@property (retain, nonatomic) NSArray *extRatings;
@property (retain, nonatomic) NSDictionary *fiancialRatiosDict;

@property (weak, nonatomic) IBOutlet UIView *financialchatView;
@property (strong, nonatomic) IBOutlet UIView *customerInfoView;
@property (weak, nonatomic) IBOutlet UIView *detailContentView;

@property (weak, nonatomic) IBOutlet UILabel *lblCustomerName;
@property (weak, nonatomic) IBOutlet UILabel *lblLatestExternalReportsCount;
@property (weak, nonatomic) IBOutlet UILabel *lblLegalEventsCount;
@property (weak, nonatomic) IBOutlet UILabel *lblMediaRecordsCount;
@property (weak, nonatomic) IBOutlet UILabel *lblCreditEventUpdateTime;
@property (weak, nonatomic) IBOutlet UILabel *lblFinancialRatiosUpdateTime;
@property (weak, nonatomic) IBOutlet UILabel *lblGeneralInformation;
@property (weak, nonatomic) IBOutlet UILabel *lblCustomerNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblBusinessType;
@property (weak, nonatomic) IBOutlet UILabel *lblIndustrySector;
@property (weak, nonatomic) IBOutlet UILabel *lblYearOfEstablishment;
@property (weak, nonatomic) IBOutlet UILabel *lblEmployeeSize;
@property (weak, nonatomic) IBOutlet UILabel *lblOwnership;
@property (weak, nonatomic) IBOutlet UILabel *lblRegisteredCapital;
@property (weak, nonatomic) IBOutlet UILabel *lblContactTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContactName;
@property (weak, nonatomic) IBOutlet UILabel *lblTelephone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblWebsite;
@property (weak, nonatomic) IBOutlet UILabel *lblCreditEvents;
@property (weak, nonatomic) IBOutlet UILabel *lblLatestExternalReports;
@property (weak, nonatomic) IBOutlet UILabel *lblLegalEvents;
@property (weak, nonatomic) IBOutlet UILabel *lblMediaRecords;

@property (weak, nonatomic) IBOutlet UITextField *fldCustomerNumber;
@property (weak, nonatomic) IBOutlet UITextField *fldBusinessType;
@property (weak, nonatomic) IBOutlet UITextField *fldIndustrySector;
@property (weak, nonatomic) IBOutlet UITextField *fldEstablishmentYear;
@property (weak, nonatomic) IBOutlet UITextField *fldEmployeeSize;
@property (weak, nonatomic) IBOutlet UITextField *fldRegisteredCapital;
@property (weak, nonatomic) IBOutlet UITextField *fldContactTitle;
@property (weak, nonatomic) IBOutlet UITextField *fldTelephone;
@property (weak, nonatomic) IBOutlet UITextField *fldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fldWebsite;
@property (weak, nonatomic) IBOutlet UITextField *fldContactName;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (retain, nonatomic) CustomerBehaviorView *customerBehaviorView;
@property (retain, nonatomic) CustomerNegativeCreditEventsView *customerNegativeCreditEventsView;
@property (readwrite, nonatomic) ActionIdentifier actionIndentifier;
@property (retain, nonatomic) UIButton *rightBarbutton;

@property (weak, nonatomic) IBOutlet UIView *externalRatingView;
@property (weak, nonatomic) IBOutlet UIView *scoreRatingView;
@property (weak, nonatomic) IBOutlet UIView *creditEventView;

@property (weak, nonatomic) UIView *chartSuperView;
@property (retain, nonatomic) NSArray *chartViewArray;
@property (retain, nonatomic) ChartView *zoomedChartView;

- (void)reloadData:(Report *)report;

@end
