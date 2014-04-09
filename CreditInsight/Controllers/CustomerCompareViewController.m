//
//  CustomerCompareViewController.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/10/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "CustomerCompareViewController.h"
#import "CustomerInfoTableCell.h"
#import "CommonChart.h"
#import "Customer.h"
#import "HttpClient.h"

@interface CustomerCompareViewController ()

@end

@implementation CustomerCompareViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _searchCustomerArray = [[NSArray alloc] init];
  _customerArrayToCompare = [NSMutableArray arrayWithCapacity:0];
}

- (void)initView {
  [_btnDone setEnabled:NO];
  _customerSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(114, 0, 240, 37)];
  [_customerSearchBar setAutocapitalizationType:UITextAutocapitalizationTypeWords];
  [[_customerSearchBar.subviews objectAtIndex:0] removeFromSuperview];
  [_customerSearchBar setPlaceholder:NSLocalizedString(@"CustomerSearch", nil)];
  [_customerSearchBar setDelegate:self];
  [_searchBkgView addSubview:_customerSearchBar];
  [_btnDone setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
  [_btnCancel setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
  [_lblAddCustomerToCompare setText:NSLocalizedString(@"AddCustomerToCompare", nil)];
}

- (void)viewDidUnload {
  [self setSearchBkgView:nil];
  [self setBtnDone:nil];
  [self setCustomerInfoTableView:nil];
  [self setBtnCancel:nil];
  [self setLblAddCustomerToCompare:nil];
  [super viewDidUnload];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _searchCustomerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *kCellID = @"CustomerInfoCellIndentifier";
  CustomerInfoTableCell *cell = (CustomerInfoTableCell *)[tableView dequeueReusableCellWithIdentifier:kCellID];
  if (cell == nil) {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CustomerInfoTableCell" owner:self options:nil];
    cell = [array objectAtIndex:0];
  }
  
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  Customer *customer = [_searchCustomerArray objectAtIndex:[indexPath row]];
  cell.lblCustomerName.text = customer.customerName;
  cell.lblCustomerNum.text = customer.customerNumber;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [_btnDone setEnabled:YES];
  CustomerInfoTableCell *selectedCell = (CustomerInfoTableCell *)[tableView cellForRowAtIndexPath:indexPath];
  Customer *customer = [_searchCustomerArray objectAtIndex:[indexPath row]];
  
  if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
    selectedCell.accessoryType = UITableViewCellAccessoryNone;
    [_customerArrayToCompare removeObject:customer];
  } else {
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    [_customerArrayToCompare addObject:customer];
  }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
  UITableViewCell *unSelectedCell = [tableView cellForRowAtIndexPath:indexPath];
  unSelectedCell.accessoryType = UITableViewCellAccessoryNone;
  Customer *customer = [_searchCustomerArray objectAtIndex:[indexPath row]];
  [_customerArrayToCompare removeObject:customer];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 42.0;
}

- (BOOL)disablesAutomaticKeyboardDismissal {
  return NO;
}

#pragma mark - Action Methods
- (IBAction)onClickCancelButton:(id)sender {
  [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)onClickDoneButton:(id)sender {
  [_delegate compareWith:_customerArrayToCompare];
  [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - UISearchDisplayDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [_customerSearchBar endEditing:YES];
  NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:searchBar.text, @"${input}", nil];
  [[HttpClient sharedInstance] invoke:self httpMethod:@"searchCustomers:handler:" requestConfigName:@"searchCustomers" urlParameter:urlParamDict bodyParameter:nil];
}


#pragma mark - Http Response Delegate
-(void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig {
  if ([requestConfig.name isEqualToString:@"searchCustomers"]) {
   self.searchCustomerArray = [self deleteCurrentCustomerIfExist:response];
   [self.customerInfoTableView reloadData];
  }
}

#pragma mark - Custom method 
- (NSArray *)deleteCurrentCustomerIfExist:(NSMutableArray *)searchResults {
  for (int i =0; i < searchResults.count; i++) {
    Customer *customer = [searchResults objectAtIndex:i];
    if ([customer.customerId isEqualToString:_currentCustomer.customerId]) {
      [searchResults removeObject:customer];
    }
  }
  return searchResults;
}

@end
