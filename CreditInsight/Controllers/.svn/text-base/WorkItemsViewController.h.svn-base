//
//  WorkItemsViewController.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/3/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RightTabView.h"
#import "SalesOrder.h"
#import "Customer.h"
#import "CreditRequestView.h"
@class EarlyWarningView;

typedef enum
{
  WI_BLOCKED_ORDER = 1,
  WI_CREDIT_REQUEST = 2,
  WI_EARLY_WARNING = 3
} ActiveTabEventTag;


@interface WorkItemsViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,RightTabViewDelegate,UIActionSheetDelegate,CreditRequestViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *detailContentView;
@property (weak, nonatomic) IBOutlet UIView *switchContainerView;
@property (retain, nonatomic) NSArray *itemsArray;
@property (retain, nonatomic) NSDictionary *lableNames;
@property (retain, nonatomic) NSArray *keys;
@property (retain, nonatomic) NSDictionary *itemDetailDict;
@property (retain, nonatomic) NSString *itemId;
@property (retain, nonatomic) SalesOrder *salesOrder;
@property (retain, nonatomic) Customer *selectedCustomer;
@property (retain, nonatomic) RightTabView *rightTabView;

@property (weak, nonatomic) IBOutlet UITableView *detailContentTableView;
@property (weak, nonatomic) IBOutlet UIImageView *lockIconImageView;
@property (weak, nonatomic) IBOutlet UITableView *orderListTableView;

@property (strong, nonatomic) UIBarButtonItem *rightBarItem;
@property (retain, nonatomic) CreditRequestView *creditRequestView;
@property (retain, nonatomic) EarlyWarningView *earlyWarningView;
@property (retain, nonatomic) UIImageView *unReadImageView;

@property (nonatomic) NSInteger activeButtonTag;
@property (nonatomic) NSInteger lastRow;
@end
