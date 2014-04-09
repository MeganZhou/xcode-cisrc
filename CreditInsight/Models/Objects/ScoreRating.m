//
//  ScoreRating.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/14/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "ScoreRating.h"

@implementation ScoreRating


+(ScoreRating *)convertJSON2Objects:(NSString *)jsonString {
  NSDictionary *dict = [self  covertJSON2Dict:jsonString];
  ScoreRating *scoreRating = [[ScoreRating alloc] init];
  scoreRating.status = [dict objectForKey:@"status"];
  scoreRating.message = [dict objectForKey:@"message"];
  if (![scoreRating.status isEqualToString:@"success"]) return scoreRating;
  NSDictionary *dataDict = [dict objectForKey:@"data"];
  NSDictionary *externalRatingdict = [dataDict objectForKey:@"scoreRating"];
  scoreRating.updatedTime = [externalRatingdict objectForKey:@"updatedTime"];
  scoreRating.creditScore =  [NSString stringWithFormat:@"%@", [externalRatingdict objectForKey:@"score"]];
  scoreRating.rating = [externalRatingdict objectForKey:@"rating"];
  scoreRating.levels = [externalRatingdict objectForKey:@"levels"];
  return scoreRating;
}


@end
