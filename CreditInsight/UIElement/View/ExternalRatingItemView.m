//
//  ExternalRatingItemView.m
//  CreditInsight
//
//  Created by wang liang on 1/10/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "ExternalRatingItemView.h"
#import "NSString+Formatter.h"

@implementation ExternalRatingItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ExternalRatingItemView" owner:self options:nil];
        if (nibs) {
            self = [nibs objectAtIndex:0];
            self.frame = frame;
            self.rating = 0.0;
        }
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.currentScoreView.frame = CGRectMake(self.scoreColorsView.frame.origin.x + self.scoreColorsView.frame.size.width * self.rating - self.currentScoreView.frame.size.width, self.currentScoreView.frame.origin.y, self.currentScoreView.frame.size.width, self.currentScoreView.frame.size.height);
}

- (void)updateRatingItemView:(ExternalRating *)extRating {
    NSInteger ratingIndex =[self findRatingIndex:extRating];
    self.rating = (1.0 / extRating.levels.count) * (ratingIndex + 0.7);
    self.ratingOrgLabel.text = extRating.org;
    self.ratingLabel.text = extRating.rating;
    self.updatedDateLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Updated", nil),
                                  [extRating.updatedDate stringDateFormat]];
}

- (NSInteger)findRatingIndex:(ExternalRating *)extRating {
  NSInteger index = 0;
  for (int i = 0 ; i < extRating.levels.count; i++) {
    if ([[extRating.levels objectAtIndex:i] isEqualToString:extRating.rating]) {
      index = i;
    }
  }
  return index;
}


@end
