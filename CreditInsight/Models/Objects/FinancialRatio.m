//
//  FinancialRatio.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/15/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "FinancialRatio.h"
#import "RequestConfig.h"

@implementation FinancialRatio

BOOL isCompare = NO;

+ (NSArray *)convertJSON2Objects:(NSString *)jsonString {
  NSMutableArray *array = [[NSMutableArray alloc] init];
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  NSDictionary  *dataDict = [dict objectForKey:@"data"];
  NSMutableDictionary *finacialRatioDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"finacialRatio"]];
  if ([self newDictToAdd] != nil) {
    [finacialRatioDict addEntriesFromDictionary:[self newDictToAdd]];
  }
  NSArray *timesArray = [finacialRatioDict objectForKey:@"times"];
  NSMutableArray *keys = [NSMutableArray arrayWithArray:[finacialRatioDict allKeys]];
  if ([keys containsObject:@"times"]) {
    [keys removeObject:@"times"];
  }
  for (int i = 0; i < timesArray.count; i++) {
    NSMutableArray *categoryArray = [NSMutableArray array];
    for (NSString *key in keys) {
      if (![key isEqualToString:@"updatedTime"]) {
        NSArray *yValueArray = [finacialRatioDict objectForKey:key];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [timesArray objectAtIndex:i],@"CategoryColumn",
                              key, @"SeriesColumn",
                              [NSNumber numberWithFloat:[[yValueArray objectAtIndex:i] floatValue]], @"ValueColumn",
                              nil];
        [categoryArray addObject: dict];
      }
    }
    
    [array addObject:categoryArray];
  }

  return array;
}

+ (id)convertJSON2Dictionary:(NSString *)jsonString {
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  BaseObject *baseObject = [[BaseObject alloc] init];
  baseObject.status = [dict objectForKey:@"status"];
  baseObject.message = [dict objectForKey:@"message"];
  if (![baseObject.status isEqualToString:@"success"]) return baseObject;
  
  NSDictionary  *finacialRatioDict = [[dict objectForKey:@"data"] objectForKey:@"finacialRatio"];
  NSString *updatedTime = [finacialRatioDict objectForKey:@"updatedTime"];
  NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      updatedTime, @"updatedTime",
                                      [self convertJSON2Objects:jsonString], @"chartArray",
                                      nil];

  return resultDict;
}

+ (NSString *)jsonString {

  
  return nil;
}

+ (NSArray *)compareCustomers:(NSMutableArray *)customerIds {
  isCompare = YES;
  return [self convertJSON2Objects:[self jsonString]];
}

+ (NSDictionary *)newDictToAdd {
  NSDictionary *newDict = nil;
  if (isCompare) {
    newDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"2.50", @"8.00", @"7.00", @"5.20", @"4.00", @"2.50", @"8.00", @"7.00", @"5.20", @"4.00", @"5.20", @"4.00", nil ], @"IBM", nil];
  }
  return newDict;
}

@end
