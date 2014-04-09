//
//  ScoreRatingView.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/15/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "ScoreRatingView.h"
#import "NSString+Formatter.h"
#import "QuartzCore/QuartzCore.h"

@implementation ScoreRatingView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ScoreRatingView" owner:self options:nil];
    if (nibs) {
      self = [nibs objectAtIndex:0];
      self.frame = frame;
    }
  }
    return self;
}


- (void)drawRect:(CGRect)rect {
  _indicatorImageView.layer.anchorPoint = CGPointMake(0.5, 1.0);
  _indicatorImageView.layer.position = CGPointMake(_indicatorImageView.layer.position.x, _indicatorImageView.layer.position.y + _indicatorImageView.layer.bounds.size.height / 2);
  [_indicatorImageView setTransform:CGAffineTransformMakeRotation(M_PI * [self getRealRating])];
  
  self.lblCreditScore.text = [NSString stringWithFormat:@"%@",_scoreRating.creditScore];
  self.lblRating.text = _scoreRating.rating;
  self.lblUpdateDate.text  = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Updated", nil),
                              [ _scoreRating.updatedTime stringDateFormat]];
  self.lblLowestRating.text = [_scoreRating.levels objectAtIndex:0];
  self.lblHighestRating.text = [_scoreRating.levels objectAtIndex:(_scoreRating.levels.count - 1)];
  self.lblScoreRating.text = NSLocalizedString(@"ScoreRating", nil);
  self.lblScore.text = NSLocalizedString(@"Score", nil);
  self.lblRatingTitle.text = NSLocalizedString(@"Rating", nil);
}


// Rating -0.4 ~ 0.4
- (float)getRealRating {
  float rating = 0.0;
  int count = _scoreRating.levels.count;
    for (int i = 0; i < count ; i++) {
      if ([[_scoreRating.levels objectAtIndex:i] isEqualToString:_scoreRating.rating]) {
          if (i < count / 2 ) {
             rating = -1 * (0.8 / count) * (count / 2 - i);
          } else {
             rating = (0.8 / count) * (i - count / 2);
          }
      }
    }
  return rating;
}


@end
