//
//  HomeViewController.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 12/24/12.
//  Copyright (c) 2012 Zhou, Megan (external - Partner). All rights reserved.
//

#import "HomeViewController.h"
#import "MainViewScroll.h"
#import "QuartzCore/QuartzCore.h"
#import "ReportsViewerViewController.h"
#import "CustomerViewController.h"
#import "WorkItemsViewController.h"
#import "Notification.h"
#import "HttpClient.h"
#import "Report.h"

@interface HomeViewController()

@property (retain, nonatomic) NSArray *reportsArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.searchResultArray  = [[NSMutableArray alloc] init]; 
  [[HttpClient sharedInstance] invoke:self httpMethod:@"retrieveNotifications:handler:" requestConfigName:@"notifications"];  
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
   GlobalClassUtil.tempReports = [NSMutableArray arrayWithCapacity:0];
  [self getAllReports];
}

- (void)getAllReports {
  [[HttpClient sharedInstance] invoke:self httpMethod:@"retrieveReports:handler:" requestConfigName:@"reports"];
}

- (void)initNavigationBar {
    // TODO: Need refine.
  self.blockOderIcon = [[CustomBadgeButton alloc]initWithFrame:CGRectMake(0, 0, 38, 38)];
  [self.blockOderIcon.btnWorkItem setImage:[UIImage imageNamed:@"BlockOrderIcon.png"] forState:UIControlStateNormal];
  [self.blockOderIcon.btnWorkItem setImage:[UIImage imageNamed:@"BlockOrderIcon_highlight.png"] forState:UIControlStateHighlighted];
  [self.blockOderIcon.btnWorkItem addTarget:self action:@selector(showBlockdOrder) forControlEvents:UIControlEventTouchUpInside];
  self.blockOderIcon.badgeValue.text = @"1";
  UIBarButtonItem *leftBarItem1 = [[UIBarButtonItem alloc] initWithCustomView:self.blockOderIcon];
  
  self.creditRequestIcon = [[CustomBadgeButton alloc]initWithFrame:CGRectMake(0, 0, 38, 38)];
  [self.creditRequestIcon.btnWorkItem setImage:[UIImage imageNamed:@"CreditRequestIcon.png"] forState:UIControlStateNormal];
  [self.creditRequestIcon.btnWorkItem setImage:[UIImage imageNamed:@"CreditRequestIcon_highlight.png"] forState:UIControlStateHighlighted];
  [self.creditRequestIcon.btnWorkItem addTarget:self action:@selector(showCreditRequest) forControlEvents:UIControlEventTouchUpInside];
  self.creditRequestIcon.badgeValue.text = @"2";
  UIBarButtonItem *leftBarItem2 = [[UIBarButtonItem alloc] initWithCustomView:self.creditRequestIcon];

  self.earlyWarningIcon = [[CustomBadgeButton alloc]initWithFrame:CGRectMake(0, 0, 38, 38)];
  [self.earlyWarningIcon.btnWorkItem setImage:[UIImage imageNamed:@"EarlyWarningIcon.png"] forState:UIControlStateNormal];
  [self.earlyWarningIcon.btnWorkItem setImage:[UIImage imageNamed:@"EarlyWarningIcon_highlight.png"] forState:UIControlStateHighlighted];
  [self.earlyWarningIcon.btnWorkItem addTarget:self action:@selector(showEarlyWarning) forControlEvents:UIControlEventTouchUpInside];
  self.earlyWarningIcon.badgeValue.text = @"3";
  UIBarButtonItem *leftBarItem3 = [[UIBarButtonItem alloc] initWithCustomView:self.earlyWarningIcon];
  
  
  NSArray *leftButtonItems = [[NSArray alloc]initWithObjects:leftBarItem1, leftBarItem2, leftBarItem3, nil];
  
  _btnSetting = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
  [_btnSetting setImage:[UIImage imageNamed:@"common_settings_icon.png"] forState:UIControlStateNormal];
  [_btnSetting setImage:[UIImage imageNamed:@"common_settings_icon_highlighted.png"] forState:UIControlStateHighlighted];
  [_btnSetting addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *rightBarItem1 = [[UIBarButtonItem alloc]initWithCustomView:_btnSetting];
  
  _mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 240, 37)];
  [_mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeWords];
  [_mySearchBar setPlaceholder:NSLocalizedString(@"CustomerSearch",nil)];
  [_mySearchBar setDelegate:self];
  UIBarButtonItem *rightBarItem2 = [[UIBarButtonItem alloc] initWithCustomView:_mySearchBar];
  
  NSArray *items = [[NSArray alloc]initWithObjects:rightBarItem1,rightBarItem2, nil];
  self.navigationItem.rightBarButtonItems = items;
  self.navigationItem.leftBarButtonItems = leftButtonItems;
  [self setBarTitle:NSLocalizedString(@"HomeViewController.Bar.Title", @"")];
}

- (void)showBlockdOrder {
  self.clickActiveButtonTag = BLOCKED_ORDER;
  [self goToWorkItemsController];
}

- (void)showCreditRequest {
  self.clickActiveButtonTag = CREDIT_REQUEST;
  [self goToWorkItemsController];
}

- (void)showEarlyWarning {
  self.clickActiveButtonTag = EARLY_WARNING;
  [self goToWorkItemsController];
}

- (void)setting {
  _currentActionMark = kSetting;
  [_mySearchBar endEditing:YES];
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:kSetting ofType:@"plist"];
  _settingArray = [[NSDictionary dictionaryWithContentsOfFile:plistPath] objectForKey:kSetting];
  [self popoverTableView:_btnSetting arrayContent:_settingArray title:NSLocalizedString(kSetting,nil)];
}

#pragma mark - Custom Delegate
- (void)commonTableViewPopoverWithSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([_currentActionMark isEqualToString:kSearch]) {
    [self closeCurrentPopover];
    self.selectedCustomer = [self.searchResultArray objectAtIndex:[indexPath row]];
    NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCustomer.customerId, @"${id}", nil];
    [[HttpClient sharedInstance] invoke:self httpMethod:@"customerOverview:handler:" requestConfigName:@"customerOverview" urlParameter:urlParamDict bodyParameter:nil];
  } else if ([_currentActionMark isEqualToString:kSetting]){
    _currentActionMark = kOthers;
    [self showDetailSettingInfoWithIndex:[indexPath row]];
  } else {
    // Others to setting
    [self.popoverNavigationController.topViewController.navigationItem.rightBarButtonItem setEnabled:YES];
    _detailSettingValue = [_detailContentValues objectAtIndex:[indexPath row]];
  }
}

- (void)keyboardWillShow:(NSNotification *)notification {
  CGPoint scrollPoint = CGPointMake(0.0, [self keyboardHeight:notification.userInfo]);
  self.scrollView.contentOffset = scrollPoint;
}

- (void)keyboardWillHide:(NSNotification *)notification {
  CGRect frame = self.scrollView.frame;
  self.scrollView.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
}

#pragma mark - UISearchDisplayDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [_mySearchBar endEditing:YES];
  _currentActionMark = kSearch;
  NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:searchBar.text, @"${input}", nil];
  [[HttpClient sharedInstance] invoke:self httpMethod:@"searchCustomers:handler:" requestConfigName:@"searchCustomers" urlParameter:urlParamDict bodyParameter:nil];
}

#pragma mark - Custom Methods
- (CGFloat)keyboardHeight:(NSDictionary *)userInfo {
  CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
  CGFloat keyboardHeight = 0.0;
  
  UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
  if ((orientation == UIInterfaceOrientationLandscapeLeft) || (orientation == UIInterfaceOrientationLandscapeRight)) {
    keyboardHeight = keyboardSize.width;
  } else {
    keyboardHeight = keyboardSize.height;
  }
  
  return keyboardHeight;
}

- (void)goReportsViewerViewController {
  ReportsViewerViewController *reportsViewerViewController =[[ReportsViewerViewController alloc]initWithNibName:@"ReportsViewerViewController" bundle:nil];
  reportsViewerViewController.reportsArray = _reportsArray;
  [self.navigationController pushViewController:reportsViewerViewController animated:YES];
}

- (void)showDetailSettingInfoWithIndex:(NSInteger)index {
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:kSetting ofType:@"plist"];
  _detailContentValues = [[NSDictionary dictionaryWithContentsOfFile:plistPath] objectForKey:[_settingArray objectAtIndex:index]];
  CommonTableViewPopoverContent *detailContentTableView = [[CommonTableViewPopoverContent alloc] initWithNibName:@"CommonTableViewPopoverContent" bundle:nil];
  detailContentTableView.optionsArray = _detailContentValues;
  detailContentTableView.delegate = self;
  // Add navigation bar button items
  UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(clickDoneButton)];
  UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel  target:self action:@selector(clickCancelButton)];
  
  [detailContentTableView.navigationItem setLeftBarButtonItem:cancelItem];
  [detailContentTableView.navigationItem setRightBarButtonItem:doneItem];
  [detailContentTableView.navigationItem.rightBarButtonItem setEnabled:NO];
  _settingDictKey = [_settingArray objectAtIndex:index];
  [detailContentTableView.navigationItem setTitle:NSLocalizedString(_settingDictKey, nil)];
  [self.popoverNavigationController pushViewController:detailContentTableView animated:YES];
}

- (void)clickCancelButton {
  _currentActionMark = kSetting;
  [self.popoverNavigationController popViewControllerAnimated:YES];
}

- (void)clickDoneButton {
  // Save setting data in user default 
  [GlobalClassUtil.settingValues setObject:_detailSettingValue forKey:_settingDictKey];
  [self closeCurrentPopover];
}

-(void)getNotificationDone:(NSArray *)notifications
{
  for (Notification *ntf in notifications) {
    switch (ntf.type) {
      case BLOCKED_ORDER:
        self.blockOderIcon.badgeValue.text = [NSString stringWithFormat:@"%d", ntf.number];
        if (ntf.number == 0) {
          self.blockOderIcon.btnWorkItem.enabled = NO;
          self.blockOderIcon.badgeView.hidden = YES;
        }else{
          self.blockOderIcon.btnWorkItem.enabled = YES;
          self.blockOderIcon.badgeView.hidden = NO;
        }
        break;
      case CREDIT_REQUEST:
        self.creditRequestIcon.badgeValue.text = [NSString stringWithFormat:@"%d", ntf.number];
        if (ntf.number == 0) {
          self.creditRequestIcon.btnWorkItem.enabled = NO;
          self.creditRequestIcon.badgeView.hidden = YES;
        }else{
          self.creditRequestIcon.btnWorkItem.enabled = YES;
          self.creditRequestIcon.badgeView.hidden = NO;
        }
        break;
      case EARLY_WARNING:
        self.earlyWarningIcon.badgeValue.text = [NSString stringWithFormat:@"%d", ntf.number];
        if (ntf.number == 0) {
          self.earlyWarningIcon.btnWorkItem.enabled = NO;
          self.earlyWarningIcon.badgeView.hidden = YES;
        }else{
          self.earlyWarningIcon.btnWorkItem.enabled = YES;
          self.earlyWarningIcon.badgeView.hidden = NO;
        }
        break;
      default:
        break;
    }
  }
}

- (void)searchCustomerDone:(NSArray *)searchResults {
  self.searchResultArray = searchResults;
  NSMutableArray *contentArray = [[NSMutableArray alloc]init];
  for (int i = 0; i < searchResults.count; i++) {
    Customer *customer = [searchResults objectAtIndex:i];
    [contentArray addObject:customer.customerName];
  }
  [self popoverTableView:self.mySearchBar arrayContent:contentArray title:nil];
}

- (void)goToCustomerViewController:(NSDictionary *)customerOverviewDict {
  CustomerViewController *customerViewController = [[CustomerViewController alloc] initWithNibName:@"CustomerViewController" bundle:nil];
  customerViewController.customer = self.selectedCustomer;
  customerViewController.creditEvents = [customerOverviewDict objectForKey:@"creditEvents"];
  customerViewController.scoreRating = [customerOverviewDict objectForKey:@"scoreRating"];
  customerViewController.extRatings = [customerOverviewDict objectForKey:@"externalRating"];
  customerViewController.fiancialRatiosDict = [customerOverviewDict objectForKey:@"finacialRatio"];
  [self.navigationController pushViewController:customerViewController animated:YES];
}

- (void)goToWorkItemsController {
  UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
  backItem.title = NSLocalizedString(@"Home", nil);;
  self.navigationItem.backBarButtonItem = backItem;
  WorkItemsViewController *workItemsViewController = [[WorkItemsViewController alloc] initWithNibName:@"WorkItemsViewController" bundle:nil];
  RightTabView *rightTabView = [[RightTabView alloc] initWithFrame:CGRectMake(963, 0, 61, 748)];
  [rightTabView setActiveButtonLocation:self.clickActiveButtonTag];
  rightTabView.lblFirst.text = NSLocalizedString(@"BlockedOrders", nil);
  rightTabView.lblSecond.text = NSLocalizedString(@"CreditRequests", nil);
  rightTabView.lblThird.text = NSLocalizedString(@"EarlyWarning", nil);
  workItemsViewController.rightTabView = rightTabView;
  workItemsViewController.activeButtonTag = self.clickActiveButtonTag;
  [self.navigationController pushViewController:workItemsViewController animated:YES];
}

#pragma mark - Http Response Delegate
- (void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig {
  NSLog(@"** Home ** requestConfig.name == %@, response == %@", requestConfig.name, response);
  if ([requestConfig.name isEqualToString:@"notifications"]) {
    [self getNotificationDone:response];
  } else if ([requestConfig.name isEqualToString:@"reports"]) {
    _reportsArray = [NSArray arrayWithArray:response];
    [self initVerticalScrollView:response];
  }else if ([requestConfig.name isEqualToString:@"searchCustomers"]) {
    [self searchCustomerDone:response];
  } else if ([requestConfig.name isEqualToString:@"customerOverview"]) {
    [self goToCustomerViewController:response];
  } else if ([requestConfig.name isEqualToString:@"deletefavorite"]) {
    [self reloadHomewReports];
    NSLog(@"in homeview controller delete favorite");
  } else if ([requestConfig.name isEqualToString:@"modifyfavorite"]) {
    NSLog(@"in homeview controller modifyfavorite favorite");
  } else {
    // Do Nothing 
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  _mySearchBar.text = @"";
  [_mySearchBar endEditing:YES];
}

- (void)reloadHomewReports {
  [[HttpClient sharedInstance] invoke:self httpMethod:@"retrieveReports:handler:" requestConfigName:@"reports"];
}

- (void)viewDidUnload {
  [self setScrollView:nil];
  [super viewDidUnload]; 
  }

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)initVerticalScrollView:(NSArray *)reportCategoteries {
  MainViewScroll *mainViewScroll = nil;
  
  for (ReportsCategory *reportCategory in reportCategoteries) {
    mainViewScroll = [[MainViewScroll alloc] initWithFrame:CGRectMake(0, [reportCategoteries indexOfObject:reportCategory] * kMainViewHeight, self.scrollView.frame.size.width, kMainViewHeight)];
    mainViewScroll.lblMainScrollViewTitle.text = NSLocalizedString(reportCategory.categoryName, nil);
    mainViewScroll.reportArray = reportCategory.reportArray;
    mainViewScroll.homeViewController = self;
    
    [self.scrollView addSubview:mainViewScroll];
  }
  
  self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, kMainViewHeight * [reportCategoteries count]);
}

@end
