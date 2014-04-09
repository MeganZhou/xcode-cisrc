//
//  EarlyWarningView.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/31/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "EarlyWarningView.h"
#import "OrderInfoTableCell.h"
#import "WorkListTableCell.h"
#import "EarlyWarningInformationTableCell.h"
#import "HttpClient.h"
#import "EarlyWarning.h"
#import "Customer.h"


@interface EarlyWarningView()

@property (strong, nonatomic) WarningDetail *warningDetail;

@end

@implementation EarlyWarningView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"EarlyWarningView" owner:self options:nil];
    if (nibs) {
      self = [nibs objectAtIndex:0];
      self.frame = frame;
      _warningDetailTableView.backgroundView = nil;
      self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReportViewerBgTexture.png"]];
    }
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  [self initData];
}

- (void)initData {
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"WorkItemDetail" ofType:@"plist"];
  NSDictionary *dict  = [[NSDictionary dictionaryWithContentsOfFile:plistPath] objectForKey:@"EarlyWarning"];
  _lableNames = [dict objectForKey:@"LabelNames"];
  _keys = [dict objectForKey:@"SectionHeaders"];
  NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"10", nil] forKeys:[NSArray arrayWithObjects:@"${startPageNumber}", @"${pageSize}", nil]];
  [[HttpClient sharedInstance] invoke:_delegate httpMethod:@"retrieveEarlyWarningList:handler:" requestConfigName:@"warning" urlParameter:urlParamDict bodyParameter:nil];
  // Get first item detail info
}




- (void)initStyle {
  NSIndexPath *firstIndex = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.warningListTableView selectRowAtIndexPath:firstIndex animated:NO scrollPosition:UITableViewScrollPositionBottom];
  WorkListTableCell *cell = (WorkListTableCell *)[_warningListTableView cellForRowAtIndexPath:firstIndex];
  self.unReadImageView = cell.unReadIconImageView;
}

#pragma mark UITableView data source and delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSInteger count = 0;
  if (tableView.tag == kEarlyWarningListTableView) {
    count = 1;
  } else {
    count = _keys.count;;
  }
  
  return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (tableView.tag == kEarlyWarningListTableView) {
    return [_warningList count];
  } else {
    return 1;
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section >= 2) {
    NSString *key = NSLocalizedString([_keys objectAtIndex:section], nil);
    return key;
  } else {
    return nil;
  }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView.tag == kEarlyWarningListTableView) {
    static NSString *kCellID = @"CreditRequestListCellIndentifier";
    WorkListTableCell *cell = (WorkListTableCell *)[tableView dequeueReusableCellWithIdentifier:kCellID];
    if (cell == nil) {
      NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"WorkListTableCell" owner:self options:nil];
      cell = [array objectAtIndex:0];
    }
    Warning *warning = [_warningList objectAtIndex:indexPath.row];
    cell.lblCustomer.text = NSLocalizedString(@"Customer", nil);
    cell.lblCustomerName.text = warning.customerName;
    cell.lblItemProperty1.text = NSLocalizedString(@"Priority", nil);
    cell.lblItemPropertyValue1.text = warning.priority;
    cell.lblItemProperty2.text = NSLocalizedString(@"WarningType", nil);    
    cell.lblItemPropertyValue2.text = warning.warningType;
    cell.lblCreatedDate.text = NSLocalizedString(@"CreateDate", nil);
    NSString *key = [NSString stringWithFormat:@"EW%@",warning.warningId];
    if ([[GlobalClassUtil.isReadDict objectForKey:key] isEqualToString:@"YES"]) {
      [cell.unReadIconImageView setHidden:YES];
    }
    return cell;
  } else {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSString *key = [_keys objectAtIndex:[indexPath section]];
    NSArray *nameSection = [_lableNames objectForKey:key];

    if ([indexPath section] < 2) {
      static NSString *kSectionsTableIndentifier = @"SectionsTableIndentifier";
      OrderInfoTableCell *detailCell = (OrderInfoTableCell *)[tableView dequeueReusableCellWithIdentifier:kSectionsTableIndentifier];
      
      if (detailCell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"OrderInfoTableCell" owner:self options:nil];
        detailCell = [array objectAtIndex:0];
      }
      
      [detailCell setSelectionStyle:UITableViewCellSelectionStyleNone];
      
      [detailCell.fldValue setDelegate:self];
      detailCell.lblName.text = NSLocalizedString([nameSection objectAtIndex:[indexPath row]], nil);
      if (indexPath.section == 0) { // Warning ID
        detailCell.fldValue.text = _warningDetail.warningId;
      } else if (indexPath.section == 1) { // Customer
        detailCell.fldValue.text = _warningDetail.customerName;
        detailCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      } else {
        // Do nothing.
      }
      
      return detailCell;
    } else if ([indexPath section] == 2) {
      static NSString *kSectionsTableIndentifier = @"EarlyWarningInformationTableCell";
      EarlyWarningInformationTableCell *infoCell = (EarlyWarningInformationTableCell *)[tableView dequeueReusableCellWithIdentifier:kSectionsTableIndentifier];
      
      if (infoCell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"EarlyWarningInformationTableCell" owner:self options:nil];
        infoCell = [array objectAtIndex:0];
      }
      
      if (_warningDetail.generalInfo.matrix) {
        [infoCell drawMatrixRectangle:_warningDetail.generalInfo.matrix];
      }
      
      [infoCell setSelectionStyle:UITableViewCellSelectionStyleNone];
     
      return infoCell;
    } else if ([indexPath section] == 3) {
      UITableViewCell *reasonCell = [[UITableViewCell alloc] init];
      [reasonCell setSelectionStyle:UITableViewCellSelectionStyleNone];
      
      UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, 568, 63)];
      UIFont *font = [UIFont fontWithName:@"Helvetica" size:13.0];
      
      [textView setBackgroundColor:[UIColor clearColor]];
      textView.textColor = [UIColor darkGrayColor];
      textView.font = font;
      textView.text = _warningDetail.warningReason;
      textView.editable = NO;
      
      [reasonCell.contentView addSubview:textView];
      [reasonCell.textLabel removeFromSuperview];
      return reasonCell;
    } else {
      // Do nothing.
    }
    
    return cell;      
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   if (tableView.tag == kEarlyWarningListTableView && _lastRow != [indexPath row]) {
     _lastRow = [indexPath row];
    WorkListTableCell *cell = (WorkListTableCell *)[tableView cellForRowAtIndexPath:indexPath];
     self.unReadImageView = cell.unReadIconImageView;
    Warning *warning = [_warningList objectAtIndex:indexPath.row];
     _itemId = warning.warningId;
    [self sendRequestToGetWarningDetail:warning.warningId];
   } else {
     if (indexPath.section == 1) {
       NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_warningDetail.customerId, @"${id}", nil];
       [[HttpClient sharedInstance] invoke:_delegate httpMethod:@"customerOverview:handler:" requestConfigName:@"customerOverview" urlParameter:urlParamDict bodyParameter:nil];
     }      
   }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView.tag == kEarlyWarningListTableView) {
    return 76.0;
  } else {
    if ([indexPath section] == 2) {
      return 350.0;
    } else if ([indexPath section] == 3) {
      return 65.0;
    } else {
      return 44.0;
    }
  }
}

#pragma mark - Http Response Delegate
- (void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig {
  NSLog(@"** EarlyWarning ** requestConfig.name == %@, response == %@", requestConfig.name, response);
  
  if ([requestConfig.name isEqualToString:@"warning"]) {
    _warningList = (NSArray *)response;
    if (_warningList.count > 0) {
      [_warningListTableView reloadData];
      [self initStyle];
      Warning *warning = [_warningList objectAtIndex:0];
      _itemId = warning.warningId;
      [self sendRequestToGetWarningDetail:warning.warningId];
    }
  } else if ([requestConfig.name isEqualToString:@"warningDetail"]) {
    _warningDetail = (WarningDetail *)response;
    [_warningDetailTableView reloadData];
  } else if ([requestConfig.name isEqualToString:@"customerOverview"]) {
    Customer *customer  = [[Customer alloc] init];
    customer.customerId = _warningDetail.customerId;
    customer.customerName = _warningDetail.customerName;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goToCustomerViewController" object:self userInfo:@{@"goToCustomerViewController":response, @"Customer":customer}];
  } else {
    // Do Nothing
  }
}

- (void)sendRequestToGetWarningDetail:(NSString *)warningId {
  NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:warningId, @"${itemId}", nil];
  
  [[HttpClient sharedInstance] invoke:_delegate httpMethod:@"retrieveEarlyWarningDetail:handler:" requestConfigName:@"warningDetail" urlParameter:urlParamDict bodyParameter:nil];
}

@end
