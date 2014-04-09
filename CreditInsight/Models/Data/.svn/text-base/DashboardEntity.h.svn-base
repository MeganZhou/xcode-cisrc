//
//  DashboardEntity.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 5/23/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DashboardEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * dashboardId;

// Common columns
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * industry;
@property (nonatomic, retain) NSString * customerGroup;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * customer;
@property (nonatomic, retain) NSDate * timeline;
@property (nonatomic, retain) NSString * currency;

// Credit Limit Utilization
@property (nonatomic, retain) NSDecimalNumber * openCredit;
@property (nonatomic, retain) NSDecimalNumber * openOrder;
@property (nonatomic, retain) NSDecimalNumber * openDelivery;
@property (nonatomic, retain) NSDecimalNumber * openBilling;
@property (nonatomic, retain) NSDecimalNumber * openItem;

// DSO
@property (nonatomic, retain) NSDecimalNumber * dso;

// BadDebts
@property (nonatomic, retain) NSDecimalNumber * badDebts;

// Aging of Accounts Receivable
@property (nonatomic, retain) NSDecimalNumber * firstMonth;
@property (nonatomic, retain) NSDecimalNumber * secondMonth;
@property (nonatomic, retain) NSDecimalNumber * thirdMonth;
@property (nonatomic, retain) NSDecimalNumber * secondQuarter;
@property (nonatomic, retain) NSDecimalNumber * secondHalfYear;
@property (nonatomic, retain) NSDecimalNumber * oneYearMore;

// Sales Volume
@property (nonatomic, retain) NSString * product;
@property (nonatomic, retain) NSDecimalNumber * quantity;
@property (nonatomic, retain) NSDecimalNumber * revenue;

// Profitability
@property (nonatomic, retain) NSDecimalNumber * totalRevenue;
@property (nonatomic, retain) NSDecimalNumber * costOfRevenue;
@property (nonatomic, retain) NSDecimalNumber * grossProfit;
@property (nonatomic, retain) NSDecimalNumber * grossProfitOrTotalRevenue;

@end
