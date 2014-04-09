//
//  ExternalRatingView.m
//  CreditInsight
//
//  Created by wang liang on 1/11/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "ExternalRatingView.h"
#import "ExternalRatingItemView.h"
#import "ExternalRating.h"

@implementation ExternalRatingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ExternalRatingView" owner:self options:nil];
        if (nibs) {
            self = [nibs objectAtIndex:0];
            self.frame = frame;
        }
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    for (int i = 0; i < [self.extRatings count]; ++i) {
        ExternalRatingItemView *itemView = [[ExternalRatingItemView alloc] initWithFrame:CGRectMake(0, ExternalRatingItemViewHeight * i, ExternalRatingItemViewWidth, ExternalRatingItemViewHeight)];
        [itemView updateRatingItemView:[self.extRatings objectAtIndex:i]];
        [self.scrollView addSubview:itemView];
    }
    self.scrollView.contentSize = CGSizeMake(ExternalRatingItemViewWidth, [self.extRatings count] * ExternalRatingItemViewHeight);
  
  [_lblExternalRating setText:NSLocalizedString(@"ExternalRating",nil)];
}

@end
