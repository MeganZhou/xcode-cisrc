//
//  Category.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 2/1/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "Category.h"

#define kCategoryName (@"categoryName")
#define kSeriesArray (@"seriesArray")

@implementation Category

- (id)copyWithZone:(NSZone *)zone {
  id copy = [[[self class] alloc] init];
  if (copy) {
    [copy setCategoryName:self.categoryName];
    [copy setSeriesArray:[[[NSMutableArray alloc] initWithArray:self.seriesArray copyItems:YES] copyWithZone:zone]];
  }  
  
  return copy;
}

@end
