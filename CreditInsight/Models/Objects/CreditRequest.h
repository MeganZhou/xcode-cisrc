//
//  CreditRequest.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/31/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface CreditRequest : BaseObject

@property (strong, nonatomic) NSString *customerId;
@property (strong, nonatomic) NSString *customerName;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *priority;
@property (strong, nonatomic) NSString *createdDate;
@property (assign, nonatomic) BOOL processed;

@property (strong, nonatomic) NSString *creditRequestId;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *reason;
@property (strong, nonatomic) NSString *requestAmount;
@property (strong, nonatomic) NSString *approved;
@property (strong, nonatomic) NSString *expectedVolumn;
@property (strong, nonatomic) NSString *creditLimit;
@property (strong, nonatomic) NSString *createOnBy;
@property (strong, nonatomic) NSString *changedOnBy;
@property (strong, nonatomic) NSString *closeOnBy;
@property (strong, nonatomic) NSString *note;
@property (strong, nonatomic) NSString *attachmentId;

+ (CreditRequest *)convertJSON2Object:(NSString *)jsonString;
+ (id)convertJSON2Objects:(NSString *)jsonString;

@end
