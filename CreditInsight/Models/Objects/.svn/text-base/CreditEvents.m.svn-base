//
//  CreditEvents.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/22/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "CreditEvents.h"

@implementation CreditEvents

+(CreditEvents *)convertJSON2Objects:(NSString *)jsonString {
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  CreditEvents *creditEvents = [[CreditEvents alloc] init];
  creditEvents.status = [dict objectForKey:@"status"];
  creditEvents.message = [dict objectForKey:@"message"];
  if (![creditEvents.status isEqualToString:@"success"]) return creditEvents;
  
  NSDictionary *dataDict = [dict objectForKey:@"data"];
  NSDictionary *creditEventsDict = [dataDict objectForKey:@"creditEvents"];
  creditEvents.updateTime = [creditEventsDict objectForKey:@"updatedTime"];
  creditEvents.latestExternalReports = [NSString stringWithFormat:@"%@", [creditEventsDict objectForKey:@"latestExternalReports"]];
  creditEvents.legalEvents = [NSString stringWithFormat:@"%@", [creditEventsDict objectForKey:@"legalEvents"]];
  creditEvents.mediaRecords = [NSString stringWithFormat:@"%@", [creditEventsDict objectForKey:@"mediaRecords"]];
  creditEvents.status = [dict objectForKey:@"status"];
  creditEvents.message = [dict objectForKey:@"message"];
  return creditEvents;
}



@end
