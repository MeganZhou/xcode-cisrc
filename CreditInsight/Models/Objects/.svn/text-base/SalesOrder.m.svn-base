//
//  SalesOrder.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/23/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "SalesOrder.h"

@implementation SalesOrder

+ (id)convertJSON2Objects:(NSString *)jsonString {
  NSMutableArray *salesOrderArray = [[NSMutableArray alloc] init];
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  BaseObject *baseObject = [[BaseObject alloc] init];
  baseObject.status = [dict objectForKey:@"status"];
  baseObject.message = [dict objectForKey:@"message"];
  if (![baseObject.status isEqualToString:@"success"]) return baseObject;
  
  NSArray  *dataArray = [[dict objectForKey:@"data"] objectForKey:@"blockedOrder"];
  for (int i = 0; i < dataArray.count; i++) {
    NSDictionary *tempDict = [dataArray objectAtIndex:i];
    NSString *orderId = [[tempDict allKeys] objectAtIndex:0];
    NSDictionary *salesOrderDict = [tempDict objectForKey:orderId];
    SalesOrder *salesOrder = [[SalesOrder alloc] init];
    salesOrder.orderId = orderId;
    salesOrder.orderNumber = [salesOrderDict objectForKey:@"orderNumber"];
    salesOrder.orderAmount = [salesOrderDict objectForKey:@"orderAmount"];
    salesOrder.date = [salesOrderDict objectForKey:@"date"];
    [salesOrderArray addObject:salesOrder];
  }
  
  return salesOrderArray;
}

+ (SalesOrder *)convertJSON2Object:(NSString *)jsonString {
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  NSDictionary *salesOrderDict = [dict objectForKey:@"data"];
  SalesOrder *salesOrder = [[SalesOrder alloc] init];
  salesOrder.status = [dict objectForKey:@"status"];
  salesOrder.message = [dict objectForKey:@"message"];
  if (![salesOrder.status isEqualToString:@"success"]) return salesOrder;
  
  salesOrder.customerName = [salesOrderDict objectForKey:@"customerName"];
  salesOrder.customerId = [salesOrderDict objectForKey:@"customerId"];
  salesOrder.orderDetails = [salesOrderDict objectForKey:@"orderItems"];
  salesOrder.status = [salesOrderDict objectForKey:@"status"];
  salesOrder.orderAmount = [salesOrderDict objectForKey:@"orderAmount"];
  salesOrder.sales = [salesOrderDict objectForKey:@"sales"];
  salesOrder.orderNumber = [salesOrderDict objectForKey:@"orderNumber"];
  salesOrder.createdDate = [salesOrderDict objectForKey:@"createdDate"];
  salesOrder.orderId = [salesOrderDict objectForKey:@"orderId"];

  return salesOrder;

}



@end
