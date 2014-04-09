//
//  CustomerBehaviorView.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/4/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartView.h"
#import "HttpResponseDelegate.h"
@class CustomerViewController;

@interface CustomerBehaviorView : UIView

@property (weak, nonatomic) IBOutlet UIView *dsoView;
@property (weak, nonatomic) IBOutlet UIView *agingView;
@property (weak, nonatomic) IBOutlet UIView *dunningConllectionView;
@property (weak, nonatomic) IBOutlet UIView *profitabilityView;


@property (strong, nonatomic) NSArray *dunningConllectionArray;
@property (strong, nonatomic) NSArray *profitabilityArray;
@property (strong, nonatomic) CustomerViewController *viewController;
@property (assign, nonatomic) BOOL isCompare;
@property (assign, nonatomic) BOOL isZooming;
@property (assign, nonatomic) BOOL isLoadingDataCompleted;
@property (strong, nonatomic) NSString *customerId;

- (void)compareReport:(Report *)report withCustomer:(NSMutableArray *)customers;
- (void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig;
- (void)generateReports:(NSString *)customerId;


@end
