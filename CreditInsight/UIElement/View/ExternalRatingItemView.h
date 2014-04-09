//
//  ExternalRatingItemView.h
//  CreditInsight
//
//  Created by wang liang on 1/10/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExternalRating.h"

#define ExternalRatingItemViewHeight 39
#define ExternalRatingItemViewWidth 382

@interface ExternalRatingItemView : UIView

@property (weak, nonatomic) IBOutlet UILabel *ratingOrgLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *scoreColorsView;
@property (weak, nonatomic) IBOutlet UIImageView *currentScoreView;
@property (nonatomic) float rating; //0.0 ~ 1.0

-(void) updateRatingItemView:(ExternalRating *)extRating;

@end
