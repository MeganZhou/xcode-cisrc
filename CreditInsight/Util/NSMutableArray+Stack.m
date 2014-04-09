//
//  NSMutableArray+Stack.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 2/19/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

- (void)push:(id)object {
  [self addObject:object];
}

- (id)pop {
  if ([self count] == 0) {
    return nil;
  } else {
    id object = [self lastObject];
    [self removeLastObject];
    
    return object;
  }
}

@end
