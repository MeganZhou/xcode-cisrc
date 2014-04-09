//
//  NSString+Validation.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 2/27/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString(Validation)


- (BOOL)isStringOnlyContainNumber {
  NSPredicate *predicate = nil;
  BOOL isMatch = NO;
  predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '[0-9]*'"];
  isMatch = [predicate evaluateWithObject:self];
  
  return isMatch;
}



@end
