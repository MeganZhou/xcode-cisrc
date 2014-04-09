//
//  WorkItemsViewController.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/3/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "WorkItemsViewController.h"
#import "LeftExpandableView.h"
#import "BlockOrderTableCell.h"
#import "NSString+Formatter.h"
#import "OrderDetailTableCell.h"
#import "OrderInfoTableCell.h"
#import "CustomerViewController.h"
#import "SalesOrder.h"
#import "HttpClient.h"
#import "EarlyWarningView.h"

#define kBlockedOrderListTableView 4
#define kDetailContentViewWidth 970
#define kDetailContentViewheight 748
#define kGoToCustomerScreen @"goToCustomerViewController"
#define kCustomer @"Customer"

@interface WorkItemsViewController ()

@end

@implementation WorkItemsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  if (GlobalClassUtil.isReadDict.count <= 0) {
    GlobalClassUtil.isReadDict = [[NSMutableDictionary alloc] init];
  }  
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToCustomerViewController:) name:kGoToCustomerScreen object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [self closeActionSheet];
  [self closeCurrentPopover];
}

- (void)viewDidUnload {
  [self setDetailContentView:nil];
  [self setDetailContentTableView:nil];
  [self setLockIconImageView:nil];
  [self setOrderListTableView:nil];
  [self setSwitchContainerView:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [super viewDidUnload];
}

- (void)initView {
  [_lockIconImageView setHidden:YES];
  _detailContentTableView.backgroundView = nil;
  self.rightTabView.delegate = self;
  [self.view addSubview:self.rightTabView];
  _detailContentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReportViewerBgTexture.png"]];
  [self onClickTabButtonWithTag:self.activeButtonTag];
}

- (void)initNavigationBar {
  self.rightBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clickRightBarItem)];
  self.navigationItem.rightBarButtonItem = self.rightBarItem ;
  [self setBarTitle:NSLocalizedString(@"BlockedOrders", nil)];
}

- (void)initBlockOrderData {
  // For BlockOrder
  if (GlobalClassUtil.isUnlockDict.count <= 0) {
    GlobalClassUtil.isUnlockDict = [[NSMutableDictionary alloc] init];
  }
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"WorkItemDetail" ofType:@"plist"];
  _lableNames = [[NSDictionary dictionaryWithContentsOfFile:plistPath] objectForKey:@"BlockedOrder"];
  _keys = [[_lableNames allKeys] sortedArrayUsingSelector:@selector(compare:)];
 }

- (CreditRequestView *)creditRequestView {
  if (!_creditRequestView) {
    _creditRequestView = [[CreditRequestView alloc]initWithFrame:CGRectMake(0, 0, kDetailContentViewWidth, kDetailContentViewheight)];
    _creditRequestView.delegate = self;
    [_switchContainerView addSubview:self.creditRequestView];
  }
  return _creditRequestView;
}

- (EarlyWarningView *)earlyWarningView {
  if (!_earlyWarningView) {
    _earlyWarningView = [[EarlyWarningView alloc] initWithFrame:CGRectMake(0, 0, kDetailContentViewWidth, kDetailContentViewheight)];
    _earlyWarningView.delegate = self;
    [_switchContainerView addSubview:self.earlyWarningView];
  }
  
  return _earlyWarningView;
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (tableView.tag != kBlockedOrderListTableView) {
    return _keys.count;
  } else {
    return 1;
  }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (tableView.tag == kBlockedOrderListTableView) {
     return _itemsArray.count;
  } else {
    if (section == 3) {
      return _salesOrder.orderDetails.count;
    } else {
      NSString *key = [_keys objectAtIndex:section];
      NSArray *labelNameSection = [_lableNames objectForKey:key];
      return labelNameSection.count;
    }
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (tableView.tag != kBlockedOrderListTableView && section == 3) {
    NSString *key = NSLocalizedString([_keys objectAtIndex:section], nil);
    return key;
  } else {
    return nil;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView.tag == kBlockedOrderListTableView) {
    static NSString *kCellID = @"BlockedOrderCellIndentifier";
    BlockOrderTableCell *cell = (BlockOrderTableCell *)[tableView dequeueReusableCellWithIdentifier:kCellID];
    if (cell == nil) {
      NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BlockOrderTableCell" owner:self options:nil];
      cell = [array objectAtIndex:0];
    }
    [cell.lblSaleOrderNoTitle setText:NSLocalizedString(@"SalesOrderNO", nil)];
    [cell.lblAmountTitle setText:NSLocalizedString(@"Amount", nil)];
    [cell.lblCreatedDateTitle setText:NSLocalizedString(@"CreatedDate", nil)];
    SalesOrder *salesOrder = [_itemsArray objectAtIndex:[indexPath row]];
    cell.lblSaleOrderNO.text = salesOrder.orderNumber;
    cell.lblAmount.text =  [salesOrder.orderAmount stringCurrencyFormat];
    cell.lblCreatedDate.text =  [salesOrder.date stringDateFormat];
    NSString *key = [NSString stringWithFormat:@"BO%@",salesOrder.orderId];
    if ([[GlobalClassUtil.isReadDict objectForKey:key] isEqualToString:@"YES"]) {
      [cell.unReadIconImageView setHidden:YES];
    }
    return cell;
  } else {
    if ([indexPath section] != 3) {
      NSString *key = [_keys objectAtIndex:[indexPath section]];
      NSArray *nameSection = [_lableNames objectForKey:key];
      static NSString *kSectionsTableIndentifier = @"SectionsTableIndentifier";
      OrderInfoTableCell *cell = (OrderInfoTableCell *)[tableView dequeueReusableCellWithIdentifier:kSectionsTableIndentifier];
      if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"OrderInfoTableCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
      }
      [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
      cell.lblName.text = NSLocalizedString([nameSection objectAtIndex:[indexPath row]], nil);
      if ([indexPath section] == 0) {
        cell.fldValue.text = _salesOrder.orderNumber;
      } else if ([indexPath section] == 1) {
        cell.fldValue.text = _salesOrder.customerName;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      } else if ([indexPath section] == 2) {
        switch ([indexPath row]) {
          case 0:
            cell.fldValue.text = [_salesOrder.orderAmount stringCurrencyFormat];
            break;
          case 1:
            cell.fldValue.text = _salesOrder.createdDate;
            break;
          case 2:
            cell.fldValue.text = _salesOrder.sales;
            break;
          default:
            break;
        }
      } else {
      // Do nothing
      }
      return cell;
    } else {
      static NSString *kCellID = @"OrderDetailCellIndentifier";
      OrderDetailTableCell *cell = (OrderDetailTableCell *)[tableView dequeueReusableCellWithIdentifier:kCellID];
      if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"OrderDetailTableCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
      }
      NSDictionary *orderItemDict = [_salesOrder.orderDetails objectAtIndex:[indexPath row]];
      cell.lblName.text = [orderItemDict objectForKey:@"name"];
      cell.lblPrice.text = [[orderItemDict objectForKey:@"price"] stringCurrencyFormat];
      cell.lblId.text = [orderItemDict objectForKey:@"model"];
      cell.lblTotalAmount.text = [NSString  stringWithFormat:@"%@: %@ X %@",NSLocalizedString(@"Total", nil),
                                  [orderItemDict objectForKey:@"quantity"], cell.lblPrice.text];
      [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

      return cell;
    }
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView.tag == kBlockedOrderListTableView && _lastRow != [indexPath row]) {
    _lastRow = [indexPath row];
    _salesOrder = [_itemsArray objectAtIndex:[indexPath row]];
    _itemId = _salesOrder.orderId;
    [self sendRequestToGetItemDetailInfo:_itemId];
    BlockOrderTableCell *cell = (BlockOrderTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.unReadImageView = cell.unReadIconImageView;
  } else {
    if([indexPath section] == 1) {
      self.selectedCustomer = [[Customer alloc] init];
      self.selectedCustomer.customerId = _salesOrder.customerId;
      self.selectedCustomer.customerName = _salesOrder.customerName;
      NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_salesOrder.customerId, @"${id}", nil];
      [[HttpClient sharedInstance] invoke:self httpMethod:@"customerOverview:handler:" requestConfigName:@"customerOverview" urlParameter:urlParamDict bodyParameter:nil];
    }
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView.tag == kBlockedOrderListTableView) {
    return 65.0;
  } else {
    if ([indexPath section] == 3) {
      return 58.0;
    } else {
      return 44.0;
    }
  }
}

#pragma mark - Custom Delegate
- (void)onClickTabButtonWithTag:(NSInteger)tag {
  self.activeButtonTag = tag;
  [self.view endEditing:YES];
  [self.rightTabView setButtonEnableWithCurrentButtonTag:tag];
  switch (tag) {
    case WI_BLOCKED_ORDER:
      if (self.itemsArray.count <= 0 ) {
        [self sendQueryBlockOrderRequest];
      } else {
      [self updateViewForBlockOrderRelease];
      }
      if (_creditRequestView) {
        [self.creditRequestView setHidden:YES];
      }
      if (_earlyWarningView) {
        [self.earlyWarningView setHidden:YES];
      }
      [_detailContentTableView setHidden:NO];
      [self setBarTitle:NSLocalizedString(@"BlockedOrders", nil)];
      break;
    case WI_CREDIT_REQUEST:
      [self.rightBarItem setEnabled:YES];
      [_lockIconImageView setHidden:YES];
      // To re-get data when data have not load completed and recover network connection.
      if (_creditRequestView && _creditRequestView.creditRequests.count <= 0) {
        [_creditRequestView initData];
      }
      [self.creditRequestView setHidden:NO];
      if (_earlyWarningView) {
        [self.earlyWarningView setHidden:YES];
      }
      [self setBarTitle:NSLocalizedString(@"CreditRequests", nil)];
      break;
    case WI_EARLY_WARNING:
      [self.rightBarItem setEnabled:YES];
      [_lockIconImageView setHidden:YES];
      [_detailContentTableView setHidden:YES];
      if (_creditRequestView) {
        [self.creditRequestView setHidden:YES];
      }
      // To re-get data when data have not load completed and recover network connection.
      if (_earlyWarningView && _earlyWarningView.warningList.count <= 0) {
        [_earlyWarningView initData];
      }
      [self.earlyWarningView setHidden:NO];
      [self setBarTitle:NSLocalizedString(@"EarlyWarning", nil)];
      break;
      
    default:
      break;
  }
}


- (void)showPDFDocument {
  BaseViewController *viewController = [[BaseViewController alloc] init];
  viewController.view.frame = CGRectMake(0, 0, 1024, 768);
  UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 10, 1017, 758)];
  NSURL *targetURL =[NSURL URLWithString:@"http://developer.apple.com/iphone/library/documentation/UIKit/Reference/UIWebView_Class/UIWebView_Class.pdf"];
  NSURLRequest*request =[NSURLRequest requestWithURL:targetURL];
  [webView loadRequest:request];
  [viewController.view addSubview:webView];
  [viewController setBarTitle:@"PDF"];
  [self.navigationController pushViewController:viewController animated:YES];
  
}

#pragma mark - Custom Method
- (void)sendQueryBlockOrderRequest {
  NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"10", nil] forKeys:[NSArray arrayWithObjects:@"${startPageNumber}",@"${pageSize}", nil]];
  [[HttpClient sharedInstance] invoke:self httpMethod:@"retrieveBlockedOrderList:handler:" requestConfigName:@"blockedOrders" urlParameter:urlParamDict bodyParameter:nil];
}


- (void)sendRequestToGetItemDetailInfo:(NSString *)itemId {
  NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_itemId, @"${itemId}", nil];
  [[HttpClient sharedInstance] invoke:self httpMethod:@"searchDetailSalesOrderInfo:handler:" requestConfigName:@"blockedOrderDetail" urlParameter:urlParamDict bodyParameter:nil];
}

- (void)clickRightBarItem {
  NSArray *buttonTitles = [[NSArray alloc] init];
  switch (self.activeButtonTag) {
    case WI_BLOCKED_ORDER:
      buttonTitles = [NSArray arrayWithObjects:NSLocalizedString(@"Release", nil), nil];
      break;
    case WI_CREDIT_REQUEST:
      buttonTitles = [NSArray arrayWithObjects:NSLocalizedString(@"Approve", nil),NSLocalizedString(@"Reject", nil),NSLocalizedString(@"Save", nil), nil];
      break;
    case WI_EARLY_WARNING:
      buttonTitles = [NSArray arrayWithObjects:NSLocalizedString(@"Ignore", nil),NSLocalizedString(@"Forward", nil),NSLocalizedString(@"BlockMasterData", nil), nil];
      break;
    default:
      break;
  }
  [self closeActionSheet];
  UIActionSheet *actionSheet =[[UIActionSheet alloc] init];
  actionSheet.delegate = self;
  actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
  for (NSString *buttonTitle in buttonTitles) {
    [actionSheet addButtonWithTitle:buttonTitle];
  }
  [actionSheet showFromBarButtonItem:self.rightBarItem animated:YES];
}

- (void)updateViewForBlockOrderRelease {
  [_lockIconImageView setHidden:NO];
    if ([[GlobalClassUtil.isUnlockDict objectForKey:_itemId] isEqualToString:@"YES"]) { //unlock
      [_rightBarItem setEnabled:NO];
      [_lockIconImageView setImage:[UIImage imageNamed:@"blockorder_unlock_icon.png"]];
    } else { //lock
      [_rightBarItem setEnabled:YES];
      [_lockIconImageView setImage:[UIImage imageNamed:@"blockorder_lock_icon.png"]];
    }
}

- (void)goToCustomerViewController:(NSNotification *)notification {
  NSDictionary *customerOverviewDict = [notification.userInfo objectForKey:kGoToCustomerScreen];
  CustomerViewController *customerViewController = [[CustomerViewController alloc] initWithNibName:@"CustomerViewController" bundle:nil];
  customerViewController.customer = [notification.userInfo objectForKey:kCustomer];
  customerViewController.creditEvents = [customerOverviewDict objectForKey:@"creditEvents"];
  customerViewController.scoreRating = [customerOverviewDict objectForKey:@"scoreRating"];
  customerViewController.extRatings = [customerOverviewDict objectForKey:@"externalRating"];
  customerViewController.fiancialRatiosDict = [customerOverviewDict objectForKey:@"finacialRatio"];
  [self.navigationController pushViewController:customerViewController animated:YES];
}

- (void)closeActionSheet {
  for (UIWindow *window in [UIApplication sharedApplication].windows) {
    for (UIView *view in window.subviews) {
      [self dismissActionSheetInView:view];
    }
  }
}

- (void)dismissActionSheetInView:(UIView *)view {
  if ([view isKindOfClass:[UIActionSheet class]]) {
    UIActionSheet *actionView = (UIActionSheet *)view;
    [actionView dismissWithClickedButtonIndex:actionView.cancelButtonIndex animated:NO];
  } else {
    for (UIView *subView in view.subviews) {
      [self dismissActionSheetInView:subView];
    }
  }
}

- (void)setListTableViewFirstCellStyle {
  // Set default choose the first cell
  NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [_orderListTableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
  BlockOrderTableCell *cell = (BlockOrderTableCell *)[_orderListTableView cellForRowAtIndexPath:selectedIndexPath];
  self.unReadImageView = cell.unReadIconImageView;
}


#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex > -1) {
    NSString *key = @"";
    switch (self.activeButtonTag) {
      case WI_BLOCKED_ORDER:
        [_rightBarItem setEnabled:NO];
        [_lockIconImageView setImage:[UIImage imageNamed:@"blockorder_unlock_icon.png"]];
        [GlobalClassUtil.isUnlockDict setObject:@"YES" forKey:_itemId];
        key = [NSString stringWithFormat:@"BO%@",_itemId];
        [self.unReadImageView setHidden:YES];
        break;
      case WI_CREDIT_REQUEST:
        key = [NSString stringWithFormat:@"CR%@",_creditRequestView.itemId];
        [_creditRequestView.unReadImageView setHidden:YES];
        break;
      case WI_EARLY_WARNING:
        key = [NSString stringWithFormat:@"EW%@",_earlyWarningView.itemId];
        [_earlyWarningView.unReadImageView setHidden:YES];
        break;
        
      default:
        break;
    }
    [GlobalClassUtil.isReadDict setObject:@"YES" forKey:key];
  }
}



#pragma mark - Http Response Delegate
- (void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig {
  switch (self.activeButtonTag) {
    case WI_BLOCKED_ORDER:
      if ([requestConfig.name isEqualToString:@"customerOverview"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kGoToCustomerScreen object:self userInfo:@{kGoToCustomerScreen:response,kCustomer:self.selectedCustomer}];
      } else if ([requestConfig.name isEqualToString:@"blockedOrderDetail"]) {
         [self initBlockOrderData];
        _salesOrder = response;
        [self updateViewForBlockOrderRelease];
        [_detailContentTableView reloadData];
      } else if ([requestConfig.name isEqualToString:@"blockedOrders"]) {
        self.itemsArray = response;
        if (self.itemsArray.count > 0) {
          [_orderListTableView reloadData];
          [self setListTableViewFirstCellStyle];
          SalesOrder *salesOrder = [_itemsArray objectAtIndex:0];
          _itemId = salesOrder.orderId;
          [self sendRequestToGetItemDetailInfo:_itemId];
        }
      }
      break;
    case WI_CREDIT_REQUEST:
      [_creditRequestView succeed:response requestConfig:requestConfig];
      break;
    case WI_EARLY_WARNING:
      [_earlyWarningView succeed:response requestConfig:requestConfig];
      break;
      
    default:
      break;
  }
}



@end
