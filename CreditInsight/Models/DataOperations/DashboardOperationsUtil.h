//
//  DashboardOperationsUtil.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 5/30/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DashboardOperations;
@class Report;

@interface DashboardOperationsUtil : NSObject

@property (strong, nonatomic) DashboardOperations *dashboardOperations;

- (Report *)generateNewReport:(Report *)oldReport withCustomers:(NSArray *)customerArray;

@end
