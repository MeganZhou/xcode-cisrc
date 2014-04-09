//
//  NSString+Formatter.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/8/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "NSString+Formatter.h"

@implementation NSString(Formatter)

// Format: $ 120,399
- (NSString *)stringCurrencyFormat {
  NSString *newStr = @"";
  if (self.length > 0) {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"#,###,###"];
    NSNumber *number =[NSNumber numberWithInt:[self intValue]];
    newStr =  [formatter stringForObjectValue:number];
    newStr = [NSString stringWithFormat:@"%@ %@",@"$",newStr];
  }
  return newStr;
}

// Format: Jan. 3rd, 2013 
- (NSString *)stringDateFormat {
  NSString *newStr = @"";
  if (self.length > 0) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self];
    [dateFormatter setDateFormat:@"LLL. d, yyyy"];
    newStr = [dateFormatter stringFromDate:date];
  }
  return newStr;
}

- (NSString *)stringWithCommaSeparate {
  NSString *newStr = @"";
  if (self.length > 0) {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    newStr =[formatter stringFromNumber:[NSNumber numberWithInt:[self intValue]]];
    newStr = [NSString stringWithFormat:@"%@",newStr];
  }
  return newStr;

}


@end
