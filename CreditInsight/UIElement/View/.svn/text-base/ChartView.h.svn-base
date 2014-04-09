//
//  ChartView.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/3/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChartView;
@class CommonChart;

@protocol ChartViewDelegate <NSObject>

@property (assign, nonatomic) BOOL isZooming;

- (void)zoomingChart:(ChartView *)chartView;

@end

#define kChartWidth 675
#define kChartHeight 485

@interface ChartView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblLeftTitleofChartView; // For custom to use
@property (weak, nonatomic) IBOutlet UILabel *lblChartName;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteChart;
@property (weak, nonatomic) IBOutlet UIView *chartContainerView;
@property (weak, nonatomic) IBOutlet UIButton *btnConvert;
@property (weak, nonatomic) IBOutlet UIButton *btnZoom;
@property (weak, nonatomic) IBOutlet UIView *titleView;

@property (weak, nonatomic) IBOutlet UIView *chartView;

@property (weak, nonatomic) id<ChartViewDelegate> delegate;
@property (assign, nonatomic) BOOL isChartView;
@property (strong, nonatomic) CommonChart *commonChart;

@end
