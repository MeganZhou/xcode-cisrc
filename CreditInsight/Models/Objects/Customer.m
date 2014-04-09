//
//  Customer.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/22/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "Customer.h"

@implementation Customer

+ (Customer *)convertJSON2Object:(NSString *)jsonString {
  NSDictionary *dict = [self covertJSON2Dict:jsonString];  
  Customer *customer = [[Customer alloc] init];
  customer.status = [dict objectForKey:@"status"];
  customer.message = [dict objectForKey:@"message"];
  if (![customer.status isEqualToString:@"success"]) return customer;
  
  NSDictionary *dataDict = [dict objectForKey:@"data"];
  customer.customerId = [dataDict objectForKey:@"id"];
  customer.customerNumber = [dataDict objectForKey:@"customerNumber"];
  customer.customerName = [dataDict objectForKey:@"customerName"];
  customer.businessType = [dataDict objectForKey:@"businessType"];
  customer.industrySector = [dataDict objectForKey:@"industrySector"];
  customer.establishmentYear = [dataDict objectForKey:@"establishmentYear"]; ;
  customer.employeeSize =  [dataDict objectForKey:@"employeeSize"];
  customer.registeredCapital = [dataDict objectForKey:@"registerdCapital"];
  customer.contactTitle = [dataDict objectForKey:@"contactTitle"];
  customer.contactName = [dataDict objectForKey:@"contactname"];
  customer.telephone = [dataDict objectForKey:@"telephone"];
  customer.email = [dataDict objectForKey:@"email"];
  customer.website = [dataDict objectForKey:@"website"];
  customer.address = [dataDict objectForKey:@"address"];
  return customer;
}

+ (id)convertJSON2Objects:(NSString *)jsonString {
  NSMutableArray *customers = [[NSMutableArray alloc] init];
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  
  BaseObject *baseObject = [[BaseObject alloc] init];
  baseObject.status = [dict objectForKey:@"status"];
  baseObject.message = [dict objectForKey:@"message"];
  if (![baseObject.status isEqualToString:@"success"]) return baseObject;
  
  NSArray *customerArray = [dict objectForKey:@"data"];
  for (int i = 0; i < customerArray.count; i++) {
    NSDictionary *customerDict = [customerArray objectAtIndex:i];
    Customer *customer = [[Customer alloc] init];
    customer.customerId = [NSString stringWithFormat:@"%d", [[customerDict objectForKey:@"customerId"] integerValue]];
    customer.customerNumber = [customerDict objectForKey:@"customerNumber"];
    customer.customerName = [customerDict objectForKey:@"name"];
    [customers addObject:customer];
  }
  return customers;
}




@end
