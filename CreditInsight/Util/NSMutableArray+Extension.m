//
//  NSMutableArray+Extension.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 5/28/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import "Series.h"

@implementation NSMutableArray (Extension)

- (BOOL)isContainObject:(Series *)series {
  for (Series *seriesObject in self) {
    if ([seriesObject.seriesName isEqualToString:series.seriesName]) {
      return YES;
    } 
  }
  
  return NO;
}

@end
