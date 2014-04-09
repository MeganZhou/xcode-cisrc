//
//  CreditEvents.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/22/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface CreditEvents : BaseObject

@property (strong, nonatomic) NSString *updateTime;
@property (strong, nonatomic) NSString *latestExternalReports;
@property (strong, nonatomic) NSString *legalEvents;
@property (strong, nonatomic) NSString *mediaRecords;

+(CreditEvents *)convertJSON2Objects:(NSString *)jsonString;

@end
