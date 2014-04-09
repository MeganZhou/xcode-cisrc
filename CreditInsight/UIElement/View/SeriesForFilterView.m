//
//  SeriesForFilterView.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/7/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "SeriesForFilterView.h"
#import "ReportsViewerHeaderTableView.h"
#import "Series.h"
#import "Category.h"
#import "DashboardOperations.h"
#import "NSMutableArray+Extension.h"
#import "ReportsViewerViewController.h"

@interface SeriesForFilterView()

@property (nonatomic) int head;  //index of current category in array.
@property (nonatomic) NSMutableArray *labelRadians;
@property (nonatomic) BOOL inAnimation;

@property (weak, nonatomic) IBOutlet UIButton *btnAddOrDelete;
@property (weak, nonatomic) IBOutlet UIImageView *btnAddOrDeleteImg;
@property (strong, nonatomic) NSMutableArray *viewableLabels; // 5 viewable labels in circle, like a half of clock

@property (assign, nonatomic) BOOL isAdd;
@property (strong, nonatomic) NSMutableArray *seriesNames;
@property (assign, nonatomic) Series *selectedSeries;
@property (strong, nonatomic) NSMutableArray *seriesArray;
@property (assign, nonatomic) NSString *selectedCategoryName;

@end

#define SERIES_MIN_CATEGORY_SIZE 10
#define SERIES_CATEGORY_PLACEHOLDER @""
#define SERIES_RADIUS 75
#define SERIES_CIRCLE_CENTER_X 174
#define SERIES_CIRCLE_CENTER_Y 204
#define SERIES_ZERO_RADIUS 0.00

@implementation SeriesForFilterView

CGFloat _lastRotate = 0.0;
CGFloat _radianStep = M_PI / 5;
CGFloat _initRadian = 0;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"SeriesForFilterView" owner:self options:nil];
    
    if (nibs) {
      self = [nibs objectAtIndex:0];
      self.frame = frame;
    }
  }
  return self;
}

- (void)initSeriesView {
  self.isAdd = YES;
  [self initSeries];
  [self initLabels];
}


- (void)initSeries {
  _seriesNames = [NSMutableArray array];
  DashboardOperations *dashboardOperation = [[DashboardOperations alloc] init];
  if ([_selectedCategory.categoryName isEqualToString:NSLocalizedString(@"Credit Control Area", nil)]) {
    _seriesNames = [NSMutableArray arrayWithArray:[dashboardOperation queryAllArea]];
  } else if ([_selectedCategory.categoryName isEqualToString:NSLocalizedString(@"Company Code", nil)]) {
    NSArray *companyArray = [dashboardOperation queryCompanyByArea:[self constructQueryCondition:NSLocalizedString(@"Credit Control Area", nil)]];
    _seriesNames = [NSMutableArray arrayWithArray:companyArray];
  } else if ([_selectedCategory.categoryName isEqualToString:NSLocalizedString(@"Customer", nil)]) {
    _seriesNames = [NSMutableArray arrayWithArray:[self customerArray]];
  } else if ([_selectedCategory.categoryName isEqualToString:NSLocalizedString(@"Timeline", nil)]) {
    _seriesNames = [NSMutableArray arrayWithObjects:@"2012-01", @"2012-02", @"2012-03", @"2012-04", @"2012-05", @"2012-06", @"2012-07", @"2012-08", nil];
  } else {
    // Do Nothing
  }
  
  NSMutableArray *tempSeriesArray = [NSMutableArray array];
  for (NSString *seriesName in _seriesNames) {
    Series *series = [[Series alloc] init];
    series.seriesId = @"";
    series.seriesName = seriesName;
    [tempSeriesArray addObject:series];
  }
  
  _seriesArray = [NSArray arrayWithArray:tempSeriesArray];  
 
  //if categories' size is less than 10, expand to 10
  int cnt = [self.seriesNames count];
  if (cnt < SERIES_MIN_CATEGORY_SIZE) {
    for (int i = 0; i < SERIES_MIN_CATEGORY_SIZE - cnt; i++) {
      [self.seriesNames addObject:SERIES_CATEGORY_PLACEHOLDER];
    }
  }
  self.head = 0;
}

- (void)updateLabel:(UILabel *)label radian:(CGFloat)radian {
  CGPoint center = CGPointMake(SERIES_CIRCLE_CENTER_X - SERIES_RADIUS * cos(radian), SERIES_CIRCLE_CENTER_Y - SERIES_RADIUS * sin(radian));
  label.layer.anchorPoint = CGPointMake(1, 0.5);
  label.layer.position = center;
  label.layer.bounds = CGRectMake(0, 0, 90, 50);
  
  if (fabs(center.x - (SERIES_CIRCLE_CENTER_X - SERIES_RADIUS)) < 0.01 && fabs(center.y - SERIES_CIRCLE_CENTER_Y) < 0.01) {
    label.textColor = [UIColor colorWithRed:255.0/255.0 green:206.0/255.0 blue:56/255.0 alpha:1.0];
    for (Series *series in _seriesArray) {
      if ([series.seriesName isEqualToString:label.text]) {
        _selectedSeries = series;
      }
    }
    
    if ([[self currentSerriesArray] isContainObject:self.selectedSeries]) {
      [self setButtonToDelete];
    } else {
      [self setButtonToAdd];
    }
    
    // If series is ALL, it needn't to add.
    if ([self.selectedSeries.seriesName isEqualToString:@"ALL"]) {
      self.btnAddOrDelete.enabled = NO;
      self.btnAddOrDeleteImg.hidden = YES;
    } else {
      self.btnAddOrDelete.enabled = YES;
      self.btnAddOrDeleteImg.hidden = NO;
    }
    
  } else {
    label.textColor = [UIColor whiteColor];
  }
  
  label.transform = CGAffineTransformMakeRotation(radian);
}


-(void)initLabels
{
  self.viewableLabels = [NSMutableArray array];
  self.labelRadians = [NSMutableArray array];
  
  for (UIView *view in [self subviews]) {
    if ([view isKindOfClass:[UILabel class]]) {
      [view removeFromSuperview];
    }    
  }
  
  for (int i = 0; i < SERIES_MIN_CATEGORY_SIZE; ++i) {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.numberOfLines = 0;
//    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentRight;
    label.userInteractionEnabled = YES;
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateLabel:)];
    tap.maximumNumberOfTouches = 1;
    [label addGestureRecognizer:tap];
    [label setBackgroundColor:[UIColor clearColor]];
    CGFloat currentRadian = _initRadian + i * _radianStep;
    label.text = [self.seriesNames objectAtIndex:i];
    
    [self updateLabel:label radian:currentRadian];
    
    [self.labelRadians addObject:[NSNumber numberWithFloat:currentRadian]];
    [self.viewableLabels addObject:label];
    [self addSubview:label];
  }
  
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
  self.inAnimation = NO;
}

-(void)move:(CGFloat)deltaRadian
{
  for (int i = 0; i < [self.viewableLabels count]; i++) {
    //update radian
    CGFloat currentRadian = [[self.labelRadians objectAtIndex:i] floatValue];
    currentRadian = currentRadian - deltaRadian;
    
    if (currentRadian < 0) {
      currentRadian += 2 * M_PI;
    }
    
    [self.labelRadians replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:currentRadian]];
  }
  
  //update animation
  self.inAnimation = YES;
  [UIView beginAnimations:nil context:nil];
  
  [UIView animateWithDuration:0.3
                   animations:^(void){
                     for (int i = 0; i < [self.viewableLabels count]; i++){
                       UILabel *label = [self.viewableLabels objectAtIndex:i];
                       CGFloat currentRadian = [[self.labelRadians objectAtIndex:i] floatValue];
                       [self updateLabel:label radian:currentRadian];
                     }}
                   completion:^(BOOL finished){
                     self.inAnimation = NO;
                   }];
  
  [UIView commitAnimations];
}

- (void)rotateLabel:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        CGPoint tranlation = [panGesture translationInView:self];
        if (!self.inAnimation) {
            if (tranlation.y > 0) {
                [self move:_radianStep];
            }
            if (tranlation.y < 0) {
                [self move:-_radianStep];
            }
        }
    }
}

- (IBAction)addOrDeleteButtonClicked:(id)sender {
  if (_isAdd) {
    [self setButtonToDelete];
    [self addSeriesToHeaderTable];
  } else {
    [self setButtonToAdd];
    [self removeSeriesFromHeaderTable];
  }
}

- (void)setButtonToAdd {
  _isAdd = YES;
  _btnAddOrDeleteImg.image = [UIImage imageNamed:@"filter_add"];
}

- (void)setButtonToDelete {
  _isAdd = NO;
  _btnAddOrDeleteImg.image = [UIImage imageNamed:@"filter_del"];
}

- (void)addSeriesToHeaderTable {
  NSMutableArray *seriesArray = [NSMutableArray arrayWithArray:[self currentSerriesArray]];
  [seriesArray addObject:_selectedSeries];
  
  [self updateCategory:seriesArray];
}

- (void)removeSeriesFromHeaderTable {
  NSMutableArray *seriesArray = [NSMutableArray arrayWithArray:[self currentSerriesArray]];
  Series *seriesToDelete = [[Series alloc] init];
  
  for (Series *series in seriesArray) {
    if ([series.seriesName isEqualToString:_selectedSeries.seriesName]) {
      seriesToDelete = series;
    }
  }
  
  [seriesArray removeObject:seriesToDelete];
  
  [self updateCategory:seriesArray];
}

- (void)updateCategory:(NSMutableArray *)seriesArray {
  Category *selectCategory = [_selectedCategory copy];
  selectCategory.seriesArray = seriesArray;
  [self updateFilterArray:selectCategory];
}

- (void)updateFilterArray:(Category *)newlyCategory{
  Category *categoryToDelete = nil;
  
  for (Category *category in self.headerTableView.categoryArray) {
    if ([category.categoryName isEqualToString:_selectedCategory.categoryName]) {
      categoryToDelete = category;
    }
  }
  
  NSUInteger index =  [self.headerTableView.categoryArray indexOfObject:categoryToDelete];
  NSIndexSet *indexset = [[NSIndexSet alloc] initWithIndex:index];
  
  [self.headerTableView.categoryArray replaceObjectsAtIndexes:indexset withObjects:[NSArray arrayWithObjects:newlyCategory, nil]];
  
  self.headerTableView.isEditing = YES;
  self.headerTableView.isDefaultData = NO;  
  [self.headerTableView reloadData];  
  
  if ([[self constructQueryCondition:NSLocalizedString(@"Customer", nil)] count] != 0) {
    [self.reportsViewerController refreshReportView:[self constructQueryCondition:NSLocalizedString(@"Customer", nil)]];
  } else {
    [self.reportsViewerController refreshReportView:[self customerArray]];
  }
}

- (NSArray *)constructQueryCondition:(NSString *)categoryName {
  NSMutableArray *array = [NSMutableArray array];
  for (Category *category in self.headerTableView.categoryArray) {
    if([category.categoryName isEqualToString:categoryName]) {
      for (Series *series in category.seriesArray) {
        if (![series.seriesName isEqualToString:@"ALL"]) {
          [array addObject:series.seriesName];
        }
      }
    }
  }
  
//  NSLog(@"seriesfilter: constructQueryCondition: categoryName == %@, array == %@", categoryName, array);
  return [NSArray arrayWithArray:array];
}

- (NSArray *)customerArray {
  DashboardOperations *dashboardOperation = [[DashboardOperations alloc] init];
  NSArray *companyArray = [self constructQueryCondition:NSLocalizedString(@"Company Code", nil)];
  NSArray *areaArray = [self constructQueryCondition:NSLocalizedString(@"Credit Control Area", nil)];
  NSArray *customerArray = nil;
  
  if ([companyArray count] != 0) {
    customerArray = [dashboardOperation queryCustomerByCompanyOrArea:companyArray column:@"ZCOMPANY"];
  } else if (([companyArray count] == 0) && ([areaArray count] != 0)) {
    customerArray = [dashboardOperation queryCustomerByCompanyOrArea:areaArray column:@"ZAREA"];
  } else {
    // By default, select all customer.
    customerArray = [dashboardOperation queryCustomerByCompanyOrArea:nil column:@""];
  }
  
//  NSLog(@"seriesfilter: customerArray: array == %@", customerArray);
  return customerArray;
}

- (NSMutableArray *)currentSerriesArray {
  NSMutableArray *seriesArray = nil;
  
  for (Category *category in self.headerTableView.categoryArray) {
    if ([category.categoryName isEqualToString:_selectedCategory.categoryName]) {
      seriesArray = category.seriesArray;
    }
  }
  
  return seriesArray;
}

@end
