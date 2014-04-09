//
//  CreditRequestView.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/30/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "CreditRequestView.h"
#import "OrderInfoTableCell.h"
#import "WorkListTableCell.h"
#import "HttpClient.h"
#import "CustomerViewController.h"
#import "NSString+Validation.h"

#define kGoToCustomerScreen @"goToCustomerViewController"
#define kCustomer @"Customer"
#define kCreditRequestListTableView 10
#define kRequestAmountTextFieldTag 4
#define kExpectedVolumnTextFieldTag 6

@implementation CreditRequestView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CreditRequestView" owner:self options:nil];
      if (nibs) {
        self = [nibs objectAtIndex:0];
        self.frame = frame;
        _creditRequestDetailTableView.backgroundView = nil;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReportViewerBgTexture.png"]];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
      }
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
  [self initData];
}

- (void)initData {
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"WorkItemDetail" ofType:@"plist"];
  NSDictionary *dict  = [[NSDictionary dictionaryWithContentsOfFile:plistPath] objectForKey:@"CreditRequest"];
  _lableNames = [dict objectForKey:@"LabelNames"];
  _keys = [dict objectForKey:@"SectionHeaders"];
  NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"10", nil] forKeys:[NSArray arrayWithObjects:@"${startPageNumber}",@"${pageSize}", nil]];
  [[HttpClient sharedInstance] invoke:_delegate httpMethod:@"retrieveCreditRequestList:handler:" requestConfigName:@"creditRequests" urlParameter:urlParamDict bodyParameter:nil];
  // Get first item detail info
}


#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  int currentTag = textField.tag;
  if (currentTag >= kRequestAmountTextFieldTag && currentTag <= kExpectedVolumnTextFieldTag) {
    if (![string isStringOnlyContainNumber]) {
      return NO;
    }
  }
  return YES;
}





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  if (textField.tag == kExpectedVolumnTextFieldTag) {
    [textField setReturnKeyType:UIReturnKeyDone];
  }
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  UITextField *nextTextField = (UITextField *)[self viewWithTag:(textField.tag + 1)];
  if (textField.tag == kExpectedVolumnTextFieldTag) {
     [textField resignFirstResponder];
  } else {
    [textField resignFirstResponder];
    [nextTextField becomeFirstResponder];
  }
  return NO;
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSInteger count = 0;
  if (tableView.tag == kCreditRequestListTableView) {
    count = 1;
  } else {
    count = _keys.count;
  }
  
  return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (tableView.tag == kCreditRequestListTableView) {
    return self.creditRequests.count;
  } else {
    NSString *key = [_keys objectAtIndex:section];
    NSArray *labelNameSection = [_lableNames objectForKey:key];
    return labelNameSection.count;
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section > 1) {
   NSString *key = NSLocalizedString([_keys objectAtIndex:section], nil);
   return key;
  } else {
   return nil;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView.tag == kCreditRequestListTableView) {
    static NSString *kCellID = @"CreditRequestListCellIndentifier";
    WorkListTableCell *cell = (WorkListTableCell *)[tableView dequeueReusableCellWithIdentifier:kCellID];
    if (cell == nil) {
      NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"WorkListTableCell" owner:self options:nil];
      cell = [array objectAtIndex:0];
    }
    [cell.lblCustomer setText:NSLocalizedString(@"Customer", nil)];
    [cell.lblItemProperty1 setText:NSLocalizedString(@"Status", nil)];
    [cell.lblItemProperty2 setText:NSLocalizedString(@"Priority", nil)];
    [cell.lblCreatedDate setText:NSLocalizedString(@"RequestDate", nil)];
    CreditRequest *creditRequest = [_creditRequests objectAtIndex:[indexPath row]];
    cell.lblCustomerName.text = creditRequest.customerName;
    cell.lblItemPropertyValue1.text = creditRequest.status;
    cell.lblItemPropertyValue2.text = creditRequest.priority;
    cell.lblCreatedDateValue.text = creditRequest.createdDate;
    NSString *key = [NSString stringWithFormat:@"CR%@",creditRequest.creditRequestId];
    if ([[GlobalClassUtil.isReadDict objectForKey:key] isEqualToString:@"YES"]) {
      [cell.unReadIconImageView setHidden:YES];
    }
    return cell;
  } else {
    NSString *key = [_keys objectAtIndex:[indexPath section]];
    NSArray *nameSection = [_lableNames objectForKey:key];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, 568, 63)];
    [textView setBackgroundColor:[UIColor clearColor]];
    textView.textColor = [UIColor darkGrayColor];
    textView.editable = YES;
    if ([indexPath section] > 4) {
      UITableViewCell *cell = [[UITableViewCell alloc] init];
      [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
      switch ([indexPath section]) {
        case 5:
          [cell.contentView addSubview:textView];
          [textView setText:_creditRequest.note];
          [cell.textLabel removeFromSuperview];
          break;
        case 6:
          cell.textLabel.text = @"Attachment name.pdf";
          cell.textLabel.textColor = [UIColor blueColor];
          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
          break;
        default:
          break;
      }
      return cell;
    } else {
      static NSString *kSectionsTableIndentifier = @"SectionsTableIndentifier";
      OrderInfoTableCell *cell = (OrderInfoTableCell *)[tableView dequeueReusableCellWithIdentifier:kSectionsTableIndentifier];
      if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"OrderInfoTableCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
      }
      [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
      cell.lblName.text = NSLocalizedString([nameSection objectAtIndex:[indexPath row]], nil);
      [cell.fldValue setDelegate:self];
      switch ([indexPath section]) {
        case 0:
          [cell.fldValue setEnabled:NO];
          [cell.fldValue setText:_creditRequest.creditRequestId];
          break;
        case 1:// Customer
          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
          [cell.fldValue setText:_creditRequest.customerName];
          break;
        case 2:// General Information
          if (indexPath.row == 0) {
            [cell.fldValue setHidden:YES];
            textView.frame = CGRectMake(12, 28, 562, 65);
            textView.text = _creditRequest.description;
            [cell.contentView addSubview:textView];
          } else {
            [cell.fldValue setTag:[indexPath row]];
            [cell.fldValue setEnabled:YES];
            switch (indexPath.row) {
              case 1:
                [cell.fldValue setText:_creditRequest.priority];
                break;
              case 2:
                [cell.fldValue setText:_creditRequest.status];
                break;
              case 3:
                [cell.fldValue setText:_creditRequest.reason];
                break;
              default:
                break;
            }
          }
          break;
        case 3: // Amount
          [cell.fldValue setKeyboardType:UIKeyboardTypeNumberPad];
          if (indexPath.row != 3) {
            [cell.fldValue setTag:([indexPath row] + 4)];
            [cell.fldValue setEnabled:YES];
            switch (indexPath.row) {
              case 0:
                [cell.fldValue setText:_creditRequest.requestAmount];
                break;
              case 1:
                [cell.fldValue setEnabled:YES];
                [cell.fldValue setText:_creditRequest.approved];
                break;
              case 2:
                [cell.fldValue setText:_creditRequest.expectedVolumn];
                break;
              default:
                break;
            }
          } else {
            [cell.fldValue setEnabled:NO];
             cell.fldValue.text = _creditRequest.creditLimit;
          }
          break;
        case 4: // Administrative Data
          [cell.fldValue setEnabled:NO];
          switch (indexPath.row) {
            case 0:
              [cell.fldValue setText:_creditRequest.createOnBy];
              break;
            case 1:
              [cell.fldValue setText:_creditRequest.changedOnBy];
              break;
            case 2:
              [cell.fldValue setText:_creditRequest.closeOnBy];
              break;
            default:
              break;
          }
          break;
        default:
          break;
      }

      
    
      return cell;
    }
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView.tag == kCreditRequestListTableView && _lastRow != [indexPath row]) {
    _lastRow = [indexPath row];
    CreditRequest *creditRequest = [_creditRequests objectAtIndex:[indexPath row]];
    WorkListTableCell *cell = (WorkListTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.unReadImageView = cell.unReadIconImageView;
    self.itemId = creditRequest.creditRequestId;
    [self sendRequestToGetItemDetailInfo:creditRequest.creditRequestId];
  } else {
    NSDictionary *urlParamDict = [[NSDictionary alloc] init];
    switch ([indexPath section]) {
      case 1: // Go to customer screen
        self.selectedCustomer = [[Customer alloc] init];
        self.selectedCustomer.customerId = self.creditRequest.customerId;
        self.selectedCustomer.customerName = self.creditRequest.customerName;
        urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedCustomer.customerId, @"${id}", nil];
        [[HttpClient sharedInstance] invoke:_delegate httpMethod:@"customerOverview:handler:" requestConfigName:@"customerOverview" urlParameter:urlParamDict bodyParameter:nil];
        break;
      case 6:// Show pdf document
        [_delegate showPDFDocument];
        break;
        
      default:
        break;
    }
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView.tag == kCreditRequestListTableView) {
    return 76.0;
  } else {
    if ([indexPath section] == 2 && indexPath.row == 0) {
     return 95.0;
    } else if ([indexPath section] == 5) {
     return 65.0;
    } else {
     return 44.0;
    }
  }
}

- (UIView *)findFirstResponder:(UIView* )view {
  for ( UIView *childView in view.subviews ) {
    if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) return childView;
    UIView *result = [self findFirstResponder:childView];
    if ( result ) return result;
  }
  return nil;
}

- (void)sendRequestToGetItemDetailInfo:(NSString *)itemId {
  NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:itemId, @"${itemId}", nil];
  [[HttpClient sharedInstance] invoke:_delegate httpMethod:@"searchDetailCreditRequestInfo:handler:" requestConfigName:@"creditRequestDetail" urlParameter:urlParamDict bodyParameter:nil];
}

- (void)setListTableViewFirstCellStyle {
  // Set default choose the first cell
  NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [_creditRequestListTableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
  WorkListTableCell *cell = (WorkListTableCell *)[_creditRequestListTableView cellForRowAtIndexPath:selectedIndexPath];
  self.unReadImageView = cell.unReadIconImageView;
}

#pragma mark - Http Response Delegate
-(void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig {
  if ([requestConfig.name isEqualToString:@"creditRequestDetail"]) {
    self.creditRequest = response;
    [_creditRequestDetailTableView reloadData];
  } else if ([requestConfig.name isEqualToString:@"customerOverview"]) {
    [[NSNotificationCenter defaultCenter] postNotificationName:kGoToCustomerScreen object:self userInfo:@{kGoToCustomerScreen:response,kCustomer:self.selectedCustomer}];
  } else if  ([requestConfig.name isEqualToString:@"creditRequests"]) {
    self.creditRequests = response;
    if (self.creditRequests.count > 0) {
      [_creditRequestListTableView reloadData];
      [self setListTableViewFirstCellStyle];
      CreditRequest *creditRequest = [_creditRequests objectAtIndex:0];
      _itemId = creditRequest.creditRequestId;
      [self sendRequestToGetItemDetailInfo:creditRequest.creditRequestId];
    }
  } else {
    // Do Nothing
  }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification*)notification {
  UIView *aView = [self findFirstResponder:self];
  if (![aView isKindOfClass:[UITextField class]] && ![aView isKindOfClass:[UITextView class]]) {
    return;
  }
  CGSize kbSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  CGFloat keyboardTop = self.frame.size.height - kbSize.width;
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
  [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
  CGFloat firstResponderLowOrigin = aView.superview.superview.frame.origin.y+aView.superview.frame.size.height+aView.superview.frame.origin.y;
  if (keyboardTop < firstResponderLowOrigin) {
   if ([aView isKindOfClass:[UITextView class]]) {
      [self.creditRequestDetailTableView setContentOffset:CGPointMake(_creditRequestDetailTableView.contentOffset.x,
                                                                      firstResponderLowOrigin - keyboardTop +aView.frame.size.height) animated:YES];
    }
  if (aView.bounds.size.height < keyboardTop - _creditRequestDetailTableView.bounds.origin.y) {
       [self.creditRequestDetailTableView setContentOffset:CGPointMake(_creditRequestDetailTableView.contentOffset.x,
                                                                       firstResponderLowOrigin - keyboardTop + _creditRequestDetailTableView.contentOffset.y + 40) animated:YES];
    }
  }
  [UIView commitAnimations];
}


- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
