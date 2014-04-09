//
//  ChartViewController2.m
//  TestMAKit
//
//  Created by wang liang on 12/19/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import "ChartViewController2.h"

@interface ChartViewController2 ()

@end

@implementation ChartViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.categoryArray = [NSArray arrayWithObjects:@"Accessories", @"Bikes", @"Clothing",
                          @"Components", nil];
    self.seriesArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:2003],
                        [NSNumber numberWithInt:2004], [NSNumber numberWithInt:2003],
                       nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    self.valueDict = dict;
    for (NSUInteger categoryIndex=0; categoryIndex<[self.categoryArray count]; categoryIndex++)
    {
        for (NSUInteger seriesIndex =0; seriesIndex <[self. seriesArray count]; seriesIndex ++)
        {
            NSUInteger indexes[] = {categoryIndex, seriesIndex};
            NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
            double value = (int)random() % 10000;
            [self.valueDict setObject:[NSNumber numberWithDouble:value] forKey:indexPath];
        }
    }
    
    //create chart
    MAChartView *aChart = [[MAChartView alloc] initWithFrame:CGRectZero];
    self.chart = aChart;
    MAKitTheme_WelterWeight *aTheme = [[MAKitTheme_WelterWeight alloc] init];
    self.chart.theme = aTheme;
    self.chart.tag = 1;
    self.chart.identifier =@"chart";
    self.chart.contentMode = UIViewContentModeRedraw;
    self.chart.showsSelectedDataLabel = NO;
    self.chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.chart.dataSource = self;
    self.chart.delegate = self;
    self.chart.userInteractionEnabled = NO;
    [self.view addSubview:self.chart];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.chart.frame = self.view.bounds;
    [self.chart refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)titleForChartView:(MAChartView *)chartView
{
    return @"Company Sales Data";
}

-(NSUInteger)chartView:(MAChartView *)chartView chartTypeForChartLayer:(NSUInteger)layerIndex
{
    return MAChartLayerTypeColumn;
}

- (NSUInteger)chartView:(MAChartView *)chartView numberOfCategoriesInLevel:(NSUInteger)categoryLevelIndex {
    return [self.categoryArray count];
}

- (id)chartView:(MAChartView *)chartView categoryAtIndex:(NSUInteger)categoryIndex inCategoryLevel:(NSUInteger)categoryLevelIndex
{
    return [self.categoryArray objectAtIndex:categoryIndex];
}

- (NSUInteger)numberOfSeriesInChartView:(MAChartView *)chartView
{
    return [self.seriesArray count];
}
- (id)chartView:(MAChartView *)chartView seriesAtIndex:(NSUInteger)seriesIndex
{
    return [self. seriesArray objectAtIndex: seriesIndex];
}

- (id)chartView:(MAChartView *)chartView valueAtDimension:(NSUInteger)valueDimensionIndex
    forCategory:(NSUInteger)categoryIndex inCategoryLevel:(NSUInteger)categoryLevelIndex
      andSeries:(NSUInteger)seriesIndex
{
    NSUInteger indexes[] = {categoryIndex, seriesIndex};
    NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    return [self.valueDict objectForKey:indexPath];
}

@end
