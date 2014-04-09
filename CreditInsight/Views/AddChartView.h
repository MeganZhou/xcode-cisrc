//
//  AddChartView.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/2/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddChartDelegate <NSObject>

- (void)addCharts:(NSArray *)reports;

@end

@interface AddChartView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *chartsTableView;
@property (weak, nonatomic) id<AddChartDelegate> delegate;

@end

@interface AddChartView () {
  NSMutableArray *sectionHeaderNames;
//  NSDictionary *reportCategoryDict;
}

@property (retain, nonatomic) NSArray *reportsArray;

@end