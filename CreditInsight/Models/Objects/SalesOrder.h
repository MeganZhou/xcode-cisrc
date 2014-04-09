//
//  SalesOrder.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/23/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface SalesOrder : BaseObject

@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSString *orderNumber;
@property (strong, nonatomic) NSString *orderAmount;
@property (strong, nonatomic) NSString *customerId;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *customerName;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *sales;
@property (strong, nonatomic) NSArray  *orderDetails;
@property (strong, nonatomic) NSString *createdDate;

+ (SalesOrder *)convertJSON2Object:(NSString *)jsonString;
+ (id)convertJSON2Objects:(NSString *)jsonString;

@end
