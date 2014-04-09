//
//  Customer.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/22/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface Customer : BaseObject

@property (strong, nonatomic) NSString *customerId;
@property (strong, nonatomic) NSString *customerNumber;
@property (strong, nonatomic) NSString *customerName;
@property (strong, nonatomic) NSString *businessType;
@property (strong, nonatomic) NSString *industrySector;
@property (strong, nonatomic) NSString *establishmentYear;
@property (strong, nonatomic) NSString *employeeSize;
@property (strong, nonatomic) NSString *registeredCapital;
@property (strong, nonatomic) NSString *contactTitle;
@property (strong, nonatomic) NSString *contactName;
@property (strong, nonatomic) NSString *telephone;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *website;
@property (strong, nonatomic) NSString *address;

+ (Customer *)convertJSON2Object:(NSString *)jsonString;
+ (id)convertJSON2Objects:(NSString *)jsonString;

@end
