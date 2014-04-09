//
//  ExternalRating.m
//  CreditInsight
//
//  Created by wang liang on 1/11/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "ExternalRating.h"

@implementation ExternalRating

+ (id)convertJSON2Objects:(NSString *)jsonString
{
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  BaseObject *baseObject = [[BaseObject alloc] init];
  baseObject.status = [dict objectForKey:@"status"];
  baseObject.message = [dict objectForKey:@"message"];
  if (![baseObject.status isEqualToString:@"success"]) return baseObject;
  
  NSMutableArray *extenalArray = [[NSMutableArray alloc] init];
  NSDictionary  *dataDict = [dict objectForKey:@"data"];
  NSArray *array = [dataDict objectForKey:@"externalRating"];
  for (int i = 0; i < array.count; i++) {
    NSDictionary *externalDict = [array objectAtIndex:i];
    ExternalRating *externalRating = [[ExternalRating alloc] init];
    externalRating.org = [externalDict objectForKey:@"name"];
    externalRating.rating = [externalDict objectForKey:@"grade"];
    externalRating.updatedDate = [externalDict objectForKey:@"updatedTime"];
    externalRating.levels = [externalDict objectForKey:@"levels"];
    [extenalArray addObject:externalRating];
  }
  return extenalArray;
}


@end
