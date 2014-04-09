//
//  CategoriesForFilterView.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/7/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeriesForFilterView.h"

@protocol CategoriesForFilterViewDelegate <NSObject>

- (void)hideFilterViews;

@end

@interface CategoriesForFilterView : UIView

@property (weak, nonatomic) id<CategoriesForFilterViewDelegate> delegate;
@property (strong, nonatomic) NSArray *categories; 
@property (retain, nonatomic) SeriesForFilterView *seriesView;

@end
