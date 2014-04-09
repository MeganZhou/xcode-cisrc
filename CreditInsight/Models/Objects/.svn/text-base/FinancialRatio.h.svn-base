//
//  FinancialRatio.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/15/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface FinancialRatio : BaseObject

@property (strong, nonatomic) NSString *times;
@property (nonatomic) float liquidity;
@property (nonatomic) float growth;
@property (nonatomic) float profitablity;
@property (nonatomic) float solvency;
@property (nonatomic) float activity;

+ (id)convertJSON2Dictionary:(NSString *)jsonString;
+ (NSArray *)compareCustomers:(NSMutableArray *)customerIds;

@end
