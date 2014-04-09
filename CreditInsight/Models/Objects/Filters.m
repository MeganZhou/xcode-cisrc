//
//  Filters.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/29/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "Filters.h"
#import "RequestConfig.h"
#import "Series.h"
#import "Category.h"

@implementation Filters

+ (id)convertJSON2Objects:(NSString *)jsonString  {
//  NSDictionary *dict = [self covertJSON2Dict:jsonString];
//  BaseObject *baseObject = [[BaseObject alloc] init];
//  baseObject.status = [dict objectForKey:@"status"];
//  baseObject.message = [dict objectForKey:@"message"];
//  if (![baseObject.status isEqualToString:@"success"]) return baseObject;
//  
//  NSMutableArray *dataArray = [NSMutableArray array];
//  NSDictionary *data = [dict objectForKey:@"data"];
//  NSDictionary *filters = [data objectForKey:@"filters"];
//  
//  for (NSString *categoryName in [filters allKeys]) {
//    NSArray *seriesArray = [filters objectForKey:categoryName];
//    
//    Category *category = [[Category alloc] init];
//    category.categoryName = categoryName;
//    category.seriesArray = [NSMutableArray arrayWithCapacity:1];
//    for (NSDictionary *seriesDict in seriesArray) {
//      Series *series = [[Series alloc] init];
//      series.seriesId = [seriesDict objectForKey:@"id"];
//      series.seriesName = [seriesDict objectForKey:@"name"];
//      [category.seriesArray addObject:series];
//    }
//    
//    [dataArray addObject:category];
//  }
  
  
  NSMutableArray *dataArray = [NSMutableArray array];
  NSArray *categoryNameArray = [NSArray arrayWithObjects:NSLocalizedString(@"Credit Control Area", nil), NSLocalizedString(@"Company Code", nil), NSLocalizedString(@"Customer", nil), NSLocalizedString(@"Timeline", nil), nil];
  for (NSString *categoryName in categoryNameArray) {
    Category *category = [[Category alloc] init];
    category.categoryName = categoryName;
    category.seriesArray = [NSMutableArray arrayWithCapacity:1];
    
    Series *series = [[Series alloc] init];
    series.seriesId = @"";
    series.seriesName = @"ALL";
    [category.seriesArray addObject:series];   
      
    [dataArray addObject:category];
  }  

  return dataArray;
}

@end
