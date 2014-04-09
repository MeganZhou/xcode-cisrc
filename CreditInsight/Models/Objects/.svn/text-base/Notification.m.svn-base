//
//  Notification.m
//  CreditInsight
//
//  Created by wang liang on 1/14/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "Notification.h"

@implementation Notification


+(id)convertJSON2Objects:(NSString *)jsonString {
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  BaseObject *baseObject = [[BaseObject alloc] init];
  baseObject.status = [dict objectForKey:@"status"];
  baseObject.message = [dict objectForKey:@"message"];
  if (![baseObject.status isEqualToString:@"success"]) return baseObject;
  
  NSDictionary *data = [dict objectForKey:@"data"];
  NSNumber *blockedOrderNumber = [data objectForKey:@"blockedOrder"];
  Notification *notf1 = [[Notification alloc] init];
  notf1.type = BLOCKED_ORDER;
  notf1.number = [blockedOrderNumber intValue];
  
  NSNumber *creditRequest = [data objectForKey:@"creditCase"];
  Notification *notf2 = [[Notification alloc] init];
  notf2.type = CREDIT_REQUEST;
  notf2.number = [creditRequest intValue];
  
  NSNumber *earlyWarning = [data objectForKey:@"warning"];
  Notification *notf3 = [[Notification alloc] init];
  notf3.type = EARLY_WARNING;
  notf3.number = [earlyWarning intValue];
  
  return [NSArray arrayWithObjects:notf1, notf2, notf3, nil];
  
}

@end
