//
//  ReportsViewerHeaderTableView.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/9/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "ReportsViewerHeaderTableView.h"
#import "ReportsViewerHeaderTableCell.h"
#import "SeriesDeleteButton.h"
#import "Series.h"
#import "Category.h"

#define kBtnDeleteSeriesWith 28.0

@implementation ReportsViewerHeaderTableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
  self.delegate = self;
  self.dataSource = self;
  _isEditing = NO;
  _isDefaultData = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (_isDefaultData) {
    self.categoryArray = [self defaultCategoryArray];
  } 
  
  return [self.categoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"ReportsViewerHeaderTableCell";
  
  ReportsViewerHeaderTableCell *reportsViewerHeaderTableCell = (ReportsViewerHeaderTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (reportsViewerHeaderTableCell == nil) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ReportsViewerHeaderTableCell" owner:self options:nil];
    if ([nibs count] > 0) {
      reportsViewerHeaderTableCell = [nibs objectAtIndex:0];
    } else {
      NSLog(@"Load ReportsViewerHeaderTableCell Fail");
    }
  }
  
  reportsViewerHeaderTableCell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  Category *currentCategory = [self.categoryArray objectAtIndex:indexPath.row];
  
  reportsViewerHeaderTableCell.lblCategoryName.text = currentCategory.categoryName;
  NSMutableArray *seriesArray = currentCategory.seriesArray;
  
  for (UIView *view in [reportsViewerHeaderTableCell.seriesScrollView subviews]) {
    [view removeFromSuperview];
  }
  
  [self handleDefaultSeries:seriesArray];
  
 CGFloat newSeriesOrignX = 0.0;  
  for (Series *series in seriesArray) {
    UIView *seriesView = [self generateSeriesView:series isEditing:_isEditing orignX:newSeriesOrignX currentCategoryIndex:indexPath.row];
    [reportsViewerHeaderTableCell.seriesScrollView addSubview:seriesView];
    newSeriesOrignX = seriesView.frame.origin.x + seriesView.frame.size.width;
    reportsViewerHeaderTableCell.seriesScrollView.contentSize = CGSizeMake(newSeriesOrignX, reportsViewerHeaderTableCell.seriesScrollView.frame.size.height);
  }
  
  return reportsViewerHeaderTableCell;
}

- (UIView *)generateSeriesView:(Series *)series isEditing:(BOOL)isEditing orignX:(CGFloat)orignX currentCategoryIndex:(NSUInteger)currentCategoryIndex {
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
  UIFont *font = [UIFont fontWithName:@"Helvetica" size:16.0];
  
  CGSize size = CGSizeMake(600, 30);
  CGSize labelSize = [series.seriesName sizeWithFont:font constrainedToSize:size];
  
  label.frame = CGRectMake(0, 0, labelSize.width, 30);
  label.textColor = [UIColor darkGrayColor];
  label.text = series.seriesName;
  label.font = font;
  
  UIImage *btnDeleteImg = [UIImage imageNamed:@"DeleteCategoriesBtn"];
  SeriesDeleteButton *btnDeleteSeries = [[SeriesDeleteButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
  [btnDeleteSeries setImage:btnDeleteImg forState:UIControlStateNormal];
  btnDeleteSeries.seriesToDelete = series;
  btnDeleteSeries.currentCategoryIndex = currentCategoryIndex;
  [btnDeleteSeries addTarget:self action:@selector(deleteSeries:) forControlEvents:UIControlEventTouchUpInside];
  
  btnDeleteSeries.frame = CGRectMake(label.frame.size.width, 0, kBtnDeleteSeriesWith, kBtnDeleteSeriesWith);
  
  if (!isEditing || [series.seriesName isEqualToString:@"ALL"]) {
    btnDeleteSeries.hidden = YES;
    btnDeleteSeries.enabled = NO;
  } else {
    btnDeleteSeries.hidden = NO;
    btnDeleteSeries.enabled = YES;
  }
  
  // There is a bug. In fact it should not viewWith*index. Because viewWith is not consistent.
  CGFloat viewWidth = label.frame.size.width + btnDeleteSeries.frame.size.width + 10;
  view.frame = CGRectMake(orignX, 0, viewWidth, 30);
  
  [view addSubview:label];
  [view addSubview:btnDeleteSeries];
  
  return view;
}

/*!
 When there are series, display series. Else display ALL.
 */
- (void)handleDefaultSeries:(NSMutableArray *)seriesArray {
  Series *defaultSeries = nil;
  for (Series *series in seriesArray) {
    if ([series.seriesName isEqualToString:@"ALL"]) {
      defaultSeries = series;
    }
  }
  
  if ([seriesArray containsObject:defaultSeries]) {
    [seriesArray removeObject:defaultSeries];
  }
  
  if ([seriesArray count] == 0) {
    [seriesArray addObject:[self defaultSeries]];
  }
}

- (void)deleteSeries:(id)sender {
  SeriesDeleteButton *deleteBtn = (SeriesDeleteButton *)sender;  
  Category *currentCategory = [self.categoryArray objectAtIndex:deleteBtn.currentCategoryIndex];
  NSMutableArray *seriesArray = currentCategory.seriesArray;
  
  [seriesArray removeObject:deleteBtn.seriesToDelete];
  
  [self reloadData];
}

- (Series *)defaultSeries {
  Series *series = [[Series alloc] init];
  series.seriesId = @"0";
  series.seriesName = @"ALL";
  
  return series;
}

- (NSMutableArray *)defaultCategoryArray {
  NSMutableArray *defaultArray = [NSMutableArray array];
  
  for (Category *category in self.categoryArray) {
    category.seriesArray = [NSMutableArray arrayWithObjects:[self defaultSeries], nil];
    [defaultArray addObject:category];
  }
  
  return defaultArray;
}

@end

