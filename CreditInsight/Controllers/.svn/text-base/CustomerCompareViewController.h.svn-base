//
//  CustomerCompareViewController.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/10/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Customer.h"

@protocol CompareDelegate <NSObject>

- (void)compareWith:(NSMutableArray *)customerIds;

@end

@interface CustomerCompareViewController : BaseViewController<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) UISearchBar *customerSearchBar;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;

@property (weak, nonatomic) IBOutlet UIView *searchBkgView;
@property (retain, nonatomic) NSArray *searchCustomerArray;
@property (weak, nonatomic) IBOutlet UITableView *customerInfoTableView;

@property (retain, nonatomic) NSMutableArray *customerArrayToCompare;
@property (weak, nonatomic) id<CompareDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lblAddCustomerToCompare;

@property (retain, nonatomic) Customer *currentCustomer;

@end
