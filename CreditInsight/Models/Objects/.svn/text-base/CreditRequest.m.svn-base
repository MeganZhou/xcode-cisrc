//
//  CreditRequest.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/31/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "CreditRequest.h"

@implementation CreditRequest

+ (id)convertJSON2Objects:(NSString *)jsonString {
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  BaseObject *baseObject = [[BaseObject alloc] init];
  baseObject.status = [dict objectForKey:@"status"];
  baseObject.message = [dict objectForKey:@"message"];
  if (![baseObject.status isEqualToString:@"success"]) return baseObject;
  
  NSArray  *dataArray = [[dict objectForKey:@"data"] objectForKey:@"creditCase"];
  NSMutableArray *creditRequests = [[NSMutableArray alloc] init];
  for (int i = 0; i < dataArray.count; i++) {
    NSDictionary *tempDict = [dataArray objectAtIndex:i];
    NSString *creditRequestId = [[tempDict allKeys] objectAtIndex:0];
    NSDictionary *creditRequestDict = [tempDict objectForKey:creditRequestId];
    CreditRequest *creditRequest = [[CreditRequest alloc] init];
    creditRequest.creditRequestId = creditRequestId;
    creditRequest.customerName = [creditRequestDict objectForKey:@"customerName"];
    creditRequest.status = [creditRequestDict objectForKey:@"status"];
    creditRequest.priority = [creditRequestDict objectForKey:@"priority"];
    creditRequest.createdDate = [creditRequestDict objectForKey:@"createdDate"];
    creditRequest.processed = [[creditRequestDict objectForKey:@"processed"] boolValue];
    [creditRequests addObject:creditRequest];
  }

  return creditRequests;
}

+ (CreditRequest *)convertJSON2Object:(NSString *)jsonString {
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  CreditRequest *creditRequest = [[CreditRequest alloc] init];
  creditRequest.status = [dict objectForKey:@"status"];
  creditRequest.message = [dict objectForKey:@"message"];
  if (![creditRequest.status isEqualToString:@"success"]) return creditRequest;
  
  NSDictionary *creditRequestDict = [dict objectForKey:@"data"];
  creditRequest.creditRequestId = [creditRequestDict objectForKey:@"id"];
  creditRequest.customerId = [creditRequestDict objectForKey:@"customerId"];
  creditRequest.customerName = [creditRequestDict objectForKey:@"customerName"];
  NSDictionary *generalInformationDict = [creditRequestDict objectForKey:@"generalInformation"];
  creditRequest.description = [generalInformationDict objectForKey:@"description"];
  creditRequest.priority = [generalInformationDict objectForKey:@"priority"];
  creditRequest.status = [generalInformationDict objectForKey:@"status"];
  creditRequest.reason = [generalInformationDict objectForKey:@"reason"];
  NSDictionary *amountDict =[creditRequestDict objectForKey:@"amount"];
  creditRequest.requestAmount = [NSString stringWithFormat:@"%@", [amountDict objectForKey:@"requestAmount"]];
  creditRequest.approved =  [NSString stringWithFormat:@"%@",[amountDict objectForKey:@"approved"]];
  creditRequest.expectedVolumn =  [NSString stringWithFormat:@"%@",[amountDict objectForKey:@"expectedVolumn"]];
  creditRequest.creditLimit =  [NSString stringWithFormat:@"%@",[amountDict objectForKey:@"creditLimit"]];
  NSDictionary *administrativeDict = [creditRequestDict objectForKey:@"administrative"];
  creditRequest.createOnBy = [administrativeDict objectForKey:@"createOnBy"];
  creditRequest.changedOnBy = [administrativeDict objectForKey:@"changedOnBy"];
  creditRequest.closeOnBy = [administrativeDict objectForKey:@"closeOnBy"];
  creditRequest.note = [creditRequestDict objectForKey:@"note"];
  creditRequest.attachmentId = [creditRequestDict objectForKey:@"attachmentId"];
  
  return creditRequest;
}
@end
