//
//  BaseObject.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 3/4/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

+ (NSDictionary *)covertJSON2Dict:(NSString *)jsonString {
  NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSError *error = nil;
  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
  return dict;
}

  
@end
