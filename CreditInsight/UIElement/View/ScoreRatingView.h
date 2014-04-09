//
//  ScoreRatingView.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/15/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreRating.h"


@interface ScoreRatingView : UIView

@property (strong, nonatomic) ScoreRating *scoreRating;
@property (weak, nonatomic) IBOutlet UILabel *lblCreditScore;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UILabel *lblUpdateDate;
@property (weak, nonatomic) IBOutlet UILabel *lblLowestRating;
@property (weak, nonatomic) IBOutlet UILabel *lblHighestRating;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblScoreRating;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblRatingTitle;

@end
