//
//  DashboardOperations.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 5/23/13.
//  Copyright (c) 2013 wang ;. All rights reserved.
//

#import "DashboardOperations.h"
#import "AppDelegate.h"
#import "DashboardEntity.h"

@implementation DashboardOperations

- (NSArray *)loadDataFromCsv{
  NSString *path = [[NSBundle mainBundle] pathForResource:@"Dashboards" ofType:@"csv"];
  NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  NSMutableArray *linesArray = [NSMutableArray arrayWithArray:[data componentsSeparatedByString:@"\n"]];
  [linesArray removeObjectAtIndex:0];
  NSArray *dataArray = [NSArray arrayWithArray:linesArray];
  
  return dataArray;
}

- (void)initDashboardEntity {
  NSArray *dataArray = [self loadDataFromCsv];
  for (NSString *item in dataArray) {
    NSArray *data = [item componentsSeparatedByString:@","];
    [self insertIntoDashboardEntity:data];
  }
}

// Convert csv data to object and persistent it to database.
- (void)insertIntoDashboardEntity:(NSArray *)data {
  if ([data count] >= 30) {
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"DashboardEntity" inManagedObjectContext:[self context]];
    
    NSString *year = [data objectAtIndex:7];
    NSString *month = [data objectAtIndex:8];
    NSDate *timeline = [self convertDateWithYear:year andMonth:month];
    
    // Common columns
    [newManagedObject setValue:[data objectAtIndex:0] forKey:@"country"];
    [newManagedObject setValue:[data objectAtIndex:1] forKey:@"region"];
    [newManagedObject setValue:[data objectAtIndex:2] forKey:@"industry"];
    [newManagedObject setValue:[data objectAtIndex:3] forKey:@"customerGroup"];
    [newManagedObject setValue:[data objectAtIndex:4] forKey:@"area"];
    [newManagedObject setValue:[data objectAtIndex:5] forKey:@"company"];
    [newManagedObject setValue:[data objectAtIndex:6] forKey:@"customer"];    
    [newManagedObject setValue:timeline forKey:@"timeline"];    
    [newManagedObject setValue:[data objectAtIndex:9] forKey:@"currency"];
    
    // Credit Limit Utilization
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:10]] forKey:@"openCredit"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:11]] forKey:@"openOrder"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:12]] forKey:@"openDelivery"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:13]] forKey:@"openBilling"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:14]] forKey:@"openItem"];    
    
    // DSO
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:15]] forKey:@"dso"];
    
    // BadDebts
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:16]] forKey:@"badDebts"];
    
    // Aging of Accounts Receivable
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:17]] forKey:@"firstMonth"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:18]] forKey:@"secondMonth"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:19]] forKey:@"thirdMonth"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:20]] forKey:@"secondQuarter"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:21]] forKey:@"secondHalfYear"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:22]] forKey:@"oneYearMore"];
    
    // Sales Volume
    [newManagedObject setValue:[data objectAtIndex:23] forKey:@"product"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:24]] forKey:@"quantity"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:25]] forKey:@"revenue"];
    
    // Profitability
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:26]] forKey:@"totalRevenue"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:27]] forKey:@"costOfRevenue"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:28]] forKey:@"grossProfit"];
    [newManagedObject setValue:[[NSDecimalNumber alloc] initWithString:[data objectAtIndex:29]] forKey:@"grossProfitOrTotalRevenue"];    
  }
  
  [self save:@"DashboardEntity"];
}

- (NSDate *)convertDateWithYear:(NSString *)year andMonth:(NSString *)month {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-01"];
  [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  NSString *stringDate = [NSString stringWithFormat:@"%@-%@-01", year, month];
  NSDate *date = [dateFormatter dateFromString:stringDate];
  
  return date;
}

- (void)initCategoryEntity {
  NSArray *data = [NSArray arrayWithObjects:@"area", @"company", @"customer", nil];
  [self insertIntoCategoryEntity:data];
}

- (void)insertIntoCategoryEntity:(NSArray *)array {
  for (NSString *data in array) {
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"CategoryEntity" inManagedObjectContext:[self context]];
    [newManagedObject setValue:data forKey:@"categoryName"];
  }
  
  [self save:@"CategoryEntity"];
}

- (void)save:(NSString *)entityName {
  NSError *error = nil;
  if (![[self context] save:&error]) {
    NSLog(@"Insert data in [%@] error %@, %@", entityName, error, [error userInfo]);
  }
}

- (NSManagedObjectContext *)context{
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSManagedObjectContext *context = appDelegate.managedObjectContext;
  
  return context;
}

// Use original sql to query some columns.
- (void)openDatabase {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documents = [paths objectAtIndex:0];
  NSString *dbPath = [documents stringByAppendingPathComponent:@"CreditInsight.sqlite"];
  
  if (sqlite3_open([dbPath UTF8String], &_database) != SQLITE_OK) {
    [self closeDatabase];
    NSLog(@"Open database failure.");
  } else {
    NSLog(@"Open database OK.");
  }
}

- (void)closeDatabase {
  sqlite3_close(_database);
}

- (NSArray *)queryAllArea {
   NSString *queryAllArea = @"SELECT DISTINCT ZAREA FROM ZDASHBOARDENTITY";  

  return [self excuteQuery:queryAllArea];
}

- (NSArray *)queryCompanyByArea:(NSArray *)areaArray {  
  NSString *queryCompanyByArea = @"SELECT DISTINCT ZCOMPANY FROM ZDASHBOARDENTITY";  
  queryCompanyByArea = [self querySQL:queryCompanyByArea byArea:areaArray];
    
  return [self excuteQuery:queryCompanyByArea];
}

- (NSArray *)queryCustomerByCompanyOrArea:(NSArray *)dataArray column:(NSString *)column {
  NSString *queryCustomerByAreaAndCompany = @"SELECT DISTINCT ZCUSTOMER FROM ZDASHBOARDENTITY";  
  queryCustomerByAreaAndCompany = [self querySQL:queryCustomerByAreaAndCompany byCompanyOrArea:dataArray column:column];
  
  return [self excuteQuery:queryCustomerByAreaAndCompany];
}

- (NSString *)querySQL:(NSString *)querySQL byArea:(NSArray *)areaArray {
  for (NSString *area in areaArray) {
    if ([areaArray indexOfObject:area] == 0) {
      querySQL = [querySQL stringByAppendingFormat:@" WHERE ZAREA = '%@'", area];
    } else {
      querySQL = [querySQL stringByAppendingFormat:@" OR ZAREA = '%@'", area];
    }
  }
  
  return querySQL;
}

- (NSString *)querySQL:(NSString *)querySQL byCompanyOrArea:(NSArray *)dataArray column:(NSString *)column {
  for (NSString *company in dataArray) {
    if ([dataArray indexOfObject:company] == 0) {
        querySQL = [querySQL stringByAppendingFormat:@" WHERE %@ = '%@'", column, company];
    } else {
      querySQL = [querySQL stringByAppendingFormat:@" OR %@ = '%@'", column, company];
    }
  }
  
  return querySQL;
}

- (NSArray *)excuteQuery:(NSString *)querySQL {
  [self openDatabase];
  NSMutableArray *resultArray = [NSMutableArray array];
  sqlite3_stmt *statement;
  if (sqlite3_prepare_v2(_database, [querySQL UTF8String], -1, &statement, nil) == SQLITE_OK) {
    while (sqlite3_step(statement) == SQLITE_ROW) {
      char *objectChar = (char *)sqlite3_column_text(statement, 0);
      if (objectChar != nil) {
        NSString *object = [[NSString alloc] initWithUTF8String:objectChar];
        [resultArray addObject:object];
      }
    }
  }
  
  [self closeDatabase];
  
//  NSLog(@"After query resultArray is == %@", resultArray);
  return [NSArray arrayWithArray:resultArray];
}

// Query DashboardEntity by customer.
- (NSArray *)fetchDashboardEntityByCustomer:(NSString *)customerName {
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:[self dashboardEntity]];
  
  NSPredicate *predicate = nil;
  
  predicate = [NSPredicate predicateWithFormat:@" customer = %@", customerName];
  [request setPredicate:predicate];
  
  NSError *error = nil;
  NSArray *fetchResultArray = [[self context] executeFetchRequest:request error:&error];
  
  if (fetchResultArray == nil) {
    NSLog(@"Error: %@,%@",error,[error userInfo]);
  }  
  
  return [NSArray arrayWithArray:fetchResultArray];
}

- (NSEntityDescription *)dashboardEntity {
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"DashboardEntity" inManagedObjectContext:[self context]];
  return entity;
}

- (void)resetDatabase {
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:[self dashboardEntity]];
  
  NSError *error = nil;
  NSArray *fetchResultArray = [[self context] executeFetchRequest:request error:&error];
  
  if (fetchResultArray == nil) {
    NSLog(@"Error: %@,%@",error,[error userInfo]);
  } else {
    for (DashboardEntity *dashboard in fetchResultArray) {
      [[self context] deleteObject:dashboard];
    }
  }

  if (![[self context] save:&error]) {
    NSLog(@"When delete data in dashboard error: error: %@, [error userInfo]: %@", error, [error userInfo]);
  }
}

@end
