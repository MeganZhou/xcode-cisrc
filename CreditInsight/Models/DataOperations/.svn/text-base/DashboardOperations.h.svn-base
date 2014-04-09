//
//  DashboardOperations.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 5/23/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DashboardOperations : NSObject {
  sqlite3 *_database;
}

- (void)resetDatabase;

- (void)initDashboardEntity;
//- (void)initCategoryEntity;

- (NSArray *)queryAllArea;
- (NSArray *)queryCompanyByArea:(NSArray *)areaArray;
- (NSArray *)queryCustomerByCompanyOrArea:(NSArray *)dataArray column:(NSString *)column;

- (NSArray *)fetchDashboardEntityByCustomer:(NSString *)customerName;

@end
