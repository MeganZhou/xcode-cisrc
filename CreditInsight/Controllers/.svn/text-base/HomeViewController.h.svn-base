//
//  HomeViewController.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 12/24/12.
//  Copyright (c) 2012 Zhou, Megan (external - Partner). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomBadgeButton.h"
#import "Customer.h"

#define kSalesReport (@"Sales Report")
#define kCreditReport (@"Credit Report")
#define kMyFavorite (@"My Favorite")
#define kSearch (@"Search")
#define kSetting (@"Setting")
#define kCurrency (@"")
#define kOthers (@"Others")

@interface HomeViewController : BaseViewController <UIScrollViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) NSArray *searchResultArray;
@property (retain, nonatomic) UISearchBar *mySearchBar;
@property (retain, nonatomic) UIButton *btnSetting;
@property (strong, nonatomic) CustomBadgeButton *blockOderIcon;
@property (strong, nonatomic) CustomBadgeButton *creditRequestIcon;
@property (strong, nonatomic) CustomBadgeButton *earlyWarningIcon;

@property (retain, nonatomic) NSString *currentActionMark;
@property (retain, nonatomic) NSArray *settingArray;
@property (retain, nonatomic) NSArray *detailContentValues;
@property (retain, nonatomic) NSString *detailSettingValue;
@property (retain, nonatomic) NSString *settingDictKey;

@property (retain, nonatomic) Customer *selectedCustomer;
@property (nonatomic) NSInteger clickActiveButtonTag;

// TODO: The method will remove to corodinatorViewController.
- (void)goReportsViewerViewController;
- (void)getAllReports;

@end
