//
//  SeriesForFilterView.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/7/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReportsViewerHeaderTableView;
@class ReportsViewerViewController;
@class Category;

@interface SeriesForFilterView : UIView

@property (strong, nonatomic) ReportsViewerHeaderTableView *headerTableView;
@property (strong, nonatomic) Category *selectedCategory;
@property (strong, nonatomic) ReportsViewerViewController *reportsViewerController;

- (void)initSeriesView;

@end


