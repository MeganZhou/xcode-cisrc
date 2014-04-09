//
//  Report.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/28/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface Report : BaseObject <NSCopying>

@property (retain, nonatomic) NSString *reportId;
@property (retain, nonatomic) NSString *reportName;
@property (retain, nonatomic) NSArray *xValuesArray;
@property (copy, nonatomic) NSMutableArray *yValuesArrayes;
@property (copy, nonatomic) NSMutableArray *ySeriesArray;
@property (retain, nonatomic) NSString *reportTypeKey;
@property (retain, nonatomic) NSMutableArray *reportArray; // My Favorite Category has one or more reports.
@property (retain, nonatomic) NSString *xName;
@property (retain, nonatomic) NSString *yName;
@property (retain, nonatomic) NSString *yUnit;
@property (retain, nonatomic) NSString *xUnit;

+ (id)convertJSON2Objects:(NSString *)jsonString;
+ (Report *)generateReport:(NSString *)reportName andCategoryReports:(NSDictionary *)categoryReports;
+ (NSArray *)dataArray:(NSArray *)xValueArray yValueArray:(NSArray *)yValueArray ySeriariesArray:(NSArray *)ySeriariesArray;

@end

@interface ReportsCategory : NSObject

@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSMutableArray *reportArray;

@end
